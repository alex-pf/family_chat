import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import '../generated/protocol.dart';

/// Seeds the first admin user from environment variables if none exists yet.
///
/// Reads [ADMIN_EMAIL] and [ADMIN_INITIAL_PASSWORD] from the process
/// environment. If both are present and no admin exists, a new admin user
/// account is created with [mustChangePassword] set to true.
///
/// Safe to call on every server start – it is a no-op when an admin already
/// exists or the env-vars are absent.
Future<void> seedAdminIfNeeded(Session session) async {
  final adminEmail = Platform.environment['ADMIN_EMAIL'];
  final adminPassword = Platform.environment['ADMIN_INITIAL_PASSWORD'];

  if (adminEmail == null || adminEmail.isEmpty) {
    session.log('[AdminSeeder] ADMIN_EMAIL not set – skipping seed.');
    return;
  }
  if (adminPassword == null || adminPassword.isEmpty) {
    session.log(
        '[AdminSeeder] ADMIN_INITIAL_PASSWORD not set – skipping seed.');
    return;
  }

  // Check whether an admin user already exists.
  final existingAdmins = await UserRoleAssignment.db.find(
    session,
    where: (t) => t.role.equals(UserRole.admin),
  );
  if (existingAdmins.isNotEmpty) {
    session.log('[AdminSeeder] Admin already exists – skipping seed.');
    return;
  }

  // Also check if the email is already registered as an AppUser.
  final existingUser = await AppUser.db.findFirstRow(
    session,
    where: (t) => t.email.equals(adminEmail),
  );
  if (existingUser != null) {
    session.log(
        '[AdminSeeder] Email already registered – skipping seed.');
    return;
  }

  session.log('[AdminSeeder] Seeding admin user: $adminEmail');

  try {
    // 1. Create the Serverpod AuthUser via the AuthUsers core service.
    final authUsers = AuthUsers();
    final authUserModel = await authUsers.create(session);
    final authUserId = authUserModel.id; // UuidValue

    // 2. Create the email authentication for this auth user via EmailIdpAdmin.
    final emailIdp = AuthServices.getIdentityProvider<EmailIdp>();
    await session.db.transaction((tx) async {
      await emailIdp.admin.createEmailAuthentication(
        session,
        authUserId: authUserId,
        email: adminEmail,
        password: adminPassword,
        transaction: tx,
      );
    });

    // 3. Derive initials and a colour from the email.
    final name = adminEmail.split('@').first;
    final initials = _initials(name);
    final color = _colorFromSeed(name);

    // 4. Create AppUser record linking to the auth user via UUID string.
    final appUser = AppUser(
      serverpodUserId: authUserId.toString(),
      email: adminEmail,
      name: name,
      avatarColor: color,
      avatarInitials: initials,
      isBlocked: false,
      mustChangePassword: true,
      createdAt: DateTime.now().toUtc(),
    );
    final savedUser = await AppUser.db.insertRow(session, appUser);

    // 5. Assign admin role.
    final assignment = UserRoleAssignment(
      userId: savedUser.id!,
      role: UserRole.admin,
      assignedAt: DateTime.now().toUtc(),
      assignedByUserId: savedUser.id!,
    );
    await UserRoleAssignment.db.insertRow(session, assignment);

    session.log(
        '[AdminSeeder] Admin seeded successfully (appUserId=${savedUser.id}).');
  } catch (e, st) {
    session.log(
      '[AdminSeeder] Failed to seed admin: $e\n$st',
      level: LogLevel.error,
    );
  }
}

String _initials(String name) {
  final parts = name.trim().split(RegExp(r'[\s._-]+'));
  if (parts.length >= 2) {
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }
  return name.isNotEmpty ? name[0].toUpperCase() : 'A';
}

String _colorFromSeed(String seed) {
  const colors = [
    '#FF5733', '#33B5FF', '#8033FF', '#FF33A8',
    '#33FF57', '#FF8C33', '#33FFF5', '#FF3355',
  ];
  final idx = seed.codeUnits.fold(0, (a, b) => a + b) % colors.length;
  return colors[idx];
}
