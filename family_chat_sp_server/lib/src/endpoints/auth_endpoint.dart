import 'dart:math';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/role_checker.dart';

/// Custom auth endpoint that layers on top of Serverpod's built-in auth.
///
/// Covers:
///  - [askAdmin]               – any visitor can request access
///  - [approveAskAdmin]        – admin approves a request, issues a token
///  - [loginWithToken]         – user consumes a one-time token to sign in
class AuthEndpoint extends Endpoint {
  // askAdmin and loginWithToken are public (no login required).
  // approveAskAdmin requires the caller to be authenticated as admin.
  @override
  bool get requireLogin => false;

  // ──────────────────────────────────────────────────────────────────────────
  // Public: ask an admin for access
  // ──────────────────────────────────────────────────────────────────────────

  /// Called by a visitor who wants access. Creates a notification for every
  /// admin user. Returns `true` on success.
  Future<bool> askAdmin(Session session, String email) async {
    // Find all admin role assignments.
    final adminAssignments = await UserRoleAssignment.db.find(
      session,
      where: (t) => t.role.equals(UserRole.admin),
    );

    if (adminAssignments.isEmpty) {
      session.log('[AuthEndpoint.askAdmin] No admins found to notify.');
      return false;
    }

    // Create an AppNotification for each admin.
    final now = DateTime.now().toUtc();
    for (final assignment in adminAssignments) {
      // Try to find the requesting user's AppUser record (may not exist yet).
      final requestingUser = await AppUser.db.findFirstRow(
        session,
        where: (t) => t.email.equals(email),
      );

      final notification = AppNotification(
        recipientUserId: assignment.userId,
        type: 'ask_admin',
        title: 'New access request',
        body: 'User $email is requesting access.',
        relatedEntityId: requestingUser?.id,
        isRead: false,
        createdAt: now,
      );
      await AppNotification.db.insertRow(session, notification);
    }

    session.log('[AuthEndpoint.askAdmin] Notifications sent for email=$email');
    return true;
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Admin: list pending access requests
  // ──────────────────────────────────────────────────────────────────────────

  /// Returns a list of emails from unread 'ask_admin' notifications.
  /// Admin only.
  Future<List<String>> getPendingRequests(Session session) async {
    await requireAdmin(session);

    final caller = await getAuthenticatedAppUser(session);
    final notifications = await AppNotification.db.find(
      session,
      where: (t) =>
          t.recipientUserId.equals(caller.id!) &
          t.type.equals('ask_admin') &
          t.isRead.equals(false),
    );

    // Extract emails from notification body: "User <email> is requesting access."
    final emails = <String>[];
    for (final n in notifications) {
      final match = RegExp(r'User (.+?) is requesting access').firstMatch(n.body);
      if (match != null) {
        emails.add(match.group(1)!);
      }
    }
    return emails;
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Admin: issue access token for a requesting email
  // ──────────────────────────────────────────────────────────────────────────

  /// Admin issues a one-time token for a user who requested access by email.
  /// Marks the corresponding notification as read.
  Future<String> issueAccessToken(Session session, String email) async {
    await requireAdmin(session);

    // Find the user by email.
    final requestingUser = await AppUser.db.findFirstRow(
      session,
      where: (t) => t.email.equals(email),
    );
    if (requestingUser == null) {
      throw Exception('User not found for email: $email');
    }

    // Mark the related notification as read.
    final caller = await getAuthenticatedAppUser(session);
    final notifications = await AppNotification.db.find(
      session,
      where: (t) =>
          t.recipientUserId.equals(caller.id!) &
          t.type.equals('ask_admin') &
          t.isRead.equals(false),
    );
    for (final n in notifications) {
      if (n.body.contains(email)) {
        n.isRead = true;
        await AppNotification.db.updateRow(session, n);
      }
    }

    // Delegate to approveAskAdmin which creates the token.
    return approveAskAdmin(session, requestingUser.id!);
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Admin: approve a request and issue a one-time token
  // ──────────────────────────────────────────────────────────────────────────

  /// Admin approves a pending access request.
  /// Creates a [OneTimeToken] valid for 15 minutes and sends a notification
  /// to the requesting user.
  ///
  /// Requires caller to be authenticated as admin.
  Future<String> approveAskAdmin(Session session, int requestingUserId) async {
    // Enforce admin role (also implicitly checks authentication).
    await requireAdmin(session);

    // Verify requesting user exists.
    final requestingUser = await AppUser.db.findById(session, requestingUserId);
    if (requestingUser == null) {
      throw Exception('User not found: id=$requestingUserId');
    }

    // Generate a secure random token.
    final token = _generateToken();
    final expiresAt = DateTime.now().toUtc().add(const Duration(minutes: 15));

    // Persist the token.
    final ott = OneTimeToken(
      token: token,
      userId: requestingUserId,
      expiresAt: expiresAt,
    );
    await OneTimeToken.db.insertRow(session, ott);

    // Notify the requesting user.
    final adminUser = await getAuthenticatedAppUser(session);
    final notification = AppNotification(
      recipientUserId: requestingUserId,
      type: 'access_approved',
      title: 'Access approved',
      body:
          'An admin has approved your access. '
          'Use your one-time token to sign in.',
      relatedEntityId: adminUser.id,
      isRead: false,
      createdAt: DateTime.now().toUtc(),
    );
    await AppNotification.db.insertRow(session, notification);

    session.log(
      '[AuthEndpoint.approveAskAdmin] Token issued for userId=$requestingUserId',
    );
    return token;
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Public: consume a one-time token
  // ──────────────────────────────────────────────────────────────────────────

  /// Exchange a valid [OneTimeToken] for the associated AppUser's
  /// serverpodUserId string.
  ///
  /// Returns the serverpodUserId on success; throws on failure.
  Future<String> loginWithToken(Session session, String token) async {
    final now = DateTime.now().toUtc();

    // Look up token.
    final ott = await OneTimeToken.db.findFirstRow(
      session,
      where: (t) => t.token.equals(token),
    );

    if (ott == null) {
      throw Exception('Invalid token');
    }
    if (ott.usedAt != null) {
      throw Exception('Token already used');
    }
    if (ott.expiresAt.isBefore(now)) {
      throw Exception('Token expired');
    }

    // Mark as used.
    ott.usedAt = now;
    await OneTimeToken.db.updateRow(session, ott);

    // Return the serverpodUserId for the associated AppUser.
    final appUser = await AppUser.db.findById(session, ott.userId);
    if (appUser == null) {
      throw Exception('AppUser not found for token');
    }
    if (appUser.serverpodUserId == null) {
      throw Exception('No Serverpod auth account linked to this user');
    }

    session.log(
      '[AuthEndpoint.loginWithToken] Login via token for userId=${appUser.id}',
    );
    return appUser.serverpodUserId!;
  }

  // ──────────────────────────────────────────────────────────────────────────
  // Helper: generate a URL-safe random token
  // ──────────────────────────────────────────────────────────────────────────

  String _generateToken({int length = 48}) {
    const chars =
        'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    final rng = Random.secure();
    return List.generate(
      length,
      (_) => chars[rng.nextInt(chars.length)],
    ).join();
  }
}
