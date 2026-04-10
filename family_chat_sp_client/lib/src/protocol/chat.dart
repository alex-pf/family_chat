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

abstract class Chat implements _i1.SerializableModel {
  Chat._({
    this.id,
    required this.name,
    bool? isGroup,
    this.ownerUserId,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    required this.createdAt,
    required this.updatedAt,
  }) : isGroup = isGroup ?? false,
       backgroundId = backgroundId ?? 'default',
       textColor = textColor ?? '#FFFFFF',
       isArchived = isArchived ?? false;

  factory Chat({
    int? id,
    required String name,
    bool? isGroup,
    int? ownerUserId,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChatImpl;

  factory Chat.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chat(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      isGroup: jsonSerialization['isGroup'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isGroup']),
      ownerUserId: jsonSerialization['ownerUserId'] as int?,
      backgroundId: jsonSerialization['backgroundId'] as String?,
      textColor: jsonSerialization['textColor'] as String?,
      isArchived: jsonSerialization['isArchived'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isArchived']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  bool isGroup;

  int? ownerUserId;

  String backgroundId;

  String textColor;

  bool isArchived;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Chat copyWith({
    int? id,
    String? name,
    bool? isGroup,
    int? ownerUserId,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Chat',
      if (id != null) 'id': id,
      'name': name,
      'isGroup': isGroup,
      if (ownerUserId != null) 'ownerUserId': ownerUserId,
      'backgroundId': backgroundId,
      'textColor': textColor,
      'isArchived': isArchived,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatImpl extends Chat {
  _ChatImpl({
    int? id,
    required String name,
    bool? isGroup,
    int? ownerUserId,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         name: name,
         isGroup: isGroup,
         ownerUserId: ownerUserId,
         backgroundId: backgroundId,
         textColor: textColor,
         isArchived: isArchived,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Chat copyWith({
    Object? id = _Undefined,
    String? name,
    bool? isGroup,
    Object? ownerUserId = _Undefined,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chat(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      isGroup: isGroup ?? this.isGroup,
      ownerUserId: ownerUserId is int? ? ownerUserId : this.ownerUserId,
      backgroundId: backgroundId ?? this.backgroundId,
      textColor: textColor ?? this.textColor,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
