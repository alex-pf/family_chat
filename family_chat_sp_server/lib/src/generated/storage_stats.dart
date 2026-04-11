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

abstract class StorageStats
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  StorageStats._({
    required this.totalBytes,
    required this.fileCount,
  });

  factory StorageStats({
    required int totalBytes,
    required int fileCount,
  }) = _StorageStatsImpl;

  factory StorageStats.fromJson(Map<String, dynamic> jsonSerialization) {
    return StorageStats(
      totalBytes: jsonSerialization['totalBytes'] as int,
      fileCount: jsonSerialization['fileCount'] as int,
    );
  }

  int totalBytes;

  int fileCount;

  /// Returns a shallow copy of this [StorageStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StorageStats copyWith({
    int? totalBytes,
    int? fileCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StorageStats',
      'totalBytes': totalBytes,
      'fileCount': fileCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StorageStats',
      'totalBytes': totalBytes,
      'fileCount': fileCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _StorageStatsImpl extends StorageStats {
  _StorageStatsImpl({
    required int totalBytes,
    required int fileCount,
  }) : super._(
         totalBytes: totalBytes,
         fileCount: fileCount,
       );

  /// Returns a shallow copy of this [StorageStats]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StorageStats copyWith({
    int? totalBytes,
    int? fileCount,
  }) {
    return StorageStats(
      totalBytes: totalBytes ?? this.totalBytes,
      fileCount: fileCount ?? this.fileCount,
    );
  }
}
