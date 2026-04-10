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
import 'package:serverpod/serverpod.dart' as _i1;
import '../auth/email_idp_endpoint.dart' as _i2;
import '../auth/jwt_refresh_endpoint.dart' as _i3;
import '../endpoints/admin_endpoint.dart' as _i4;
import '../endpoints/auth_endpoint.dart' as _i5;
import '../endpoints/chat_endpoint.dart' as _i6;
import '../endpoints/message_endpoint.dart' as _i7;
import '../endpoints/user_endpoint.dart' as _i8;
import '../greetings/greeting_endpoint.dart' as _i9;
import 'package:family_chat_sp_server/src/generated/user_role.dart' as _i10;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i11;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i12;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'emailIdp': _i2.EmailIdpEndpoint()..initialize(server, 'emailIdp', null),
      'jwtRefresh': _i3.JwtRefreshEndpoint()
        ..initialize(server, 'jwtRefresh', null),
      'admin': _i4.AdminEndpoint()..initialize(server, 'admin', null),
      'auth': _i5.AuthEndpoint()..initialize(server, 'auth', null),
      'chat': _i6.ChatEndpoint()..initialize(server, 'chat', null),
      'message': _i7.MessageEndpoint()..initialize(server, 'message', null),
      'user': _i8.UserEndpoint()..initialize(server, 'user', null),
      'greeting': _i9.GreetingEndpoint()..initialize(server, 'greeting', null),
    };
    connectors['emailIdp'] = _i1.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _i1.MethodConnector(
          name: 'login',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).login(
                session,
                email: params['email'],
                password: params['password'],
              ),
        ),
        'startRegistration': _i1.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).startRegistration(
                session,
                email: params['email'],
              ),
        ),
        'verifyRegistrationCode': _i1.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _i1.ParameterDescription(
              name: 'accountRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _i1.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _i1.ParameterDescription(
              name: 'registrationToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'password': _i1.ParameterDescription(
              name: 'password',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _i1.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .startPasswordReset(session, email: params['email']),
        ),
        'verifyPasswordResetCode': _i1.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _i1.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _i1.getType<_i1.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _i1.ParameterDescription(
              name: 'verificationCode',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _i1.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _i1.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'newPassword': _i1.ParameterDescription(
              name: 'newPassword',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['emailIdp'] as _i2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _i1.MethodConnector(
          name: 'hasAccount',
          params: {},
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['emailIdp'] as _i2.EmailIdpEndpoint).hasAccount(
                session,
              ),
        ),
      },
    );
    connectors['jwtRefresh'] = _i1.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _i1.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _i1.ParameterDescription(
              name: 'refreshToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['jwtRefresh'] as _i3.JwtRefreshEndpoint)
                  .refreshAccessToken(
                    session,
                    refreshToken: params['refreshToken'],
                  ),
        ),
      },
    );
    connectors['admin'] = _i1.EndpointConnector(
      name: 'admin',
      endpoint: endpoints['admin']!,
      methodConnectors: {
        'createUser': _i1.MethodConnector(
          name: 'createUser',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'roles': _i1.ParameterDescription(
              name: 'roles',
              type: _i1.getType<List<_i10.UserRole>>(),
              nullable: false,
            ),
            'serverpodUserId': _i1.ParameterDescription(
              name: 'serverpodUserId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).createUser(
                session,
                params['name'],
                params['email'],
                params['roles'],
                params['serverpodUserId'],
              ),
        ),
        'blockUser': _i1.MethodConnector(
          name: 'blockUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).blockUser(
                session,
                params['userId'],
              ),
        ),
        'unblockUser': _i1.MethodConnector(
          name: 'unblockUser',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).unblockUser(
                session,
                params['userId'],
              ),
        ),
        'assignRoles': _i1.MethodConnector(
          name: 'assignRoles',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'roles': _i1.ParameterDescription(
              name: 'roles',
              type: _i1.getType<List<_i10.UserRole>>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).assignRoles(
                session,
                params['userId'],
                params['roles'],
              ),
        ),
        'listAllChats': _i1.MethodConnector(
          name: 'listAllChats',
          params: {},
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).listAllChats(session),
        ),
        'changeOwner': _i1.MethodConnector(
          name: 'changeOwner',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newOwnerUserId': _i1.ParameterDescription(
              name: 'newOwnerUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).changeOwner(
                session,
                params['chatId'],
                params['newOwnerUserId'],
              ),
        ),
        'archiveChat': _i1.MethodConnector(
          name: 'archiveChat',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).archiveChat(
                session,
                params['chatId'],
              ),
        ),
        'deleteArchivedChat': _i1.MethodConnector(
          name: 'deleteArchivedChat',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).deleteArchivedChat(
                session,
                params['chatId'],
              ),
        ),
        'getStorageStats': _i1.MethodConnector(
          name: 'getStorageStats',
          params: {},
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).getStorageStats(
                session,
              ),
        ),
        'setFileSizeLimit': _i1.MethodConnector(
          name: 'setFileSizeLimit',
          params: {
            'bytes': _i1.ParameterDescription(
              name: 'bytes',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).setFileSizeLimit(
                session,
                params['bytes'],
              ),
        ),
        'getFilesOlderThan': _i1.MethodConnector(
          name: 'getFilesOlderThan',
          params: {
            'days': _i1.ParameterDescription(
              name: 'days',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).getFilesOlderThan(
                session,
                params['days'],
              ),
        ),
        'deleteFilesOlderThan': _i1.MethodConnector(
          name: 'deleteFilesOlderThan',
          params: {
            'days': _i1.ParameterDescription(
              name: 'days',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['admin'] as _i4.AdminEndpoint).deleteFilesOlderThan(
                session,
                params['days'],
              ),
        ),
      },
    );
    connectors['auth'] = _i1.EndpointConnector(
      name: 'auth',
      endpoint: endpoints['auth']!,
      methodConnectors: {
        'askAdmin': _i1.MethodConnector(
          name: 'askAdmin',
          params: {
            'email': _i1.ParameterDescription(
              name: 'email',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['auth'] as _i5.AuthEndpoint).askAdmin(
                session,
                params['email'],
              ),
        ),
        'approveAskAdmin': _i1.MethodConnector(
          name: 'approveAskAdmin',
          params: {
            'requestingUserId': _i1.ParameterDescription(
              name: 'requestingUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['auth'] as _i5.AuthEndpoint).approveAskAdmin(
                session,
                params['requestingUserId'],
              ),
        ),
        'loginWithToken': _i1.MethodConnector(
          name: 'loginWithToken',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['auth'] as _i5.AuthEndpoint).loginWithToken(
                session,
                params['token'],
              ),
        ),
      },
    );
    connectors['chat'] = _i1.EndpointConnector(
      name: 'chat',
      endpoint: endpoints['chat']!,
      methodConnectors: {
        'createGroupChat': _i1.MethodConnector(
          name: 'createGroupChat',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'memberIds': _i1.ParameterDescription(
              name: 'memberIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
            'allowedRoles': _i1.ParameterDescription(
              name: 'allowedRoles',
              type: _i1.getType<List<_i10.UserRole>>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).createGroupChat(
                session,
                params['name'],
                params['memberIds'],
                params['allowedRoles'],
              ),
        ),
        'createOrGetDirectChat': _i1.MethodConnector(
          name: 'createOrGetDirectChat',
          params: {
            'otherUserId': _i1.ParameterDescription(
              name: 'otherUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).createOrGetDirectChat(
                session,
                params['otherUserId'],
              ),
        ),
        'listMyChats': _i1.MethodConnector(
          name: 'listMyChats',
          params: {},
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).listMyChats(session),
        ),
        'getChatDetails': _i1.MethodConnector(
          name: 'getChatDetails',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).getChatDetails(
                session,
                params['chatId'],
              ),
        ),
        'updateChatSettings': _i1.MethodConnector(
          name: 'updateChatSettings',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'backgroundId': _i1.ParameterDescription(
              name: 'backgroundId',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'textColor': _i1.ParameterDescription(
              name: 'textColor',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).updateChatSettings(
                session,
                params['chatId'],
                name: params['name'],
                backgroundId: params['backgroundId'],
                textColor: params['textColor'],
              ),
        ),
        'addMembers': _i1.MethodConnector(
          name: 'addMembers',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userIds': _i1.ParameterDescription(
              name: 'userIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).addMembers(
                session,
                params['chatId'],
                params['userIds'],
              ),
        ),
        'removeMember': _i1.MethodConnector(
          name: 'removeMember',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).removeMember(
                session,
                params['chatId'],
                params['userId'],
              ),
        ),
        'leaveChat': _i1.MethodConnector(
          name: 'leaveChat',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['chat'] as _i6.ChatEndpoint).leaveChat(
                session,
                params['chatId'],
              ),
        ),
      },
    );
    connectors['message'] = _i1.EndpointConnector(
      name: 'message',
      endpoint: endpoints['message']!,
      methodConnectors: {
        'sendMessage': _i1.MethodConnector(
          name: 'sendMessage',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'text': _i1.ParameterDescription(
              name: 'text',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'imageUrl': _i1.ParameterDescription(
              name: 'imageUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'fileUrl': _i1.ParameterDescription(
              name: 'fileUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'fileName': _i1.ParameterDescription(
              name: 'fileName',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'fileSize': _i1.ParameterDescription(
              name: 'fileSize',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['message'] as _i7.MessageEndpoint).sendMessage(
                session,
                params['chatId'],
                text: params['text'],
                imageUrl: params['imageUrl'],
                fileUrl: params['fileUrl'],
                fileName: params['fileName'],
                fileSize: params['fileSize'],
              ),
        ),
        'editMessage': _i1.MethodConnector(
          name: 'editMessage',
          params: {
            'messageId': _i1.ParameterDescription(
              name: 'messageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'newText': _i1.ParameterDescription(
              name: 'newText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['message'] as _i7.MessageEndpoint).editMessage(
                session,
                params['messageId'],
                params['newText'],
              ),
        ),
        'deleteMessage': _i1.MethodConnector(
          name: 'deleteMessage',
          params: {
            'messageId': _i1.ParameterDescription(
              name: 'messageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['message'] as _i7.MessageEndpoint).deleteMessage(
                session,
                params['messageId'],
              ),
        ),
        'addReaction': _i1.MethodConnector(
          name: 'addReaction',
          params: {
            'messageId': _i1.ParameterDescription(
              name: 'messageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'emoji': _i1.ParameterDescription(
              name: 'emoji',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['message'] as _i7.MessageEndpoint).addReaction(
                session,
                params['messageId'],
                params['emoji'],
              ),
        ),
        'removeReaction': _i1.MethodConnector(
          name: 'removeReaction',
          params: {
            'messageId': _i1.ParameterDescription(
              name: 'messageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'emoji': _i1.ParameterDescription(
              name: 'emoji',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['message'] as _i7.MessageEndpoint).removeReaction(
                session,
                params['messageId'],
                params['emoji'],
              ),
        ),
        'markAsRead': _i1.MethodConnector(
          name: 'markAsRead',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'lastReadMessageId': _i1.ParameterDescription(
              name: 'lastReadMessageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['message'] as _i7.MessageEndpoint).markAsRead(
                session,
                params['chatId'],
                params['lastReadMessageId'],
              ),
        ),
        'getMessages': _i1.MethodConnector(
          name: 'getMessages',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'beforeMessageId': _i1.ParameterDescription(
              name: 'beforeMessageId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['message'] as _i7.MessageEndpoint).getMessages(
                session,
                params['chatId'],
                beforeMessageId: params['beforeMessageId'],
                limit: params['limit'],
              ),
        ),
        'sendTypingIndicator': _i1.MethodConnector(
          name: 'sendTypingIndicator',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['message'] as _i7.MessageEndpoint).sendTypingIndicator(
                session,
                params['chatId'],
              ),
        ),
        'chatStream': _i1.MethodStreamConnector(
          name: 'chatStream',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
                Map<String, Stream> streamParams,
              ) => (endpoints['message'] as _i7.MessageEndpoint).chatStream(
                session,
                params['chatId'],
              ),
        ),
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getMyProfile': _i1.MethodConnector(
          name: 'getMyProfile',
          params: {},
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i8.UserEndpoint).getMyProfile(session),
        ),
        'updateProfile': _i1.MethodConnector(
          name: 'updateProfile',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i8.UserEndpoint).updateProfile(
                session,
                params['name'],
              ),
        ),
        'listAllUsers': _i1.MethodConnector(
          name: 'listAllUsers',
          params: {},
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i8.UserEndpoint).listAllUsers(session),
        ),
        'getUsersInChat': _i1.MethodConnector(
          name: 'getUsersInChat',
          params: {
            'chatId': _i1.ParameterDescription(
              name: 'chatId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['user'] as _i8.UserEndpoint).getUsersInChat(
                session,
                params['chatId'],
              ),
        ),
      },
    );
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (_i1.Session session, Map<String, dynamic> params) async =>
              (endpoints['greeting'] as _i9.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    modules['serverpod_auth_idp'] = _i11.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _i12.Endpoints()
      ..initializeEndpoints(server);
  }
}
