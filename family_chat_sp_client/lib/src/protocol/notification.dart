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

abstract class AppNotification implements _i1.SerializableModel {
  AppNotification._({
    this.id,
    required this.recipientUserId,
    required this.type,
    required this.title,
    required this.body,
    this.relatedEntityId,
    bool? isRead,
    required this.createdAt,
  }) : isRead = isRead ?? false;

  factory AppNotification({
    int? id,
    required int recipientUserId,
    required String type,
    required String title,
    required String body,
    int? relatedEntityId,
    bool? isRead,
    required DateTime createdAt,
  }) = _AppNotificationImpl;

  factory AppNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppNotification(
      id: jsonSerialization['id'] as int?,
      recipientUserId: jsonSerialization['recipientUserId'] as int,
      type: jsonSerialization['type'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      relatedEntityId: jsonSerialization['relatedEntityId'] as int?,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int recipientUserId;

  String type;

  String title;

  String body;

  int? relatedEntityId;

  bool isRead;

  DateTime createdAt;

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppNotification copyWith({
    int? id,
    int? recipientUserId,
    String? type,
    String? title,
    String? body,
    int? relatedEntityId,
    bool? isRead,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppNotification',
      if (id != null) 'id': id,
      'recipientUserId': recipientUserId,
      'type': type,
      'title': title,
      'body': body,
      if (relatedEntityId != null) 'relatedEntityId': relatedEntityId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppNotificationImpl extends AppNotification {
  _AppNotificationImpl({
    int? id,
    required int recipientUserId,
    required String type,
    required String title,
    required String body,
    int? relatedEntityId,
    bool? isRead,
    required DateTime createdAt,
  }) : super._(
         id: id,
         recipientUserId: recipientUserId,
         type: type,
         title: title,
         body: body,
         relatedEntityId: relatedEntityId,
         isRead: isRead,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppNotification copyWith({
    Object? id = _Undefined,
    int? recipientUserId,
    String? type,
    String? title,
    String? body,
    Object? relatedEntityId = _Undefined,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id is int? ? id : this.id,
      recipientUserId: recipientUserId ?? this.recipientUserId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      relatedEntityId: relatedEntityId is int?
          ? relatedEntityId
          : this.relatedEntityId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
