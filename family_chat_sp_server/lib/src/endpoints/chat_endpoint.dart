import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/role_checker.dart';

/// Endpoints for chat management (group chats, direct chats, settings).
class ChatEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // ──────────────────────────────────────────────────────────────────────────
  // Create chats
  // ──────────────────────────────────────────────────────────────────────────

  /// Creates a new group chat.
  ///
  /// Restricted to users with Master or Admin role.
  /// [memberIds] are the initial participant user IDs (caller is auto-added).
  Future<Chat> createGroupChat(
    Session session,
    String name,
    List<int> memberIds,
    List<UserRole> allowedRoles,
  ) async {
    final caller = await getAuthenticatedAppUser(session);

    final allowed =
        await hasAnyRole(session, [UserRole.admin, UserRole.master]);
    if (!allowed) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }

    final now = DateTime.now().toUtc();
    final chat = Chat(
      name: name,
      isGroup: true,
      ownerUserId: caller.id,
      backgroundId: 'default',
      textColor: '#FFFFFF',
      isArchived: false,
      createdAt: now,
      updatedAt: now,
    );
    final savedChat = await Chat.db.insertRow(session, chat);

    // Add all requested members, auto-include caller.
    final allMemberIds = {...memberIds, caller.id!}.toList();
    for (final uid in allMemberIds) {
      await ChatMember.db.insertRow(
        session,
        ChatMember(
          chatId: savedChat.id!,
          userId: uid,
          joinedAt: now,
        ),
      );
    }

    return savedChat;
  }

  /// Returns the existing direct chat between the caller and [otherUserId],
  /// or creates one if it doesn't exist.
  Future<Chat> createOrGetDirectChat(
    Session session,
    int otherUserId,
  ) async {
    final caller = await getAuthenticatedAppUser(session);

    // Find existing direct chat between these two users.
    final callerMemberships = await ChatMember.db.find(
      session,
      where: (t) => t.userId.equals(caller.id!),
    );
    for (final membership in callerMemberships) {
      final chat = await Chat.db.findById(session, membership.chatId);
      if (chat == null || chat.isGroup) continue;

      final otherMembership = await ChatMember.db.findFirstRow(
        session,
        where: (t) =>
            t.chatId.equals(membership.chatId) &
            t.userId.equals(otherUserId),
      );
      if (otherMembership != null) return chat;
    }

    // Create a new direct chat.
    final otherUser = await AppUser.db.findById(session, otherUserId);
    if (otherUser == null) {
      throw Exception('User not found: $otherUserId');
    }

    final now = DateTime.now().toUtc();
    final chatName = '${caller.name} & ${otherUser.name}';
    final chat = Chat(
      name: chatName,
      isGroup: false,
      ownerUserId: null,
      backgroundId: 'default',
      textColor: '#FFFFFF',
      isArchived: false,
      createdAt: now,
      updatedAt: now,
    );
    final savedChat = await Chat.db.insertRow(session, chat);

    await ChatMember.db.insertRow(
      session,
      ChatMember(chatId: savedChat.id!, userId: caller.id!, joinedAt: now),
    );
    await ChatMember.db.insertRow(
      session,
      ChatMember(chatId: savedChat.id!, userId: otherUserId, joinedAt: now),
    );

    return savedChat;
  }

  // ──────────────────────────────────────────────────────────────────────────
  // List & details
  // ──────────────────────────────────────────────────────────────────────────

  /// Returns all chats the caller belongs to, with last-message preview and
  /// unread count.
  Future<List<ChatListItem>> listMyChats(Session session) async {
    final caller = await getAuthenticatedAppUser(session);

    final memberships = await ChatMember.db.find(
      session,
      where: (t) => t.userId.equals(caller.id!),
    );

    final result = <ChatListItem>[];

    for (final membership in memberships) {
      final chat = await Chat.db.findById(session, membership.chatId);
      if (chat == null || chat.isArchived) continue;

      // Latest message.
      final latestMessages = await ChatMessage.db.find(
        session,
        where: (t) =>
            t.chatId.equals(membership.chatId) &
            t.isDeleted.equals(false),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: 1,
      );

      String? lastMessageText;
      DateTime? lastMessageTime;
      if (latestMessages.isNotEmpty) {
        final msg = latestMessages.first;
        lastMessageTime = msg.createdAt;
        if (msg.text != null) {
          lastMessageText = msg.text;
        } else if (msg.imageUrl != null) {
          lastMessageText = '[изображение]';
        } else if (msg.fileUrl != null) {
          lastMessageText = '[файл: ${msg.fileName ?? ""}]';
        }
      }

      // Unread count.
      int unreadCount;
      if (membership.lastReadMessageId != null) {
        unreadCount = await ChatMessage.db.count(
          session,
          where: (t) =>
              t.chatId.equals(membership.chatId) &
              (t.id > membership.lastReadMessageId!) &
              t.isDeleted.equals(false),
        );
      } else {
        unreadCount = await ChatMessage.db.count(
          session,
          where: (t) =>
              t.chatId.equals(membership.chatId) &
              t.isDeleted.equals(false),
        );
      }

      // For a direct chat, use the other user's avatar colour.
      String? avatarColor = caller.avatarColor;
      if (!chat.isGroup) {
        final otherMembership = await ChatMember.db.findFirstRow(
          session,
          where: (t) =>
              t.chatId.equals(chat.id!) &
              t.userId.notEquals(caller.id!),
        );
        if (otherMembership != null) {
          final other =
              await AppUser.db.findById(session, otherMembership.userId);
          avatarColor = other?.avatarColor ?? avatarColor;
        }
      }

      result.add(ChatListItem(
        chatId: chat.id!,
        name: chat.name,
        lastMessage: lastMessageText,
        lastMessageTime: lastMessageTime,
        unreadCount: unreadCount,
        isGroup: chat.isGroup,
        avatarColor: avatarColor,
      ));
    }

    // Sort by last message time descending.
    result.sort((a, b) {
      if (a.lastMessageTime == null && b.lastMessageTime == null) return 0;
      if (a.lastMessageTime == null) return 1;
      if (b.lastMessageTime == null) return -1;
      return b.lastMessageTime!.compareTo(a.lastMessageTime!);
    });

    return result;
  }

  /// Returns the full [Chat] object for a given chat ID.
  ///
  /// Caller must be a member.
  Future<Chat> getChatDetails(Session session, int chatId) async {
    final caller = await getAuthenticatedAppUser(session);

    await _requireMembership(session, chatId, caller.id!);

    final chat = await Chat.db.findById(session, chatId);
    if (chat == null) throw Exception('Chat not found: $chatId');
    return chat;
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Settings
  // ──────────────────────────────────────────────────────────────────────────

  /// Updates chat display settings. Only the owner or an admin may call this.
  Future<Chat> updateChatSettings(
    Session session,
    int chatId, {
    String? name,
    String? backgroundId,
    String? textColor,
  }) async {
    final caller = await getAuthenticatedAppUser(session);

    final chat = await Chat.db.findById(session, chatId);
    if (chat == null) throw Exception('Chat not found: $chatId');

    final isAdmin = await hasRole(session, UserRole.admin);
    final isOwner = chat.ownerUserId == caller.id;

    if (!isAdmin && !isOwner) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }

    if (name != null) chat.name = name;
    if (backgroundId != null) chat.backgroundId = backgroundId;
    if (textColor != null) chat.textColor = textColor;
    chat.updatedAt = DateTime.now().toUtc();

    return Chat.db.updateRow(session, chat);
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Membership
  // ──────────────────────────────────────────────────────────────────────────

  /// Adds users to an existing group chat.
  ///
  /// Caller must be the owner or an admin.
  Future<void> addMembers(
    Session session,
    int chatId,
    List<int> userIds,
  ) async {
    final caller = await getAuthenticatedAppUser(session);

    final chat = await Chat.db.findById(session, chatId);
    if (chat == null) throw Exception('Chat not found: $chatId');

    final isAdmin = await hasRole(session, UserRole.admin);
    if (!isAdmin && chat.ownerUserId != caller.id) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }

    final now = DateTime.now().toUtc();
    for (final uid in userIds) {
      final existing = await ChatMember.db.findFirstRow(
        session,
        where: (t) => t.chatId.equals(chatId) & t.userId.equals(uid),
      );
      if (existing != null) continue;

      await ChatMember.db.insertRow(
        session,
        ChatMember(chatId: chatId, userId: uid, joinedAt: now),
      );
    }

    chat.updatedAt = DateTime.now().toUtc();
    await Chat.db.updateRow(session, chat);
  }

  /// Removes a user from a group chat.
  ///
  /// Caller must be the owner or an admin.
  Future<void> removeMember(
    Session session,
    int chatId,
    int userId,
  ) async {
    final caller = await getAuthenticatedAppUser(session);

    final chat = await Chat.db.findById(session, chatId);
    if (chat == null) throw Exception('Chat not found: $chatId');

    final isAdmin = await hasRole(session, UserRole.admin);
    if (!isAdmin && chat.ownerUserId != caller.id) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }

    final membership = await ChatMember.db.findFirstRow(
      session,
      where: (t) => t.chatId.equals(chatId) & t.userId.equals(userId),
    );
    if (membership == null) return;

    await ChatMember.db.deleteRow(session, membership);

    chat.updatedAt = DateTime.now().toUtc();
    await Chat.db.updateRow(session, chat);
  }

  /// The authenticated caller leaves a group chat.
  Future<void> leaveChat(Session session, int chatId) async {
    final caller = await getAuthenticatedAppUser(session);

    final membership = await ChatMember.db.findFirstRow(
      session,
      where: (t) =>
          t.chatId.equals(chatId) & t.userId.equals(caller.id!),
    );
    if (membership == null) {
      throw Exception('You are not a member of chat $chatId');
    }

    await ChatMember.db.deleteRow(session, membership);

    // If caller was the owner, notify admins that a new owner is needed.
    final chat = await Chat.db.findById(session, chatId);
    if (chat != null && chat.ownerUserId == caller.id) {
      chat.ownerUserId = null;
      chat.updatedAt = DateTime.now().toUtc();
      await Chat.db.updateRow(session, chat);

      final adminAssignments = await UserRoleAssignment.db.find(
        session,
        where: (t) => t.role.equals(UserRole.admin),
      );
      for (final a in adminAssignments) {
        await AppNotification.db.insertRow(
          session,
          AppNotification(
            recipientUserId: a.userId,
            type: 'owner_needed',
            title: 'Chat needs an owner',
            body: 'Chat "${chat.name}" no longer has an owner.',
            relatedEntityId: chat.id,
            isRead: false,
            createdAt: DateTime.now().toUtc(),
          ),
        );
      }
    }
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
}
