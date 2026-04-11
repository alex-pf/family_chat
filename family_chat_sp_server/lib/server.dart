import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/util/admin_seeder.dart';
import 'src/web/routes/root.dart';

/// The starting point of the Serverpod server.
void run(List<String> args) async {
  // Initialize Serverpod and connect it with your generated code.
  final pod = Serverpod(args, Protocol(), Endpoints());

  // Initialize authentication services for the server.
  // JWT refresh token lifetime is set to 30 days (active-session rolling).
  pod.initializeAuthServices(
    tokenManagerBuilders: [
      JwtConfigFromPasswords(
        // Refresh tokens are valid for 30 days of inactivity.
        refreshTokenLifetime: const Duration(days: 30),
      ),
    ],
    identityProviderBuilders: [
      // Configure the email identity provider for email/password authentication.
      EmailIdpConfigFromPasswords(
        sendRegistrationVerificationCode: _sendRegistrationCode,
        sendPasswordResetVerificationCode: _sendPasswordResetCode,
      ),
    ],
  );

  // Flutter app is served via GitHub Pages — no static files needed on server.
  // Health-check endpoint at web root.
  pod.webServer.addRoute(RootRoute(), '/');

  // Start the server, then seed the admin user if needed.
  await pod.start();

  // Seed the initial admin from environment variables (no-op if already exists).
  await _seedAdmin(pod);
}

/// Seeds the admin user after startup, using a temporary internal session.
Future<void> _seedAdmin(Serverpod pod) async {
  final session = await pod.createSession(enableLogging: false);
  try {
    await seedAdminIfNeeded(session);
  } catch (e, st) {
    session.log(
      '[server.dart] Admin seed error: $e\n$st',
      level: LogLevel.error,
    );
  } finally {
    await session.close();
  }
}

void _sendRegistrationCode(
  Session session, {
  required String email,
  required UuidValue accountRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // In production, integrate with an email delivery service here.
  session.log('[EmailIdp] Registration code ($email): $verificationCode');
}

void _sendPasswordResetCode(
  Session session, {
  required String email,
  required UuidValue passwordResetRequestId,
  required String verificationCode,
  required Transaction? transaction,
}) {
  // In production, integrate with an email delivery service here.
  session.log('[EmailIdp] Password reset code ($email): $verificationCode');
}
