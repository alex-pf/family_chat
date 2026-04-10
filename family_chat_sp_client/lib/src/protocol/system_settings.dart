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

abstract class SystemSettings implements _i1.SerializableModel {
  SystemSettings._({
    this.id,
    required this.key,
    required this.value,
    required this.updatedAt,
  });

  factory SystemSettings({
    int? id,
    required String key,
    required String value,
    required DateTime updatedAt,
  }) = _SystemSettingsImpl;

  factory SystemSettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return SystemSettings(
      id: jsonSerialization['id'] as int?,
      key: jsonSerialization['key'] as String,
      value: jsonSerialization['value'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String key;

  String value;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SystemSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SystemSettings copyWith({
    int? id,
    String? key,
    String? value,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SystemSettings',
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SystemSettingsImpl extends SystemSettings {
  _SystemSettingsImpl({
    int? id,
    required String key,
    required String value,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         key: key,
         value: value,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [SystemSettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SystemSettings copyWith({
    Object? id = _Undefined,
    String? key,
    String? value,
    DateTime? updatedAt,
  }) {
    return SystemSettings(
      id: id is int? ? id : this.id,
      key: key ?? this.key,
      value: value ?? this.value,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
