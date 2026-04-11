/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i1;
import 'package:serverpod_client/serverpod_client.dart' as _i2;
import 'dart:async' as _i3;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i4;
import 'package:family_chat_sp_client/src/protocol/user.dart' as _i5;
import 'package:family_chat_sp_client/src/protocol/user_role.dart' as _i6;
import 'package:family_chat_sp_client/src/protocol/chat_admin_info.dart' as _i7;
import 'package:family_chat_sp_client/src/protocol/storage_stats.dart' as _i8;
import 'package:family_chat_sp_client/src/protocol/file_deletion_preview.dart'
    as _i9;
import 'package:family_chat_sp_client/src/protocol/chat.dart' as _i10;
import 'package:family_chat_sp_client/src/protocol/chat_list_item.dart' as _i11;
import 'package:family_chat_sp_client/src/protocol/message.dart' as _i12;
import 'package:family_chat_sp_client/src/protocol/message_reaction.dart'
    as _i13;
import 'package:family_chat_sp_client/src/protocol/chat_stream_event.dart'
    as _i14;
import 'package:family_chat_sp_client/src/protocol/greetings/greeting.dart'
    as _i15;
import 'protocol.dart' as _i16;

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _i1.EndpointEmailIdpBase {
  EndpointEmailIdp(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<_i4.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _i3.Future<_i2.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _i3.Future<String> verifyRegistrationCode({
    required _i2.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _i3.Future<_i4.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _i3.Future<_i2.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_i2.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _i3.Future<String> verifyPasswordResetCode({
    required _i2.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _i3.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _i3.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _i4.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _i3.Future<_i4.AuthSuccess> refreshAccessToken({
    required String refreshToken,
  }) => caller.callServerEndpoint<_i4.AuthSuccess>(
    'jwtRefresh',
    'refreshAccessToken',
    {'refreshToken': refreshToken},
    authenticated: false,
  );
}

/// Admin-only endpoints for user and chat management, plus resource monitoring.
/// {@category Endpoint}
class EndpointAdmin extends _i2.EndpointRef {
  EndpointAdmin(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'admin';

  /// Admin creates a new user: one call that registers the Serverpod auth
  /// account (email + one-time password) AND creates the AppUser + assigns
  /// roles. mustChangePassword is set to true automatically.
  _i3.Future<_i5.AppUser> adminCreateUser(
    String name,
    String email,
    String oneTimePassword,
    List<_i6.UserRole> roles,
  ) => caller.callServerEndpoint<_i5.AppUser>(
    'admin',
    'adminCreateUser',
    {
      'name': name,
      'email': email,
      'oneTimePassword': oneTimePassword,
      'roles': roles,
    },
  );

  /// Creates a new AppUser record and assigns roles.
  ///
  /// @deprecated Use [adminCreateUser] instead.
  _i3.Future<_i5.AppUser> createUser(
    String name,
    String email,
    List<_i6.UserRole> roles,
    String serverpodUserId,
  ) => caller.callServerEndpoint<_i5.AppUser>(
    'admin',
    'createUser',
    {
      'name': name,
      'email': email,
      'roles': roles,
      'serverpodUserId': serverpodUserId,
    },
  );

  /// Blocks a user (they can no longer sign in).
  _i3.Future<void> blockUser(int userId) => caller.callServerEndpoint<void>(
    'admin',
    'blockUser',
    {'userId': userId},
  );

  /// Returns the list of role names for a given user.
  _i3.Future<List<String>> getUserRoles(int userId) =>
      caller.callServerEndpoint<List<String>>(
        'admin',
        'getUserRoles',
        {'userId': userId},
      );

  /// Permanently deletes a user account.
  /// Throws if the user is a member of any chat.
  _i3.Future<void> deleteUser(int userId) => caller.callServerEndpoint<void>(
    'admin',
    'deleteUser',
    {'userId': userId},
  );

  /// Unblocks a previously blocked user.
  _i3.Future<void> unblockUser(int userId) => caller.callServerEndpoint<void>(
    'admin',
    'unblockUser',
    {'userId': userId},
  );

  /// Replaces all role assignments for a user with the provided list.
  _i3.Future<void> assignRoles(
    int userId,
    List<_i6.UserRole> roles,
  ) => caller.callServerEndpoint<void>(
    'admin',
    'assignRoles',
    {
      'userId': userId,
      'roles': roles,
    },
  );

  /// Returns all chats with admin-level metadata.
  _i3.Future<List<_i7.ChatAdminInfo>> listAllChats() =>
      caller.callServerEndpoint<List<_i7.ChatAdminInfo>>(
        'admin',
        'listAllChats',
        {},
      );

  /// Changes the owner of a chat.
  _i3.Future<void> changeOwner(
    int chatId,
    int newOwnerUserId,
  ) => caller.callServerEndpoint<void>(
    'admin',
    'changeOwner',
    {
      'chatId': chatId,
      'newOwnerUserId': newOwnerUserId,
    },
  );

  /// Archives a chat.
  _i3.Future<void> archiveChat(int chatId) => caller.callServerEndpoint<void>(
    'admin',
    'archiveChat',
    {'chatId': chatId},
  );

  /// Permanently deletes an archived chat along with all its messages,
  /// members and reactions.
  _i3.Future<void> deleteArchivedChat(int chatId) =>
      caller.callServerEndpoint<void>(
        'admin',
        'deleteArchivedChat',
        {'chatId': chatId},
      );

  /// Returns aggregate storage statistics (files referenced in messages).
  _i3.Future<_i8.StorageStats> getStorageStats() =>
      caller.callServerEndpoint<_i8.StorageStats>(
        'admin',
        'getStorageStats',
        {},
      );

  /// Stores or updates the per-upload file size limit in [SystemSettings].
  _i3.Future<void> setFileSizeLimit(int bytes) =>
      caller.callServerEndpoint<void>(
        'admin',
        'setFileSizeLimit',
        {'bytes': bytes},
      );

  /// Returns a preview of files that would be deleted if [deleteFilesOlderThan]
  /// is called with the same [days] value.
  _i3.Future<_i9.FileDeletionPreview> getFilesOlderThan(int days) =>
      caller.callServerEndpoint<_i9.FileDeletionPreview>(
        'admin',
        'getFilesOlderThan',
        {'days': days},
      );

  /// Nullifies the file/image URLs on messages older than [days] days,
  /// effectively releasing the storage reference.
  _i3.Future<void> deleteFilesOlderThan(int days) =>
      caller.callServerEndpoint<void>(
        'admin',
        'deleteFilesOlderThan',
        {'days': days},
      );

  /// Resets the password for a user (admin only).
  _i3.Future<void> resetUserPassword(
    int userId,
    String newPassword, {
    bool forceChange = true,
  }) => caller.callServerEndpoint<void>(
    'admin',
    'resetUserPassword',
    {
      'userId': userId,
      'newPassword': newPassword,
      'forceChange': forceChange,
    },
  );
}

/// Custom auth endpoint that layers on top of Serverpod's built-in auth.
///
/// Covers:
///  - [askAdmin]               – any visitor can request access
///  - [approveAskAdmin]        – admin approves a request, issues a token
///  - [loginWithToken]         – user consumes a one-time token to sign in
/// {@category Endpoint}
class EndpointAuth extends _i2.EndpointRef {
  EndpointAuth(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'auth';

  /// Called by a visitor who wants access. Creates a notification for every
  /// admin user. Returns `true` on success.
  _i3.Future<bool> askAdmin(String email) => caller.callServerEndpoint<bool>(
    'auth',
    'askAdmin',
    {'email': email},
  );

  /// Admin approves a pending access request.
  /// Creates a [OneTimeToken] valid for 15 minutes and sends a notification
  /// to the requesting user.
  ///
  /// Requires caller to be authenticated as admin.
  _i3.Future<String> approveAskAdmin(int requestingUserId) =>
      caller.callServerEndpoint<String>(
        'auth',
        'approveAskAdmin',
        {'requestingUserId': requestingUserId},
      );

  /// Exchange a valid [OneTimeToken] for the associated AppUser's
  /// serverpodUserId string.
  ///
  /// Returns the serverpodUserId on success; throws on failure.
  _i3.Future<String> loginWithToken(String token) =>
      caller.callServerEndpoint<String>(
        'auth',
        'loginWithToken',
        {'token': token},
      );

  /// Returns a list of emails from unread 'ask_admin' notifications.
  /// Admin only.
  _i3.Future<List<String>> getPendingRequests() =>
      caller.callServerEndpoint<List<String>>(
        'auth',
        'getPendingRequests',
        {},
      );

  /// Admin issues a one-time token for a user who requested access by email.
  _i3.Future<String> issueAccessToken(String email) =>
      caller.callServerEndpoint<String>(
        'auth',
        'issueAccessToken',
        {'email': email},
      );
}

/// Endpoints for chat management (group chats, direct chats, settings).
/// {@category Endpoint}
class EndpointChat extends _i2.EndpointRef {
  EndpointChat(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'chat';

  /// Creates a new group chat.
  ///
  /// Restricted to users with Master or Admin role.
  /// [memberIds] are the initial participant user IDs (caller is auto-added).
  _i3.Future<_i10.Chat> createGroupChat(
    String name,
    List<int> memberIds,
    List<_i6.UserRole> allowedRoles,
  ) => caller.callServerEndpoint<_i10.Chat>(
    'chat',
    'createGroupChat',
    {
      'name': name,
      'memberIds': memberIds,
      'allowedRoles': allowedRoles,
    },
  );

  /// Returns the existing direct chat between the caller and [otherUserId],
  /// or creates one if it doesn't exist.
  _i3.Future<_i10.Chat> createOrGetDirectChat(int otherUserId) =>
      caller.callServerEndpoint<_i10.Chat>(
        'chat',
        'createOrGetDirectChat',
        {'otherUserId': otherUserId},
      );

  /// Returns all chats the caller belongs to, with last-message preview and
  /// unread count.
  _i3.Future<List<_i11.ChatListItem>> listMyChats() =>
      caller.callServerEndpoint<List<_i11.ChatListItem>>(
        'chat',
        'listMyChats',
        {},
      );

  /// Returns the full [Chat] object for a given chat ID.
  ///
  /// Caller must be a member.
  _i3.Future<_i10.Chat> getChatDetails(int chatId) =>
      caller.callServerEndpoint<_i10.Chat>(
        'chat',
        'getChatDetails',
        {'chatId': chatId},
      );

  /// Updates chat display settings. Only the owner or an admin may call this.
  _i3.Future<_i10.Chat> updateChatSettings(
    int chatId, {
    String? name,
    String? backgroundId,
    String? textColor,
  }) => caller.callServerEndpoint<_i10.Chat>(
    'chat',
    'updateChatSettings',
    {
      'chatId': chatId,
      'name': name,
      'backgroundId': backgroundId,
      'textColor': textColor,
    },
  );

  /// Adds users to an existing group chat.
  ///
  /// Caller must be the owner or an admin.
  _i3.Future<void> addMembers(
    int chatId,
    List<int> userIds,
  ) => caller.callServerEndpoint<void>(
    'chat',
    'addMembers',
    {
      'chatId': chatId,
      'userIds': userIds,
    },
  );

  /// Removes a user from a group chat.
  ///
  /// Caller must be the owner or an admin.
  _i3.Future<void> removeMember(
    int chatId,
    int userId,
  ) => caller.callServerEndpoint<void>(
    'chat',
    'removeMember',
    {
      'chatId': chatId,
      'userId': userId,
    },
  );

  /// The authenticated caller leaves a group chat.
  _i3.Future<void> leaveChat(int chatId) => caller.callServerEndpoint<void>(
    'chat',
    'leaveChat',
    {'chatId': chatId},
  );
}

/// Endpoints for message CRUD, reactions, read receipts and real-time streaming.
/// {@category Endpoint}
class EndpointMessage extends _i2.EndpointRef {
  EndpointMessage(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'message';

  /// Sends a new message to [chatId].
  ///
  /// At least one of [text], [imageUrl] or [fileUrl] must be provided.
  _i3.Future<_i12.ChatMessage> sendMessage(
    int chatId, {
    String? text,
    String? imageUrl,
    String? fileUrl,
    String? fileName,
    int? fileSize,
  }) => caller.callServerEndpoint<_i12.ChatMessage>(
    'message',
    'sendMessage',
    {
      'chatId': chatId,
      'text': text,
      'imageUrl': imageUrl,
      'fileUrl': fileUrl,
      'fileName': fileName,
      'fileSize': fileSize,
    },
  );

  /// Edits the text of an existing message.
  ///
  /// Only the original sender may edit their own messages.
  _i3.Future<_i12.ChatMessage> editMessage(
    int messageId,
    String newText,
  ) => caller.callServerEndpoint<_i12.ChatMessage>(
    'message',
    'editMessage',
    {
      'messageId': messageId,
      'newText': newText,
    },
  );

  /// Soft-deletes a message by setting [isDeleted] = true.
  ///
  /// Only the original sender or an admin may delete a message.
  _i3.Future<void> deleteMessage(int messageId) =>
      caller.callServerEndpoint<void>(
        'message',
        'deleteMessage',
        {'messageId': messageId},
      );

  /// Adds an emoji reaction to a message.
  _i3.Future<_i13.MessageReaction> addReaction(
    int messageId,
    String emoji,
  ) => caller.callServerEndpoint<_i13.MessageReaction>(
    'message',
    'addReaction',
    {
      'messageId': messageId,
      'emoji': emoji,
    },
  );

  /// Removes an emoji reaction from a message.
  _i3.Future<void> removeReaction(
    int messageId,
    String emoji,
  ) => caller.callServerEndpoint<void>(
    'message',
    'removeReaction',
    {
      'messageId': messageId,
      'emoji': emoji,
    },
  );

  /// Marks all messages up to and including [lastReadMessageId] as read for
  /// the caller in the given chat.
  _i3.Future<void> markAsRead(
    int chatId,
    int lastReadMessageId,
  ) => caller.callServerEndpoint<void>(
    'message',
    'markAsRead',
    {
      'chatId': chatId,
      'lastReadMessageId': lastReadMessageId,
    },
  );

  /// Returns up to [limit] messages in [chatId], ordered newest-first.
  ///
  /// Pass [beforeMessageId] to page backwards (load older messages).
  _i3.Future<List<_i12.ChatMessage>> getMessages(
    int chatId, {
    int? beforeMessageId,
    required int limit,
  }) => caller.callServerEndpoint<List<_i12.ChatMessage>>(
    'message',
    'getMessages',
    {
      'chatId': chatId,
      'beforeMessageId': beforeMessageId,
      'limit': limit,
    },
  );

  /// Real-time stream of [ChatStreamEvent]s for a given chat.
  ///
  /// The client keeps this open; the server pushes events via the message bus.
  _i3.Stream<_i14.ChatStreamEvent> chatStream(int chatId) =>
      caller.callStreamingServerEndpoint<
        _i3.Stream<_i14.ChatStreamEvent>,
        _i14.ChatStreamEvent
      >(
        'message',
        'chatStream',
        {'chatId': chatId},
        {},
      );

  /// Broadcasts a typing indicator to all other members of a chat.
  _i3.Future<void> sendTypingIndicator(int chatId) =>
      caller.callServerEndpoint<void>(
        'message',
        'sendTypingIndicator',
        {'chatId': chatId},
      );
}

/// Endpoints for user profile management.
/// {@category Endpoint}
class EndpointUser extends _i2.EndpointRef {
  EndpointUser(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// Returns the [AppUser] for the authenticated caller.
  _i3.Future<_i5.AppUser> getMyProfile() =>
      caller.callServerEndpoint<_i5.AppUser>(
        'user',
        'getMyProfile',
        {},
      );

  /// Returns the list of role names for the authenticated caller.
  _i3.Future<List<String>> getMyRoles() =>
      caller.callServerEndpoint<List<String>>(
        'user',
        'getMyRoles',
        {},
      );

  /// Updates the display name of the authenticated caller.
  /// Recalculates initials after the name change.
  _i3.Future<_i5.AppUser> updateProfile(String name) =>
      caller.callServerEndpoint<_i5.AppUser>(
        'user',
        'updateProfile',
        {'name': name},
      );

  /// Lists all registered users. Available to Family role and above.
  _i3.Future<List<_i5.AppUser>> listAllUsers() =>
      caller.callServerEndpoint<List<_i5.AppUser>>(
        'user',
        'listAllUsers',
        {},
      );

  /// Returns all [AppUser]s who are members of a given chat.
  _i3.Future<List<_i5.AppUser>> getUsersInChat(int chatId) =>
      caller.callServerEndpoint<List<_i5.AppUser>>(
        'user',
        'getUsersInChat',
        {'chatId': chatId},
      );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i2.EndpointRef {
  EndpointGreeting(_i2.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i3.Future<_i15.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i15.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _i1.Caller(client);
    serverpod_auth_core = _i4.Caller(client);
  }

  late final _i1.Caller serverpod_auth_idp;

  late final _i4.Caller serverpod_auth_core;
}

class Client extends _i2.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i2.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i2.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i16.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    emailIdp = EndpointEmailIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    admin = EndpointAdmin(this);
    auth = EndpointAuth(this);
    chat = EndpointChat(this);
    message = EndpointMessage(this);
    user = EndpointUser(this);
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointEmailIdp emailIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointAdmin admin;

  late final EndpointAuth auth;

  late final EndpointChat chat;

  late final EndpointMessage message;

  late final EndpointUser user;

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i2.EndpointRef> get endpointRefLookup => {
    'emailIdp': emailIdp,
    'jwtRefresh': jwtRefresh,
    'admin': admin,
    'auth': auth,
    'chat': chat,
    'message': message,
    'user': user,
    'greeting': greeting,
  };

  @override
  Map<String, _i2.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
