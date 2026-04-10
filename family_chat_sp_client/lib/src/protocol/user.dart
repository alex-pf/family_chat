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

abstract class AppUser implements _i1.SerializableModel {
  AppUser._({
    this.id,
    this.serverpodUserId,
    required this.email,
    required this.name,
    required this.avatarColor,
    required this.avatarInitials,
    bool? isBlocked,
    bool? mustChangePassword,
    required this.createdAt,
    this.lastSeenAt,
  }) : isBlocked = isBlocked ?? false,
       mustChangePassword = mustChangePassword ?? false;

  factory AppUser({
    int? id,
    String? serverpodUserId,
    required String email,
    required String name,
    required String avatarColor,
    required String avatarInitials,
    bool? isBlocked,
    bool? mustChangePassword,
    required DateTime createdAt,
    DateTime? lastSeenAt,
  }) = _AppUserImpl;

  factory AppUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUser(
      id: jsonSerialization['id'] as int?,
      serverpodUserId: jsonSerialization['serverpodUserId'] as String?,
      email: jsonSerialization['email'] as String,
      name: jsonSerialization['name'] as String,
      avatarColor: jsonSerialization['avatarColor'] as String,
      avatarInitials: jsonSerialization['avatarInitials'] as String,
      isBlocked: jsonSerialization['isBlocked'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isBlocked']),
      mustChangePassword: jsonSerialization['mustChangePassword'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(
              jsonSerialization['mustChangePassword'],
            ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String? serverpodUserId;

  String email;

  String name;

  String avatarColor;

  String avatarInitials;

  bool isBlocked;

  bool mustChangePassword;

  DateTime createdAt;

  DateTime? lastSeenAt;

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppUser copyWith({
    int? id,
    String? serverpodUserId,
    String? email,
    String? name,
    String? avatarColor,
    String? avatarInitials,
    bool? isBlocked,
    bool? mustChangePassword,
    DateTime? createdAt,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUser',
      if (id != null) 'id': id,
      if (serverpodUserId != null) 'serverpodUserId': serverpodUserId,
      'email': email,
      'name': name,
      'avatarColor': avatarColor,
      'avatarInitials': avatarInitials,
      'isBlocked': isBlocked,
      'mustChangePassword': mustChangePassword,
      'createdAt': createdAt.toJson(),
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUserImpl extends AppUser {
  _AppUserImpl({
    int? id,
    String? serverpodUserId,
    required String email,
    required String name,
    required String avatarColor,
    required String avatarInitials,
    bool? isBlocked,
    bool? mustChangePassword,
    required DateTime createdAt,
    DateTime? lastSeenAt,
  }) : super._(
         id: id,
         serverpodUserId: serverpodUserId,
         email: email,
         name: name,
         avatarColor: avatarColor,
         avatarInitials: avatarInitials,
         isBlocked: isBlocked,
         mustChangePassword: mustChangePassword,
         createdAt: createdAt,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [AppUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppUser copyWith({
    Object? id = _Undefined,
    Object? serverpodUserId = _Undefined,
    String? email,
    String? name,
    String? avatarColor,
    String? avatarInitials,
    bool? isBlocked,
    bool? mustChangePassword,
    DateTime? createdAt,
    Object? lastSeenAt = _Undefined,
  }) {
    return AppUser(
      id: id is int? ? id : this.id,
      serverpodUserId: serverpodUserId is String?
          ? serverpodUserId
          : this.serverpodUserId,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarColor: avatarColor ?? this.avatarColor,
      avatarInitials: avatarInitials ?? this.avatarInitials,
      isBlocked: isBlocked ?? this.isBlocked,
      mustChangePassword: mustChangePassword ?? this.mustChangePassword,
      createdAt: createdAt ?? this.createdAt,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
    );
  }
}
