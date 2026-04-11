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
import 'package:serverpod/protocol.dart' as _i2;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _i3;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i4;
import 'chat.dart' as _i5;
import 'chat_admin_info.dart' as _i6;
import 'chat_list_item.dart' as _i7;
import 'chat_member.dart' as _i8;
import 'chat_stream_event.dart' as _i9;
import 'file_deletion_preview.dart' as _i10;
import 'greetings/greeting.dart' as _i11;
import 'message.dart' as _i12;
import 'message_reaction.dart' as _i13;
import 'message_status.dart' as _i14;
import 'notification.dart' as _i15;
import 'one_time_token.dart' as _i16;
import 'storage_stats.dart' as _i17;
import 'system_settings.dart' as _i18;
import 'user.dart' as _i19;
import 'user_role.dart' as _i20;
import 'user_role_assignment.dart' as _i21;
import 'package:family_chat_sp_server/src/generated/user_role.dart' as _i22;
import 'package:family_chat_sp_server/src/generated/chat_admin_info.dart'
    as _i23;
import 'package:family_chat_sp_server/src/generated/chat_list_item.dart'
    as _i24;
import 'package:family_chat_sp_server/src/generated/message.dart' as _i25;
import 'package:family_chat_sp_server/src/generated/user.dart' as _i26;
export 'chat.dart';
export 'chat_admin_info.dart';
export 'chat_list_item.dart';
export 'chat_member.dart';
export 'chat_stream_event.dart';
export 'file_deletion_preview.dart';
export 'greetings/greeting.dart';
export 'message.dart';
export 'message_reaction.dart';
export 'message_status.dart';
export 'notification.dart';
export 'one_time_token.dart';
export 'storage_stats.dart';
export 'system_settings.dart';
export 'user.dart';
export 'user_role.dart';
export 'user_role_assignment.dart';

class Protocol extends _i1.SerializationManagerServer {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static final List<_i2.TableDefinition> targetTableDefinitions = [
    _i2.TableDefinition(
      name: 'app_notifications',
      dartName: 'AppNotification',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'app_notifications_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'recipientUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'type',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'title',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'body',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'relatedEntityId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isRead',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_notifications_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'notif_recipient_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'recipientUserId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'isRead',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'app_users',
      dartName: 'AppUser',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'app_users_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'serverpodUserId',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'email',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'avatarColor',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'avatarInitials',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isBlocked',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'mustChangePassword',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastSeenAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'app_users_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'app_user_email_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'email',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'app_user_spid_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'serverpodUserId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'chat_members',
      dartName: 'ChatMember',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'chat_members_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'chatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'joinedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'lastReadMessageId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chat_members_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'chat_member_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'chatId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'chat_member_chat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'chatId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'chat_member_user_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'chat_messages',
      dartName: 'ChatMessage',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'chat_messages_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'chatId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'senderUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'text',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'imageUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fileUrl',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fileName',
          columnType: _i2.ColumnType.text,
          isNullable: true,
          dartType: 'String?',
        ),
        _i2.ColumnDefinition(
          name: 'fileSize',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'isDeleted',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'isEdited',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'editedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chat_messages_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'message_chat_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'chatId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'message_sender_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'senderUserId',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
        _i2.IndexDefinition(
          indexName: 'message_created_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'chatId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'createdAt',
            ),
          ],
          type: 'btree',
          isUnique: false,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'chats',
      dartName: 'Chat',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'chats_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'name',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'isGroup',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'ownerUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
        _i2.ColumnDefinition(
          name: 'backgroundId',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'default\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'textColor',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
          columnDefault: '\'#FFFFFF\'::text',
        ),
        _i2.ColumnDefinition(
          name: 'isArchived',
          columnType: _i2.ColumnType.boolean,
          isNullable: false,
          dartType: 'bool',
          columnDefault: 'false',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'chats_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'message_reactions',
      dartName: 'MessageReaction',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'message_reactions_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'messageId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'emoji',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'createdAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'message_reactions_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'reaction_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'messageId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'emoji',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'message_statuses',
      dartName: 'MessageStatus',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'message_statuses_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'messageId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'status',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'message_statuses_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'msg_status_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'messageId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'one_time_tokens',
      dartName: 'OneTimeToken',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'one_time_tokens_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'token',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'expiresAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'usedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: true,
          dartType: 'DateTime?',
        ),
        _i2.ColumnDefinition(
          name: 'requestedByUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: true,
          dartType: 'int?',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'one_time_tokens_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'ott_token_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'token',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'system_settings',
      dartName: 'SystemSettings',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'system_settings_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'key',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'value',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'String',
        ),
        _i2.ColumnDefinition(
          name: 'updatedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'system_settings_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'settings_key_idx',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'key',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    _i2.TableDefinition(
      name: 'user_role_assignments',
      dartName: 'UserRoleAssignment',
      schema: 'public',
      module: 'family_chat_sp',
      columns: [
        _i2.ColumnDefinition(
          name: 'id',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int?',
          columnDefault: 'nextval(\'user_role_assignments_id_seq\'::regclass)',
        ),
        _i2.ColumnDefinition(
          name: 'userId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
        _i2.ColumnDefinition(
          name: 'role',
          columnType: _i2.ColumnType.text,
          isNullable: false,
          dartType: 'protocol:UserRole',
        ),
        _i2.ColumnDefinition(
          name: 'assignedAt',
          columnType: _i2.ColumnType.timestampWithoutTimeZone,
          isNullable: false,
          dartType: 'DateTime',
        ),
        _i2.ColumnDefinition(
          name: 'assignedByUserId',
          columnType: _i2.ColumnType.bigint,
          isNullable: false,
          dartType: 'int',
        ),
      ],
      foreignKeys: [],
      indexes: [
        _i2.IndexDefinition(
          indexName: 'user_role_assignments_pkey',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'id',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: true,
        ),
        _i2.IndexDefinition(
          indexName: 'user_role_unique',
          tableSpace: null,
          elements: [
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'userId',
            ),
            _i2.IndexElementDefinition(
              type: _i2.IndexElementDefinitionType.column,
              definition: 'role',
            ),
          ],
          type: 'btree',
          isUnique: true,
          isPrimary: false,
        ),
      ],
      managed: true,
    ),
    ..._i3.Protocol.targetTableDefinitions,
    ..._i4.Protocol.targetTableDefinitions,
    ..._i2.Protocol.targetTableDefinitions,
  ];

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i5.Chat) {
      return _i5.Chat.fromJson(data) as T;
    }
    if (t == _i6.ChatAdminInfo) {
      return _i6.ChatAdminInfo.fromJson(data) as T;
    }
    if (t == _i7.ChatListItem) {
      return _i7.ChatListItem.fromJson(data) as T;
    }
    if (t == _i8.ChatMember) {
      return _i8.ChatMember.fromJson(data) as T;
    }
    if (t == _i9.ChatStreamEvent) {
      return _i9.ChatStreamEvent.fromJson(data) as T;
    }
    if (t == _i10.FileDeletionPreview) {
      return _i10.FileDeletionPreview.fromJson(data) as T;
    }
    if (t == _i11.Greeting) {
      return _i11.Greeting.fromJson(data) as T;
    }
    if (t == _i12.ChatMessage) {
      return _i12.ChatMessage.fromJson(data) as T;
    }
    if (t == _i13.MessageReaction) {
      return _i13.MessageReaction.fromJson(data) as T;
    }
    if (t == _i14.MessageStatus) {
      return _i14.MessageStatus.fromJson(data) as T;
    }
    if (t == _i15.AppNotification) {
      return _i15.AppNotification.fromJson(data) as T;
    }
    if (t == _i16.OneTimeToken) {
      return _i16.OneTimeToken.fromJson(data) as T;
    }
    if (t == _i17.StorageStats) {
      return _i17.StorageStats.fromJson(data) as T;
    }
    if (t == _i18.SystemSettings) {
      return _i18.SystemSettings.fromJson(data) as T;
    }
    if (t == _i19.AppUser) {
      return _i19.AppUser.fromJson(data) as T;
    }
    if (t == _i20.UserRole) {
      return _i20.UserRole.fromJson(data) as T;
    }
    if (t == _i21.UserRoleAssignment) {
      return _i21.UserRoleAssignment.fromJson(data) as T;
    }
    if (t == _i1.getType<_i5.Chat?>()) {
      return (data != null ? _i5.Chat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ChatAdminInfo?>()) {
      return (data != null ? _i6.ChatAdminInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.ChatListItem?>()) {
      return (data != null ? _i7.ChatListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.ChatMember?>()) {
      return (data != null ? _i8.ChatMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ChatStreamEvent?>()) {
      return (data != null ? _i9.ChatStreamEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.FileDeletionPreview?>()) {
      return (data != null ? _i10.FileDeletionPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i11.Greeting?>()) {
      return (data != null ? _i11.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.ChatMessage?>()) {
      return (data != null ? _i12.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.MessageReaction?>()) {
      return (data != null ? _i13.MessageReaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.MessageStatus?>()) {
      return (data != null ? _i14.MessageStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.AppNotification?>()) {
      return (data != null ? _i15.AppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.OneTimeToken?>()) {
      return (data != null ? _i16.OneTimeToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.StorageStats?>()) {
      return (data != null ? _i17.StorageStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.SystemSettings?>()) {
      return (data != null ? _i18.SystemSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.AppUser?>()) {
      return (data != null ? _i19.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.UserRole?>()) {
      return (data != null ? _i20.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i21.UserRoleAssignment?>()) {
      return (data != null ? _i21.UserRoleAssignment.fromJson(data) : null)
          as T;
    }
    if (t == List<_i22.UserRole>) {
      return (data as List).map((e) => deserialize<_i22.UserRole>(e)).toList()
          as T;
    }
    if (t == List<_i23.ChatAdminInfo>) {
      return (data as List)
              .map((e) => deserialize<_i23.ChatAdminInfo>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i24.ChatListItem>) {
      return (data as List)
              .map((e) => deserialize<_i24.ChatListItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i25.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i25.ChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i26.AppUser>) {
      return (data as List).map((e) => deserialize<_i26.AppUser>(e)).toList()
          as T;
    }
    try {
      return _i3.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i4.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i2.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i5.Chat => 'Chat',
      _i6.ChatAdminInfo => 'ChatAdminInfo',
      _i7.ChatListItem => 'ChatListItem',
      _i8.ChatMember => 'ChatMember',
      _i9.ChatStreamEvent => 'ChatStreamEvent',
      _i10.FileDeletionPreview => 'FileDeletionPreview',
      _i11.Greeting => 'Greeting',
      _i12.ChatMessage => 'ChatMessage',
      _i13.MessageReaction => 'MessageReaction',
      _i14.MessageStatus => 'MessageStatus',
      _i15.AppNotification => 'AppNotification',
      _i16.OneTimeToken => 'OneTimeToken',
      _i17.StorageStats => 'StorageStats',
      _i18.SystemSettings => 'SystemSettings',
      _i19.AppUser => 'AppUser',
      _i20.UserRole => 'UserRole',
      _i21.UserRoleAssignment => 'UserRoleAssignment',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst(
        'family_chat_sp.',
        '',
      );
    }

    switch (data) {
      case _i5.Chat():
        return 'Chat';
      case _i6.ChatAdminInfo():
        return 'ChatAdminInfo';
      case _i7.ChatListItem():
        return 'ChatListItem';
      case _i8.ChatMember():
        return 'ChatMember';
      case _i9.ChatStreamEvent():
        return 'ChatStreamEvent';
      case _i10.FileDeletionPreview():
        return 'FileDeletionPreview';
      case _i11.Greeting():
        return 'Greeting';
      case _i12.ChatMessage():
        return 'ChatMessage';
      case _i13.MessageReaction():
        return 'MessageReaction';
      case _i14.MessageStatus():
        return 'MessageStatus';
      case _i15.AppNotification():
        return 'AppNotification';
      case _i16.OneTimeToken():
        return 'OneTimeToken';
      case _i17.StorageStats():
        return 'StorageStats';
      case _i18.SystemSettings():
        return 'SystemSettings';
      case _i19.AppUser():
        return 'AppUser';
      case _i20.UserRole():
        return 'UserRole';
      case _i21.UserRoleAssignment():
        return 'UserRoleAssignment';
    }
    className = _i2.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod.$className';
    }
    className = _i3.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i4.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_core.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'Chat') {
      return deserialize<_i5.Chat>(data['data']);
    }
    if (dataClassName == 'ChatAdminInfo') {
      return deserialize<_i6.ChatAdminInfo>(data['data']);
    }
    if (dataClassName == 'ChatListItem') {
      return deserialize<_i7.ChatListItem>(data['data']);
    }
    if (dataClassName == 'ChatMember') {
      return deserialize<_i8.ChatMember>(data['data']);
    }
    if (dataClassName == 'ChatStreamEvent') {
      return deserialize<_i9.ChatStreamEvent>(data['data']);
    }
    if (dataClassName == 'FileDeletionPreview') {
      return deserialize<_i10.FileDeletionPreview>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i11.Greeting>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i12.ChatMessage>(data['data']);
    }
    if (dataClassName == 'MessageReaction') {
      return deserialize<_i13.MessageReaction>(data['data']);
    }
    if (dataClassName == 'MessageStatus') {
      return deserialize<_i14.MessageStatus>(data['data']);
    }
    if (dataClassName == 'AppNotification') {
      return deserialize<_i15.AppNotification>(data['data']);
    }
    if (dataClassName == 'OneTimeToken') {
      return deserialize<_i16.OneTimeToken>(data['data']);
    }
    if (dataClassName == 'StorageStats') {
      return deserialize<_i17.StorageStats>(data['data']);
    }
    if (dataClassName == 'SystemSettings') {
      return deserialize<_i18.SystemSettings>(data['data']);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_i19.AppUser>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i20.UserRole>(data['data']);
    }
    if (dataClassName == 'UserRoleAssignment') {
      return deserialize<_i21.UserRoleAssignment>(data['data']);
    }
    if (dataClassName.startsWith('serverpod.')) {
      data['className'] = dataClassName.substring(10);
      return _i2.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i3.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i4.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  @override
  _i1.Table? getTableForType(Type t) {
    {
      var table = _i3.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i4.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    {
      var table = _i2.Protocol().getTableForType(t);
      if (table != null) {
        return table;
      }
    }
    switch (t) {
      case _i5.Chat:
        return _i5.Chat.t;
      case _i8.ChatMember:
        return _i8.ChatMember.t;
      case _i12.ChatMessage:
        return _i12.ChatMessage.t;
      case _i13.MessageReaction:
        return _i13.MessageReaction.t;
      case _i14.MessageStatus:
        return _i14.MessageStatus.t;
      case _i15.AppNotification:
        return _i15.AppNotification.t;
      case _i16.OneTimeToken:
        return _i16.OneTimeToken.t;
      case _i18.SystemSettings:
        return _i18.SystemSettings.t;
      case _i19.AppUser:
        return _i19.AppUser.t;
      case _i21.UserRoleAssignment:
        return _i21.UserRoleAssignment.t;
    }
    return null;
  }

  @override
  List<_i2.TableDefinition> getTargetTableDefinitions() =>
      targetTableDefinitions;

  @override
  String getModuleName() => 'family_chat_sp';

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i3.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i4.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
