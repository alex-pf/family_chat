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

abstract class OneTimeToken implements _i1.SerializableModel {
  OneTimeToken._({
    this.id,
    required this.token,
    required this.userId,
    required this.expiresAt,
    this.usedAt,
    this.requestedByUserId,
  });

  factory OneTimeToken({
    int? id,
    required String token,
    required int userId,
    required DateTime expiresAt,
    DateTime? usedAt,
    int? requestedByUserId,
  }) = _OneTimeTokenImpl;

  factory OneTimeToken.fromJson(Map<String, dynamic> jsonSerialization) {
    return OneTimeToken(
      id: jsonSerialization['id'] as int?,
      token: jsonSerialization['token'] as String,
      userId: jsonSerialization['userId'] as int,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      usedAt: jsonSerialization['usedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['usedAt']),
      requestedByUserId: jsonSerialization['requestedByUserId'] as int?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String token;

  int userId;

  DateTime expiresAt;

  DateTime? usedAt;

  int? requestedByUserId;

  /// Returns a shallow copy of this [OneTimeToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OneTimeToken copyWith({
    int? id,
    String? token,
    int? userId,
    DateTime? expiresAt,
    DateTime? usedAt,
    int? requestedByUserId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OneTimeToken',
      if (id != null) 'id': id,
      'token': token,
      'userId': userId,
      'expiresAt': expiresAt.toJson(),
      if (usedAt != null) 'usedAt': usedAt?.toJson(),
      if (requestedByUserId != null) 'requestedByUserId': requestedByUserId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OneTimeTokenImpl extends OneTimeToken {
  _OneTimeTokenImpl({
    int? id,
    required String token,
    required int userId,
    required DateTime expiresAt,
    DateTime? usedAt,
    int? requestedByUserId,
  }) : super._(
         id: id,
         token: token,
         userId: userId,
         expiresAt: expiresAt,
         usedAt: usedAt,
         requestedByUserId: requestedByUserId,
       );

  /// Returns a shallow copy of this [OneTimeToken]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OneTimeToken copyWith({
    Object? id = _Undefined,
    String? token,
    int? userId,
    DateTime? expiresAt,
    Object? usedAt = _Undefined,
    Object? requestedByUserId = _Undefined,
  }) {
    return OneTimeToken(
      id: id is int? ? id : this.id,
      token: token ?? this.token,
      userId: userId ?? this.userId,
      expiresAt: expiresAt ?? this.expiresAt,
      usedAt: usedAt is DateTime? ? usedAt : this.usedAt,
      requestedByUserId: requestedByUserId is int?
          ? requestedByUserId
          : this.requestedByUserId,
    );
  }
}
