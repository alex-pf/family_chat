import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/role_checker.dart';

/// Endpoints for user profile management.
class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // ──────────────────────────────────────────────────────────────────────────
  // Own profile
  // ──────────────────────────────────────────────────────────────────────────

  /// Returns the [AppUser] for the authenticated caller.
  Future<AppUser> getMyProfile(Session session) async {
    return getAuthenticatedAppUser(session);
  }

  /// Updates the display name of the authenticated caller.
  /// Recalculates initials after the name change.
  Future<AppUser> updateProfile(Session session, String name) async {
    final appUser = await getAuthenticatedAppUser(session);

    final parts = name.trim().split(RegExp(r'\s+'));
    final initials = parts.length >= 2
        ? '${parts[0][0]}${parts[1][0]}'.toUpperCase()
        : name.isNotEmpty
            ? name[0].toUpperCase()
            : appUser.avatarInitials;

    appUser.name = name.trim();
    appUser.avatarInitials = initials;

    return AppUser.db.updateRow(session, appUser);
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Directory
  // ──────────────────────────────────────────────────────────────────────────

  /// Lists all registered users. Available to Family role and above.
  Future<List<AppUser>> listAllUsers(Session session) async {
    // Require at least the 'family' role.
    final allowed = await hasAnyRole(session, [
      UserRole.admin,
      UserRole.master,
      UserRole.family,
      UserRole.parents,
    ]);
    if (!allowed) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }

    return AppUser.db.find(session);
  }

  /// Returns all [AppUser]s who are members of a given chat.
  Future<List<AppUser>> getUsersInChat(Session session, int chatId) async {
    final caller = await getAuthenticatedAppUser(session);

    // The caller must be a member of the chat themselves.
    final membership = await ChatMember.db.findFirstRow(
      session,
      where: (t) =>
          t.chatId.equals(chatId) & t.userId.equals(caller.id!),
    );
    if (membership == null) {
      throw NotAuthorizedException(
        reason: AuthenticationFailureReason.insufficientAccess,
      );
    }

    // Fetch all members of the chat.
    final members = await ChatMember.db.find(
      session,
      where: (t) => t.chatId.equals(chatId),
    );

    final userIds = members.map((m) => m.userId).toSet();
    if (userIds.isEmpty) return [];

    // Fetch AppUser records in bulk.
    return AppUser.db.find(
      session,
      where: (t) => t.id.inSet(userIds),
    );
  }
}
