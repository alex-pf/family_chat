import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';

/// Throws [NotAuthorizedException] if the authenticated user does not have
/// the given [role].
Future<void> requireRole(Session session, UserRole role) async {
  final hasIt = await hasRole(session, role);
  if (!hasIt) {
    throw NotAuthorizedException(
      reason: AuthenticationFailureReason.insufficientAccess,
    );
  }
}

/// Throws [NotAuthorizedException] if the authenticated user is not an admin.
Future<void> requireAdmin(Session session) async {
  await requireRole(session, UserRole.admin);
}

/// Returns true if the currently authenticated user has the given [role].
Future<bool> hasRole(Session session, UserRole role) async {
  final authInfo = session.authenticated;
  if (authInfo == null) return false;

  final appUser = await AppUser.db.findFirstRow(
    session,
    where: (t) => t.serverpodUserId.equals(authInfo.userIdentifier),
  );
  if (appUser == null) return false;

  final assignments = await UserRoleAssignment.db.find(
    session,
    where: (t) => t.userId.equals(appUser.id!),
  );

  return assignments.any((a) => a.role == role);
}

/// Returns true if the user has any of the given roles.
Future<bool> hasAnyRole(Session session, List<UserRole> roles) async {
  final authInfo = session.authenticated;
  if (authInfo == null) return false;

  final appUser = await AppUser.db.findFirstRow(
    session,
    where: (t) => t.serverpodUserId.equals(authInfo.userIdentifier),
  );
  if (appUser == null) return false;

  final assignments = await UserRoleAssignment.db.find(
    session,
    where: (t) => t.userId.equals(appUser.id!),
  );

  return assignments.any((a) => roles.contains(a.role));
}

/// Returns the AppUser for the authenticated session, or throws if not found.
Future<AppUser> getAuthenticatedAppUser(Session session) async {
  final authInfo = session.authenticated;
  if (authInfo == null) {
    throw NotAuthorizedException(
      reason: AuthenticationFailureReason.unauthenticated,
    );
  }

  final appUser = await AppUser.db.findFirstRow(
    session,
    where: (t) => t.serverpodUserId.equals(authInfo.userIdentifier),
  );
  if (appUser == null) {
    throw Exception(
      'AppUser record not found for userIdentifier=${authInfo.userIdentifier}',
    );
  }
  return appUser;
}
