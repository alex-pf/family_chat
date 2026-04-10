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

abstract class ChatMember implements _i1.SerializableModel {
  ChatMember._({
    this.id,
    required this.chatId,
    required this.userId,
    required this.joinedAt,
    this.lastReadMessageId,
  });

  factory ChatMember({
    int? id,
    required int chatId,
    required int userId,
    required DateTime joinedAt,
    int? lastReadMessageId,
  }) = _ChatMemberImpl;

  factory ChatMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatMember(
      id: jsonSerialization['id'] as int?,
      chatId: jsonSerialization['chatId'] as int,
      userId: jsonSerialization['userId'] as int,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      lastReadMessageId: jsonSerialization['lastReadMessageId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int chatId;

  int userId;

  DateTime joinedAt;

  int? lastReadMessageId;

  /// Returns a shallow copy of this [ChatMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatMember copyWith({
    int? id,
    int? chatId,
    int? userId,
    DateTime? joinedAt,
    int? lastReadMessageId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatMember',
      if (id != null) 'id': id,
      'chatId': chatId,
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
      if (lastReadMessageId != null) 'lastReadMessageId': lastReadMessageId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatMemberImpl extends ChatMember {
  _ChatMemberImpl({
    int? id,
    required int chatId,
    required int userId,
    required DateTime joinedAt,
    int? lastReadMessageId,
  }) : super._(
         id: id,
         chatId: chatId,
         userId: userId,
         joinedAt: joinedAt,
         lastReadMessageId: lastReadMessageId,
       );

  /// Returns a shallow copy of this [ChatMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatMember copyWith({
    Object? id = _Undefined,
    int? chatId,
    int? userId,
    DateTime? joinedAt,
    Object? lastReadMessageId = _Undefined,
  }) {
    return ChatMember(
      id: id is int? ? id : this.id,
      chatId: chatId ?? this.chatId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
      lastReadMessageId: lastReadMessageId is int?
          ? lastReadMessageId
          : this.lastReadMessageId,
    );
  }
}
