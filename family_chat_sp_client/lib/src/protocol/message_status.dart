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

abstract class MessageStatus implements _i1.SerializableModel {
  MessageStatus._({
    this.id,
    required this.messageId,
    required this.userId,
    required this.status,
    required this.updatedAt,
  });

  factory MessageStatus({
    int? id,
    required int messageId,
    required int userId,
    required String status,
    required DateTime updatedAt,
  }) = _MessageStatusImpl;

  factory MessageStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return MessageStatus(
      id: jsonSerialization['id'] as int?,
      messageId: jsonSerialization['messageId'] as int,
      userId: jsonSerialization['userId'] as int,
      status: jsonSerialization['status'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int messageId;

  int userId;

  String status;

  DateTime updatedAt;

  /// Returns a shallow copy of this [MessageStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MessageStatus copyWith({
    int? id,
    int? messageId,
    int? userId,
    String? status,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MessageStatus',
      if (id != null) 'id': id,
      'messageId': messageId,
      'userId': userId,
      'status': status,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessageStatusImpl extends MessageStatus {
  _MessageStatusImpl({
    int? id,
    required int messageId,
    required int userId,
    required String status,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         messageId: messageId,
         userId: userId,
         status: status,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MessageStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MessageStatus copyWith({
    Object? id = _Undefined,
    int? messageId,
    int? userId,
    String? status,
    DateTime? updatedAt,
  }) {
    return MessageStatus(
      id: id is int? ? id : this.id,
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
