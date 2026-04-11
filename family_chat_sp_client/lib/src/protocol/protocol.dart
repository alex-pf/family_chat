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
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'chat.dart' as _i2;
import 'chat_admin_info.dart' as _i3;
import 'chat_list_item.dart' as _i4;
import 'chat_member.dart' as _i5;
import 'chat_stream_event.dart' as _i6;
import 'file_deletion_preview.dart' as _i7;
import 'greetings/greeting.dart' as _i8;
import 'message.dart' as _i9;
import 'message_reaction.dart' as _i10;
import 'message_status.dart' as _i11;
import 'notification.dart' as _i12;
import 'one_time_token.dart' as _i13;
import 'storage_stats.dart' as _i14;
import 'system_settings.dart' as _i15;
import 'user.dart' as _i16;
import 'user_role.dart' as _i17;
import 'user_role_assignment.dart' as _i18;
import 'package:family_chat_sp_client/src/protocol/user_role.dart' as _i19;
import 'package:family_chat_sp_client/src/protocol/chat_admin_info.dart'
    as _i20;
import 'package:family_chat_sp_client/src/protocol/chat_list_item.dart' as _i21;
import 'package:family_chat_sp_client/src/protocol/message.dart' as _i22;
import 'package:family_chat_sp_client/src/protocol/user.dart' as _i23;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _i24;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _i25;
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
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

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

    if (t == _i2.Chat) {
      return _i2.Chat.fromJson(data) as T;
    }
    if (t == _i3.ChatAdminInfo) {
      return _i3.ChatAdminInfo.fromJson(data) as T;
    }
    if (t == _i4.ChatListItem) {
      return _i4.ChatListItem.fromJson(data) as T;
    }
    if (t == _i5.ChatMember) {
      return _i5.ChatMember.fromJson(data) as T;
    }
    if (t == _i6.ChatStreamEvent) {
      return _i6.ChatStreamEvent.fromJson(data) as T;
    }
    if (t == _i7.FileDeletionPreview) {
      return _i7.FileDeletionPreview.fromJson(data) as T;
    }
    if (t == _i8.Greeting) {
      return _i8.Greeting.fromJson(data) as T;
    }
    if (t == _i9.ChatMessage) {
      return _i9.ChatMessage.fromJson(data) as T;
    }
    if (t == _i10.MessageReaction) {
      return _i10.MessageReaction.fromJson(data) as T;
    }
    if (t == _i11.MessageStatus) {
      return _i11.MessageStatus.fromJson(data) as T;
    }
    if (t == _i12.AppNotification) {
      return _i12.AppNotification.fromJson(data) as T;
    }
    if (t == _i13.OneTimeToken) {
      return _i13.OneTimeToken.fromJson(data) as T;
    }
    if (t == _i14.StorageStats) {
      return _i14.StorageStats.fromJson(data) as T;
    }
    if (t == _i15.SystemSettings) {
      return _i15.SystemSettings.fromJson(data) as T;
    }
    if (t == _i16.AppUser) {
      return _i16.AppUser.fromJson(data) as T;
    }
    if (t == _i17.UserRole) {
      return _i17.UserRole.fromJson(data) as T;
    }
    if (t == _i18.UserRoleAssignment) {
      return _i18.UserRoleAssignment.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.Chat?>()) {
      return (data != null ? _i2.Chat.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.ChatAdminInfo?>()) {
      return (data != null ? _i3.ChatAdminInfo.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.ChatListItem?>()) {
      return (data != null ? _i4.ChatListItem.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ChatMember?>()) {
      return (data != null ? _i5.ChatMember.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.ChatStreamEvent?>()) {
      return (data != null ? _i6.ChatStreamEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.FileDeletionPreview?>()) {
      return (data != null ? _i7.FileDeletionPreview.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i8.Greeting?>()) {
      return (data != null ? _i8.Greeting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ChatMessage?>()) {
      return (data != null ? _i9.ChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.MessageReaction?>()) {
      return (data != null ? _i10.MessageReaction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.MessageStatus?>()) {
      return (data != null ? _i11.MessageStatus.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i12.AppNotification?>()) {
      return (data != null ? _i12.AppNotification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i13.OneTimeToken?>()) {
      return (data != null ? _i13.OneTimeToken.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i14.StorageStats?>()) {
      return (data != null ? _i14.StorageStats.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i15.SystemSettings?>()) {
      return (data != null ? _i15.SystemSettings.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i16.AppUser?>()) {
      return (data != null ? _i16.AppUser.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i17.UserRole?>()) {
      return (data != null ? _i17.UserRole.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.UserRoleAssignment?>()) {
      return (data != null ? _i18.UserRoleAssignment.fromJson(data) : null)
          as T;
    }
    if (t == List<_i19.UserRole>) {
      return (data as List).map((e) => deserialize<_i19.UserRole>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i20.ChatAdminInfo>) {
      return (data as List)
              .map((e) => deserialize<_i20.ChatAdminInfo>(e))
              .toList()
          as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i21.ChatListItem>) {
      return (data as List)
              .map((e) => deserialize<_i21.ChatListItem>(e))
              .toList()
          as T;
    }
    if (t == List<_i22.ChatMessage>) {
      return (data as List)
              .map((e) => deserialize<_i22.ChatMessage>(e))
              .toList()
          as T;
    }
    if (t == List<_i23.AppUser>) {
      return (data as List).map((e) => deserialize<_i23.AppUser>(e)).toList()
          as T;
    }
    try {
      return _i24.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    try {
      return _i25.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.Chat => 'Chat',
      _i3.ChatAdminInfo => 'ChatAdminInfo',
      _i4.ChatListItem => 'ChatListItem',
      _i5.ChatMember => 'ChatMember',
      _i6.ChatStreamEvent => 'ChatStreamEvent',
      _i7.FileDeletionPreview => 'FileDeletionPreview',
      _i8.Greeting => 'Greeting',
      _i9.ChatMessage => 'ChatMessage',
      _i10.MessageReaction => 'MessageReaction',
      _i11.MessageStatus => 'MessageStatus',
      _i12.AppNotification => 'AppNotification',
      _i13.OneTimeToken => 'OneTimeToken',
      _i14.StorageStats => 'StorageStats',
      _i15.SystemSettings => 'SystemSettings',
      _i16.AppUser => 'AppUser',
      _i17.UserRole => 'UserRole',
      _i18.UserRoleAssignment => 'UserRoleAssignment',
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
      case _i2.Chat():
        return 'Chat';
      case _i3.ChatAdminInfo():
        return 'ChatAdminInfo';
      case _i4.ChatListItem():
        return 'ChatListItem';
      case _i5.ChatMember():
        return 'ChatMember';
      case _i6.ChatStreamEvent():
        return 'ChatStreamEvent';
      case _i7.FileDeletionPreview():
        return 'FileDeletionPreview';
      case _i8.Greeting():
        return 'Greeting';
      case _i9.ChatMessage():
        return 'ChatMessage';
      case _i10.MessageReaction():
        return 'MessageReaction';
      case _i11.MessageStatus():
        return 'MessageStatus';
      case _i12.AppNotification():
        return 'AppNotification';
      case _i13.OneTimeToken():
        return 'OneTimeToken';
      case _i14.StorageStats():
        return 'StorageStats';
      case _i15.SystemSettings():
        return 'SystemSettings';
      case _i16.AppUser():
        return 'AppUser';
      case _i17.UserRole():
        return 'UserRole';
      case _i18.UserRoleAssignment():
        return 'UserRoleAssignment';
    }
    className = _i24.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth_idp.$className';
    }
    className = _i25.Protocol().getClassNameForObject(data);
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
      return deserialize<_i2.Chat>(data['data']);
    }
    if (dataClassName == 'ChatAdminInfo') {
      return deserialize<_i3.ChatAdminInfo>(data['data']);
    }
    if (dataClassName == 'ChatListItem') {
      return deserialize<_i4.ChatListItem>(data['data']);
    }
    if (dataClassName == 'ChatMember') {
      return deserialize<_i5.ChatMember>(data['data']);
    }
    if (dataClassName == 'ChatStreamEvent') {
      return deserialize<_i6.ChatStreamEvent>(data['data']);
    }
    if (dataClassName == 'FileDeletionPreview') {
      return deserialize<_i7.FileDeletionPreview>(data['data']);
    }
    if (dataClassName == 'Greeting') {
      return deserialize<_i8.Greeting>(data['data']);
    }
    if (dataClassName == 'ChatMessage') {
      return deserialize<_i9.ChatMessage>(data['data']);
    }
    if (dataClassName == 'MessageReaction') {
      return deserialize<_i10.MessageReaction>(data['data']);
    }
    if (dataClassName == 'MessageStatus') {
      return deserialize<_i11.MessageStatus>(data['data']);
    }
    if (dataClassName == 'AppNotification') {
      return deserialize<_i12.AppNotification>(data['data']);
    }
    if (dataClassName == 'OneTimeToken') {
      return deserialize<_i13.OneTimeToken>(data['data']);
    }
    if (dataClassName == 'StorageStats') {
      return deserialize<_i14.StorageStats>(data['data']);
    }
    if (dataClassName == 'SystemSettings') {
      return deserialize<_i15.SystemSettings>(data['data']);
    }
    if (dataClassName == 'AppUser') {
      return deserialize<_i16.AppUser>(data['data']);
    }
    if (dataClassName == 'UserRole') {
      return deserialize<_i17.UserRole>(data['data']);
    }
    if (dataClassName == 'UserRoleAssignment') {
      return deserialize<_i18.UserRoleAssignment>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth_idp.')) {
      data['className'] = dataClassName.substring(19);
      return _i24.Protocol().deserializeByClassName(data);
    }
    if (dataClassName.startsWith('serverpod_auth_core.')) {
      data['className'] = dataClassName.substring(20);
      return _i25.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

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
      return _i24.Protocol().mapRecordToJson(record);
    } catch (_) {}
    try {
      return _i25.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
