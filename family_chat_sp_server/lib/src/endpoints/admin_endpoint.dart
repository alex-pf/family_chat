import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/role_checker.dart';

/// Admin-only endpoints for user and chat management, plus resource monitoring.
class AdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // ──────────────────────────────────────────────────────────────────────────
  // User management
  // ──────────────────────────────────────────────────────────────────────────

  /// Creates a new AppUser record and assigns roles.
  ///
  /// The Serverpod auth account (email + password) must have been created
  /// externally (e.g. via EmailIdpEndpoint). Pass the resulting
  /// [serverpodUserId] UUID string here.
  Future<AppUser> createUser(
    Session session,
    String name,
    String email,
    List<UserRole> roles,
    String serverpodUserId,
  ) async {
    await requireAdmin(session);

    // Ensure email is unique.
    final existing = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (existing != null) {
      throw Exception('Email already registered: $email');
    }

    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts.length >= 2
        ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
        : name.isNotEmpty
        ? name[0].toUpperCase()
        : 'U';
    final color = _colorFromSeed(email);

    final adminUser = await getAuthenticatedAppUser(session);

    final appUser = AppUser(
      serverpodUserId: serverpodUserId,
      email: email,
      name: name.trim(),
      avatarColor: color,
      avatarInitials: initials,
      isBlocked: false,
      mustChangePassword: true,
      createdAt: DateTime.now().toUtc(),
    );
    final saved = await AppUser.db.insertRow(session, appUser);

    final now = DateTime.now().toUtc();
    for (final role in roles) {
      await UserRoleAssignment.db.insertRow(
        session,
        UserRoleAssignment(
          userId: saved.id!,
          role: role,
          assignedAt: now,
          assignedByUserId: adminUser.id!,
        ),
      );
    }

    return saved;
  }

  /// Blocks a user (they can no longer sign in).
  Future<void> blockUser(Session session, int userId) async {
    await requireAdmin(session);

    final user = await AppUser.db.findById(session, userId);
    if (user == null) throw Exception('User not found: $userId');

    user.isBlocked = true;
    await AppUser.db.updateRow(session, user);
  }

  /// Returns the list of role names for a given user.
  Future<List<String>> getUserRoles(Session session, int userId) async {
    await requireAdmin(session);

    final assignments = await UserRoleAssignment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    return assignments.map((a) => a.role.name).toList();
  }

  /// Permanently deletes a user account.
  /// Throws if the user is a member of any chat.
  Future<void> deleteUser(Session session, int userId) async {
    await requireAdmin(session);

    final user = await AppUser.db.findById(session, userId);
    if (user == null) throw Exception('User not found: $userId');

    // Check for chat membership.
    final memberships = await ChatMember.db.count(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (memberships > 0) {
      throw Exception(
        'Cannot delete user: they are a member of $memberships chat(s). '
        'Remove them from all chats first.',
      );
    }

    // Remove role assignments.
    await UserRoleAssignment.db.deleteWhere(
      session,
      where: (t) => t.userId.equals(userId),
    );

    // Delete the AppUser record.
    await AppUser.db.deleteRow(session, user);
  }

  /// Unblocks a previously blocked user.
  Future<void> unblockUser(Session session, int userId) async {
    await requireAdmin(session);

    final user = await AppUser.db.findById(session, userId);
    if (user == null) throw Exception('User not found: $userId');

    user.isBlocked = false;
    await AppUser.db.updateRow(session, user);
  }

  /// Replaces all role assignments for a user with the provided list.
  Future<void> assignRoles(
    Session session,
    int userId,
    List<UserRole> roles,
  ) async {
    await requireAdmin(session);

    final user = await AppUser.db.findById(session, userId);
    if (user == null) throw Exception('User not found: $userId');

    final adminUser = await getAuthenticatedAppUser(session);

    // Remove all existing assignments.
    final existing = await UserRoleAssignment.db.find(
      session,
      where: (t) => t.userId.equals(userId),
    );
    for (final a in existing) {
      await UserRoleAssignment.db.deleteRow(session, a);
    }

    // Insert new assignments.
    final now = DateTime.now().toUtc();
    for (final role in roles) {
      await UserRoleAssignment.db.insertRow(
        session,
        UserRoleAssignment(
          userId: userId,
          role: role,
          assignedAt: now,
          assignedByUserId: adminUser.id!,
        ),
      );
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Chat management
  // ──────────────────────────────────────────────────────────────────────────

  /// Returns all chats with admin-level metadata.
  Future<List<ChatAdminInfo>> listAllChats(Session session) async {
    await requireAdmin(session);

    final chats = await Chat.db.find(session);
    final result = <ChatAdminInfo>[];

    for (final chat in chats) {
      final memberCount = await ChatMember.db.count(
        session,
        where: (t) => t.chatId.equals(chat.id!),
      );

      String? ownerName;
      if (chat.ownerUserId != null) {
        final owner = await AppUser.db.findById(session, chat.ownerUserId!);
        ownerName = owner?.name;
      }

      result.add(
        ChatAdminInfo(
          id: chat.id!,
          name: chat.name,
          ownerName: ownerName,
          memberCount: memberCount,
        ),
      );
    }

    return result;
  }

  /// Changes the owner of a chat.
  Future<void> changeOwner(
    Session session,
    int chatId,
    int newOwnerUserId,
  ) async {
    await requireAdmin(session);

    final chat = await Chat.db.findById(session, chatId);
    if (chat == null) throw Exception('Chat not found: $chatId');

    final newOwner = await AppUser.db.findById(session, newOwnerUserId);
    if (newOwner == null) throw Exception('User not found: $newOwnerUserId');

    chat.ownerUserId = newOwnerUserId;
    chat.updatedAt = DateTime.now().toUtc();
    await Chat.db.updateRow(session, chat);
  }

  /// Archives a chat.
  Future<void> archiveChat(Session session, int chatId) async {
    await requireAdmin(session);

    final chat = await Chat.db.findById(session, chatId);
    if (chat == null) throw Exception('Chat not found: $chatId');

    chat.isArchived = true;
    chat.updatedAt = DateTime.now().toUtc();
    await Chat.db.updateRow(session, chat);
  }

  /// Permanently deletes an archived chat along with all its messages,
  /// members and reactions.
  Future<void> deleteArchivedChat(Session session, int chatId) async {
    await requireAdmin(session);

    final chat = await Chat.db.findById(session, chatId);
    if (chat == null) throw Exception('Chat not found: $chatId');
    if (!chat.isArchived) {
      throw Exception('Chat must be archived before deletion');
    }

    await session.db.transaction((tx) async {
      // Delete reactions and statuses on messages in this chat.
      final messages = await ChatMessage.db.find(
        session,
        where: (t) => t.chatId.equals(chatId),
      );
      for (final msg in messages) {
        await MessageReaction.db.deleteWhere(
          session,
          where: (t) => t.messageId.equals(msg.id!),
          transaction: tx,
        );
        await MessageStatus.db.deleteWhere(
          session,
          where: (t) => t.messageId.equals(msg.id!),
          transaction: tx,
        );
      }
      await ChatMessage.db.deleteWhere(
        session,
        where: (t) => t.chatId.equals(chatId),
        transaction: tx,
      );

      // Delete members.
      await ChatMember.db.deleteWhere(
        session,
        where: (t) => t.chatId.equals(chatId),
        transaction: tx,
      );

      // Delete chat.
      await Chat.db.deleteRow(session, chat, transaction: tx);
    });
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Resource management
  // ──────────────────────────────────────────────────────────────────────────

  /// Returns aggregate storage statistics (files referenced in messages).
  Future<StorageStats> getStorageStats(Session session) async {
    await requireAdmin(session);

    final messages = await ChatMessage.db.find(
      session,
      where: (t) => t.fileUrl.notEquals(null),
    );

    int totalBytes = 0;
    int fileCount = 0;
    for (final msg in messages) {
      if (msg.fileSize != null) {
        totalBytes += msg.fileSize!;
        fileCount++;
      }
    }

    return StorageStats(totalBytes: totalBytes, fileCount: fileCount);
  }

  /// Stores or updates the per-upload file size limit in [SystemSettings].
  Future<void> setFileSizeLimit(Session session, int bytes) async {
    await requireAdmin(session);

    final existing = await SystemSettings.db.findFirstRow(
      session,
      where: (t) => t.key.equals('file_size_limit'),
    );

    if (existing != null) {
      existing.value = bytes.toString();
      existing.updatedAt = DateTime.now().toUtc();
      await SystemSettings.db.updateRow(session, existing);
    } else {
      await SystemSettings.db.insertRow(
        session,
        SystemSettings(
          key: 'file_size_limit',
          value: bytes.toString(),
          updatedAt: DateTime.now().toUtc(),
        ),
      );
    }
  }

  /// Returns a preview of files that would be deleted if [deleteFilesOlderThan]
  /// is called with the same [days] value.
  Future<FileDeletionPreview> getFilesOlderThan(
    Session session,
    int days,
  ) async {
    await requireAdmin(session);

    final cutoff = DateTime.now().toUtc().subtract(Duration(days: days));

    final messages = await ChatMessage.db.find(
      session,
      where: (t) => t.fileUrl.notEquals(null) & (t.createdAt < cutoff),
      orderBy: (t) => t.createdAt,
    );

    int totalBytes = 0;
    int fileCount = 0;
    DateTime? oldest;

    for (final msg in messages) {
      fileCount++;
      totalBytes += msg.fileSize ?? 0;
      if (oldest == null || msg.createdAt.isBefore(oldest)) {
        oldest = msg.createdAt;
      }
    }

    return FileDeletionPreview(
      totalBytes: totalBytes,
      fileCount: fileCount,
      oldestFileDate: oldest,
    );
  }

  /// Nullifies the file/image URLs on messages older than [days] days,
  /// effectively releasing the storage reference.
  Future<void> deleteFilesOlderThan(Session session, int days) async {
    await requireAdmin(session);

    final cutoff = DateTime.now().toUtc().subtract(Duration(days: days));

    final messages = await ChatMessage.db.find(
      session,
      where: (t) => t.fileUrl.notEquals(null) & (t.createdAt < cutoff),
    );

    for (final msg in messages) {
      msg.fileUrl = null;
      msg.imageUrl = null;
      msg.fileName = null;
      msg.fileSize = null;
      msg.isEdited = true;
      msg.editedAt = DateTime.now().toUtc();
      await ChatMessage.db.updateRow(session, msg);
    }
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Helpers
  // ──────────────────────────────────────────────────────────────────────────

  String _colorFromSeed(String seed) {
    const colors = [
      '#FF5733',
      '#33B5FF',
      '#8033FF',
      '#FF33A8',
      '#33FF57',
      '#FF8C33',
      '#33FFF5',
      '#FF3355',
    ];
    final idx = seed.codeUnits.fold(0, (a, b) => a + b) % colors.length;
    return colors[idx];
  }
}
