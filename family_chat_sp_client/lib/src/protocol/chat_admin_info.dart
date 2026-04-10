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

abstract class ChatAdminInfo implements _i1.SerializableModel {
  ChatAdminInfo._({
    required this.id,
    required this.name,
    this.ownerName,
    required this.memberCount,
  });

  factory ChatAdminInfo({
    required int id,
    required String name,
    String? ownerName,
    required int memberCount,
  }) = _ChatAdminInfoImpl;

  factory ChatAdminInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatAdminInfo(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      ownerName: jsonSerialization['ownerName'] as String?,
      memberCount: jsonSerialization['memberCount'] as int,
    );
  }

  int id;

  String name;

  String? ownerName;

  int memberCount;

  /// Returns a shallow copy of this [ChatAdminInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatAdminInfo copyWith({
    int? id,
    String? name,
    String? ownerName,
    int? memberCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatAdminInfo',
      'id': id,
      'name': name,
      if (ownerName != null) 'ownerName': ownerName,
      'memberCount': memberCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatAdminInfoImpl extends ChatAdminInfo {
  _ChatAdminInfoImpl({
    required int id,
    required String name,
    String? ownerName,
    required int memberCount,
  }) : super._(
         id: id,
         name: name,
         ownerName: ownerName,
         memberCount: memberCount,
       );

  /// Returns a shallow copy of this [ChatAdminInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatAdminInfo copyWith({
    int? id,
    String? name,
    Object? ownerName = _Undefined,
    int? memberCount,
  }) {
    return ChatAdminInfo(
      id: id ?? this.id,
      name: name ?? this.name,
      ownerName: ownerName is String? ? ownerName : this.ownerName,
      memberCount: memberCount ?? this.memberCount,
    );
  }
}
