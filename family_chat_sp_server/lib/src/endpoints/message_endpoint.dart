import 'dart:async';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/role_checker.dart';

/// Endpoints for message CRUD, reactions, read receipts and real-time streaming.
class MessageEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // ──────────────────────────────────────────────────────────────────────────
  // CRUD
  // ──────────────────────────────────────────────────────────────────────────

  /// Sends a new message to [chatId].
  ///
  /// At least one of [text], [imageUrl] or [fileUrl] must be provided.
  Future<ChatMessage> sendMessage(
    Session session,
    int chatId, {
    String? text,
    String? imageUrl,
    String? fileUrl,
    String? fileName,
    int? fileSize,
  }) async {
    final caller = await getAuthenticatedAppUser(session);

    await _requireMembership(session, chatId, caller.id!);
    await _requireChatNotArchived(session, chatId);

    if (text == null && imageUrl == null && fileUrl == null) {
      throw ArgumentError(
        'Message must have at least text, imageUrl or fileUrl',
      );
    }

    final now = DateTime.now().toUtc();
    final message = ChatMessage(
      chatId: chatId,
      senderUserId: caller.id!,
      text: text != null && text.length > 1024 ? text.substring(0, 1024) : text,
      imageUrl: imageUrl,
      fileUrl: fileUrl,
      fileName: fileName,
      fileSize: fileSize,
      isDeleted: false,
      isEdited: false,
      createdAt: now,
    );

    final saved = await ChatMessage.db.insertRow(session, message);

    // Update chat's updatedAt.
    final chat = await Chat.db.findById(session, chatId);
    if (chat != null) {
      chat.updatedAt = now;
      await Chat.db.updateRow(session, chat);
    }

    // Broadcast the new message event to all chat members.
    final event = ChatStreamEvent(
      type: 'newMessage',
      chatId: chatId,
      message: saved,
    );
    await session.messages.postMessage('chat_$chatId', event);

    return saved;
  }

  /// Edits the text of an existing message.
  ///
  /// Only the original sender may edit their own messages.
  Future<ChatMessage> editMessage(
    Session session,
    int messageId,
    String newText,
  ) async {
    final caller = await getAuthenticatedAppUser(session);

    final message = await ChatMessage.db.findById(session, messageId);
    if (message == null) throw Exception('Message not found: $messageId');
    if (message.isDeleted) throw Exception('Cannot edit a deleted message');
    if (message.senderUserId != caller.id) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }

    message.text = newText.length > 1024 ? newText.substring(0, 1024) : newText;
    message.isEdited = true;
    message.editedAt = DateTime.now().toUtc();

    final updated = await ChatMessage.db.updateRow(session, message);

    final event = ChatStreamEvent(
      type: 'messageEdited',
      chatId: message.chatId,
      message: updated,
    );
    await session.messages.postMessage('chat_${message.chatId}', event);

    return updated;
  }

  /// Soft-deletes a message by setting [isDeleted] = true.
  ///
  /// Only the original sender or an admin may delete a message.
  Future<void> deleteMessage(Session session, int messageId) async {
    final caller = await getAuthenticatedAppUser(session);

    final message = await ChatMessage.db.findById(session, messageId);
    if (message == null) throw Exception('Message not found: $messageId');

    final isAdmin = await hasRole(session, UserRole.admin);
    if (message.senderUserId != caller.id && !isAdmin) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }

    message.isDeleted = true;
    message.editedAt = DateTime.now().toUtc();
    await ChatMessage.db.updateRow(session, message);

    final event = ChatStreamEvent(
      type: 'messageDeleted',
      chatId: message.chatId,
      message: message,
    );
    await session.messages.postMessage('chat_${message.chatId}', event);
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Reactions
  // ──────────────────────────────────────────────────────────────────────────

  /// Adds an emoji reaction to a message.
  Future<MessageReaction> addReaction(
    Session session,
    int messageId,
    String emoji,
  ) async {
    final caller = await getAuthenticatedAppUser(session);

    final message = await ChatMessage.db.findById(session, messageId);
    if (message == null) throw Exception('Message not found: $messageId');
    if (message.isDeleted) {
      throw Exception('Cannot react to a deleted message');
    }

    await _requireMembership(session, message.chatId, caller.id!);

    // Check for duplicate reaction.
    final existing = await MessageReaction.db.findFirstRow(
      session,
      where: (t) =>
          t.messageId.equals(messageId) &
          t.userId.equals(caller.id!) &
          t.emoji.equals(emoji),
    );
    if (existing != null) return existing;

    final reaction = MessageReaction(
      messageId: messageId,
      userId: caller.id!,
      emoji: emoji,
      createdAt: DateTime.now().toUtc(),
    );
    final saved = await MessageReaction.db.insertRow(session, reaction);

    final event = ChatStreamEvent(
      type: 'reactionAdded',
      chatId: message.chatId,
      reaction: saved,
    );
    await session.messages.postMessage('chat_${message.chatId}', event);

    return saved;
  }

  /// Removes an emoji reaction from a message.
  Future<void> removeReaction(
    Session session,
    int messageId,
    String emoji,
  ) async {
    final caller = await getAuthenticatedAppUser(session);

    final message = await ChatMessage.db.findById(session, messageId);
    if (message == null) throw Exception('Message not found: $messageId');

    final reaction = await MessageReaction.db.findFirstRow(
      session,
      where: (t) =>
          t.messageId.equals(messageId) &
          t.userId.equals(caller.id!) &
          t.emoji.equals(emoji),
    );
    if (reaction == null) return;

    await MessageReaction.db.deleteRow(session, reaction);

    final event = ChatStreamEvent(
      type: 'reactionRemoved',
      chatId: message.chatId,
      reaction: reaction,
    );
    await session.messages.postMessage('chat_${message.chatId}', event);
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Read receipts
  // ──────────────────────────────────────────────────────────────────────────

  /// Marks all messages up to and including [lastReadMessageId] as read for
  /// the caller in the given chat.
  Future<void> markAsRead(
    Session session,
    int chatId,
    int lastReadMessageId,
  ) async {
    final caller = await getAuthenticatedAppUser(session);

    final membership = await ChatMember.db.findFirstRow(
      session,
      where: (t) => t.chatId.equals(chatId) & t.userId.equals(caller.id!),
    );
    if (membership == null) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }

    membership.lastReadMessageId = lastReadMessageId;
    await ChatMember.db.updateRow(session, membership);

    // Update/insert MessageStatus records for all messages up to the given ID.
    final unread = await ChatMessage.db.find(
      session,
      where: (t) =>
          t.chatId.equals(chatId) &
          (t.id <= lastReadMessageId) &
          t.isDeleted.equals(false),
    );

    final now = DateTime.now().toUtc();
    for (final msg in unread) {
      final existing = await MessageStatus.db.findFirstRow(
        session,
        where: (t) => t.messageId.equals(msg.id!) & t.userId.equals(caller.id!),
      );
      if (existing != null) {
        existing.status = 'read';
        existing.updatedAt = now;
        await MessageStatus.db.updateRow(session, existing);
      } else {
        await MessageStatus.db.insertRow(
          session,
          MessageStatus(
            messageId: msg.id!,
            userId: caller.id!,
            status: 'read',
            updatedAt: now,
          ),
        );
      }
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Pagination
  // ──────────────────────────────────────────────────────────────────────────

  /// Returns up to [limit] messages in [chatId], ordered newest-first.
  ///
  /// Pass [beforeMessageId] to page backwards (load older messages).
  Future<List<ChatMessage>> getMessages(
    Session session,
    int chatId, {
    int? beforeMessageId,
    int limit = 50,
  }) async {
    final caller = await getAuthenticatedAppUser(session);
    await _requireMembership(session, chatId, caller.id!);

    final messages = await ChatMessage.db.find(
      session,
      where: (t) => beforeMessageId != null
          ? t.chatId.equals(chatId) & (t.id < beforeMessageId)
          : t.chatId.equals(chatId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: limit,
    );

    return messages;
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Streaming
  // ──────────────────────────────────────────────────────────────────────────

  /// Real-time stream of [ChatStreamEvent]s for a given chat.
  ///
  /// The client keeps this open; the server pushes events via the message bus.
  Stream<ChatStreamEvent> chatStream(Session session, int chatId) async* {
    final caller = await getAuthenticatedAppUser(session);
    await _requireMembership(session, chatId, caller.id!);

    final controller = StreamController<ChatStreamEvent>();

    void listener(SerializableModel msg) {
      if (msg is ChatStreamEvent && !controller.isClosed) {
        controller.add(msg);
      }
    }

    session.messages.addListener('chat_$chatId', listener);

    try {
      await for (final event in controller.stream) {
        yield event;
      }
    } finally {
      session.messages.removeListener('chat_$chatId', listener);
      await controller.close();
    }
  }

  /// Broadcasts a typing indicator to all other members of a chat.
  Future<void> sendTypingIndicator(Session session, int chatId) async {
    final caller = await getAuthenticatedAppUser(session);
    await _requireMembership(session, chatId, caller.id!);

    final event = ChatStreamEvent(
      type: 'typing',
      chatId: chatId,
      userId: caller.id,
    );
    await session.messages.postMessage('chat_$chatId', event);
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Internal helpers
  // ──────────────────────────────────────────────────────────────────────────

  Future<void> _requireMembership(
    Session session,
    int chatId,
    int userId,
  ) async {
    final membership = await ChatMember.db.findFirstRow(
      session,
      where: (t) => t.chatId.equals(chatId) & t.userId.equals(userId),
    );
    if (membership == null) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }
  }

  Future<void> _requireChatNotArchived(Session session, int chatId) async {
    final chat = await Chat.db.findById(session, chatId);
    if (chat == null) throw Exception('Chat not found: $chatId');
    if (chat.isArchived) {
      throw Exception('Cannot send messages to an archived chat');
    }
  }
}
