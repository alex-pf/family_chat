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

abstract class ChatMessage implements _i1.SerializableModel {
  ChatMessage._({
    this.id,
    required this.chatId,
    required this.senderUserId,
    this.text,
    this.imageUrl,
    this.fileUrl,
    this.fileName,
    this.fileSize,
    bool? isDeleted,
    bool? isEdited,
    required this.createdAt,
    this.editedAt,
  }) : isDeleted = isDeleted ?? false,
       isEdited = isEdited ?? false;

  factory ChatMessage({
    int? id,
    required int chatId,
    required int senderUserId,
    String? text,
    String? imageUrl,
    String? fileUrl,
    String? fileName,
    int? fileSize,
    bool? isDeleted,
    bool? isEdited,
    required DateTime createdAt,
    DateTime? editedAt,
  }) = _ChatMessageImpl;

  factory ChatMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatMessage(
      id: jsonSerialization['id'] as int?,
      chatId: jsonSerialization['chatId'] as int,
      senderUserId: jsonSerialization['senderUserId'] as int,
      text: jsonSerialization['text'] as String?,
      imageUrl: jsonSerialization['imageUrl'] as String?,
      fileUrl: jsonSerialization['fileUrl'] as String?,
      fileName: jsonSerialization['fileName'] as String?,
      fileSize: jsonSerialization['fileSize'] as int?,
      isDeleted: jsonSerialization['isDeleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isDeleted']),
      isEdited: jsonSerialization['isEdited'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isEdited']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      editedAt: jsonSerialization['editedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['editedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int chatId;

  int senderUserId;

  String? text;

  String? imageUrl;

  String? fileUrl;

  String? fileName;

  int? fileSize;

  bool isDeleted;

  bool isEdited;

  DateTime createdAt;

  DateTime? editedAt;

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatMessage copyWith({
    int? id,
    int? chatId,
    int? senderUserId,
    String? text,
    String? imageUrl,
    String? fileUrl,
    String? fileName,
    int? fileSize,
    bool? isDeleted,
    bool? isEdited,
    DateTime? createdAt,
    DateTime? editedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatMessage',
      if (id != null) 'id': id,
      'chatId': chatId,
      'senderUserId': senderUserId,
      if (text != null) 'text': text,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (fileUrl != null) 'fileUrl': fileUrl,
      if (fileName != null) 'fileName': fileName,
      if (fileSize != null) 'fileSize': fileSize,
      'isDeleted': isDeleted,
      'isEdited': isEdited,
      'createdAt': createdAt.toJson(),
      if (editedAt != null) 'editedAt': editedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatMessageImpl extends ChatMessage {
  _ChatMessageImpl({
    int? id,
    required int chatId,
    required int senderUserId,
    String? text,
    String? imageUrl,
    String? fileUrl,
    String? fileName,
    int? fileSize,
    bool? isDeleted,
    bool? isEdited,
    required DateTime createdAt,
    DateTime? editedAt,
  }) : super._(
         id: id,
         chatId: chatId,
         senderUserId: senderUserId,
         text: text,
         imageUrl: imageUrl,
         fileUrl: fileUrl,
         fileName: fileName,
         fileSize: fileSize,
         isDeleted: isDeleted,
         isEdited: isEdited,
         createdAt: createdAt,
         editedAt: editedAt,
       );

  /// Returns a shallow copy of this [ChatMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatMessage copyWith({
    Object? id = _Undefined,
    int? chatId,
    int? senderUserId,
    Object? text = _Undefined,
    Object? imageUrl = _Undefined,
    Object? fileUrl = _Undefined,
    Object? fileName = _Undefined,
    Object? fileSize = _Undefined,
    bool? isDeleted,
    bool? isEdited,
    DateTime? createdAt,
    Object? editedAt = _Undefined,
  }) {
    return ChatMessage(
      id: id is int? ? id : this.id,
      chatId: chatId ?? this.chatId,
      senderUserId: senderUserId ?? this.senderUserId,
      text: text is String? ? text : this.text,
      imageUrl: imageUrl is String? ? imageUrl : this.imageUrl,
      fileUrl: fileUrl is String? ? fileUrl : this.fileUrl,
      fileName: fileName is String? ? fileName : this.fileName,
      fileSize: fileSize is int? ? fileSize : this.fileSize,
      isDeleted: isDeleted ?? this.isDeleted,
      isEdited: isEdited ?? this.isEdited,
      createdAt: createdAt ?? this.createdAt,
      editedAt: editedAt is DateTime? ? editedAt : this.editedAt,
    );
  }
}
