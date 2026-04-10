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
import 'message.dart' as _i2;
import 'message_reaction.dart' as _i3;
import 'package:family_chat_sp_server/src/generated/protocol.dart' as _i4;

abstract class ChatStreamEvent
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  ChatStreamEvent._({
    required this.type,
    required this.chatId,
    this.message,
    this.reaction,
    this.userId,
  });

  factory ChatStreamEvent({
    required String type,
    required int chatId,
    _i2.ChatMessage? message,
    _i3.MessageReaction? reaction,
    int? userId,
  }) = _ChatStreamEventImpl;

  factory ChatStreamEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatStreamEvent(
      type: jsonSerialization['type'] as String,
      chatId: jsonSerialization['chatId'] as int,
      message: jsonSerialization['message'] == null
          ? null
          : _i4.Protocol().deserialize<_i2.ChatMessage>(
              jsonSerialization['message'],
            ),
      reaction: jsonSerialization['reaction'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.MessageReaction>(
              jsonSerialization['reaction'],
            ),
      userId: jsonSerialization['userId'] as int?,
    );
  }

  String type;

  int chatId;

  _i2.ChatMessage? message;

  _i3.MessageReaction? reaction;

  int? userId;

  /// Returns a shallow copy of this [ChatStreamEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatStreamEvent copyWith({
    String? type,
    int? chatId,
    _i2.ChatMessage? message,
    _i3.MessageReaction? reaction,
    int? userId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatStreamEvent',
      'type': type,
      'chatId': chatId,
      if (message != null) 'message': message?.toJson(),
      if (reaction != null) 'reaction': reaction?.toJson(),
      if (userId != null) 'userId': userId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatStreamEvent',
      'type': type,
      'chatId': chatId,
      if (message != null) 'message': message?.toJsonForProtocol(),
      if (reaction != null) 'reaction': reaction?.toJsonForProtocol(),
      if (userId != null) 'userId': userId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatStreamEventImpl extends ChatStreamEvent {
  _ChatStreamEventImpl({
    required String type,
    required int chatId,
    _i2.ChatMessage? message,
    _i3.MessageReaction? reaction,
    int? userId,
  }) : super._(
         type: type,
         chatId: chatId,
         message: message,
         reaction: reaction,
         userId: userId,
       );

  /// Returns a shallow copy of this [ChatStreamEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatStreamEvent copyWith({
    String? type,
    int? chatId,
    Object? message = _Undefined,
    Object? reaction = _Undefined,
    Object? userId = _Undefined,
  }) {
    return ChatStreamEvent(
      type: type ?? this.type,
      chatId: chatId ?? this.chatId,
      message: message is _i2.ChatMessage? ? message : this.message?.copyWith(),
      reaction: reaction is _i3.MessageReaction?
          ? reaction
          : this.reaction?.copyWith(),
      userId: userId is int? ? userId : this.userId,
    );
  }
}
