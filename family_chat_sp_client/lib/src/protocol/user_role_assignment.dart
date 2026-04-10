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
import 'user_role.dart' as _i2;

abstract class UserRoleAssignment implements _i1.SerializableModel {
  UserRoleAssignment._({
    this.id,
    required this.userId,
    required this.role,
    required this.assignedAt,
    required this.assignedByUserId,
  });

  factory UserRoleAssignment({
    int? id,
    required int userId,
    required _i2.UserRole role,
    required DateTime assignedAt,
    required int assignedByUserId,
  }) = _UserRoleAssignmentImpl;

  factory UserRoleAssignment.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRoleAssignment(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      role: _i2.UserRole.fromJson((jsonSerialization['role'] as String)),
      assignedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['assignedAt'],
      ),
      assignedByUserId: jsonSerialization['assignedByUserId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  _i2.UserRole role;

  DateTime assignedAt;

  int assignedByUserId;

  /// Returns a shallow copy of this [UserRoleAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserRoleAssignment copyWith({
    int? id,
    int? userId,
    _i2.UserRole? role,
    DateTime? assignedAt,
    int? assignedByUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRoleAssignment',
      if (id != null) 'id': id,
      'userId': userId,
      'role': role.toJson(),
      'assignedAt': assignedAt.toJson(),
      'assignedByUserId': assignedByUserId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRoleAssignmentImpl extends UserRoleAssignment {
  _UserRoleAssignmentImpl({
    int? id,
    required int userId,
    required _i2.UserRole role,
    required DateTime assignedAt,
    required int assignedByUserId,
  }) : super._(
         id: id,
         userId: userId,
         role: role,
         assignedAt: assignedAt,
         assignedByUserId: assignedByUserId,
       );

  /// Returns a shallow copy of this [UserRoleAssignment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserRoleAssignment copyWith({
    Object? id = _Undefined,
    int? userId,
    _i2.UserRole? role,
    DateTime? assignedAt,
    int? assignedByUserId,
  }) {
    return UserRoleAssignment(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      assignedAt: assignedAt ?? this.assignedAt,
      assignedByUserId: assignedByUserId ?? this.assignedByUserId,
    );
  }
}
