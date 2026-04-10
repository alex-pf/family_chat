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

abstract class ChatListItem
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ChatListItem._({
    required this.chatId,
    required this.name,
    this.lastMessage,
    this.lastMessageTime,
    required this.unreadCount,
    required this.isGroup,
    this.avatarColor,
  });

  factory ChatListItem({
    required int chatId,
    required String name,
    String? lastMessage,
    DateTime? lastMessageTime,
    required int unreadCount,
    required bool isGroup,
    String? avatarColor,
  }) = _ChatListItemImpl;

  factory ChatListItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatListItem(
      chatId: jsonSerialization['chatId'] as int,
      name: jsonSerialization['name'] as String,
      lastMessage: jsonSerialization['lastMessage'] as String?,
      lastMessageTime: jsonSerialization['lastMessageTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastMessageTime'],
            ),
      unreadCount: jsonSerialization['unreadCount'] as int,
      isGroup: _i1.BoolJsonExtension.fromJson(jsonSerialization['isGroup']),
      avatarColor: jsonSerialization['avatarColor'] as String?,
    );
  }

  int chatId;

  String name;

  String? lastMessage;

  DateTime? lastMessageTime;

  int unreadCount;

  bool isGroup;

  String? avatarColor;

  /// Returns a shallow copy of this [ChatListItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatListItem copyWith({
    int? chatId,
    String? name,
    String? lastMessage,
    DateTime? lastMessageTime,
    int? unreadCount,
    bool? isGroup,
    String? avatarColor,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatListItem',
      'chatId': chatId,
      'name': name,
      if (lastMessage != null) 'lastMessage': lastMessage,
      if (lastMessageTime != null) 'lastMessageTime': lastMessageTime?.toJson(),
      'unreadCount': unreadCount,
      'isGroup': isGroup,
      if (avatarColor != null) 'avatarColor': avatarColor,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatListItem',
      'chatId': chatId,
      'name': name,
      if (lastMessage != null) 'lastMessage': lastMessage,
      if (lastMessageTime != null) 'lastMessageTime': lastMessageTime?.toJson(),
      'unreadCount': unreadCount,
      'isGroup': isGroup,
      if (avatarColor != null) 'avatarColor': avatarColor,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatListItemImpl extends ChatListItem {
  _ChatListItemImpl({
    required int chatId,
    required String name,
    String? lastMessage,
    DateTime? lastMessageTime,
    required int unreadCount,
    required bool isGroup,
    String? avatarColor,
  }) : super._(
         chatId: chatId,
         name: name,
         lastMessage: lastMessage,
         lastMessageTime: lastMessageTime,
         unreadCount: unreadCount,
         isGroup: isGroup,
         avatarColor: avatarColor,
       );

  /// Returns a shallow copy of this [ChatListItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatListItem copyWith({
    int? chatId,
    String? name,
    Object? lastMessage = _Undefined,
    Object? lastMessageTime = _Undefined,
    int? unreadCount,
    bool? isGroup,
    Object? avatarColor = _Undefined,
  }) {
    return ChatListItem(
      chatId: chatId ?? this.chatId,
      name: name ?? this.name,
      lastMessage: lastMessage is String? ? lastMessage : this.lastMessage,
      lastMessageTime: lastMessageTime is DateTime?
          ? lastMessageTime
          : this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      isGroup: isGroup ?? this.isGroup,
      avatarColor: avatarColor is String? ? avatarColor : this.avatarColor,
    );
  }
}
