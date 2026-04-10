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

abstract class FileDeletionPreview implements _i1.SerializableModel {
  FileDeletionPreview._({
    required this.totalBytes,
    required this.fileCount,
    this.oldestFileDate,
  });

  factory FileDeletionPreview({
    required int totalBytes,
    required int fileCount,
    DateTime? oldestFileDate,
  }) = _FileDeletionPreviewImpl;

  factory FileDeletionPreview.fromJson(Map<String, dynamic> jsonSerialization) {
    return FileDeletionPreview(
      totalBytes: jsonSerialization['totalBytes'] as int,
      fileCount: jsonSerialization['fileCount'] as int,
      oldestFileDate: jsonSerialization['oldestFileDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['oldestFileDate'],
            ),
    );
  }

  int totalBytes;

  int fileCount;

  DateTime? oldestFileDate;

  /// Returns a shallow copy of this [FileDeletionPreview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FileDeletionPreview copyWith({
    int? totalBytes,
    int? fileCount,
    DateTime? oldestFileDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FileDeletionPreview',
      'totalBytes': totalBytes,
      'fileCount': fileCount,
      if (oldestFileDate != null) 'oldestFileDate': oldestFileDate?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _FileDeletionPreviewImpl extends FileDeletionPreview {
  _FileDeletionPreviewImpl({
    required int totalBytes,
    required int fileCount,
    DateTime? oldestFileDate,
  }) : super._(
         totalBytes: totalBytes,
         fileCount: fileCount,
         oldestFileDate: oldestFileDate,
       );

  /// Returns a shallow copy of this [FileDeletionPreview]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FileDeletionPreview copyWith({
    int? totalBytes,
    int? fileCount,
    Object? oldestFileDate = _Undefined,
  }) {
    return FileDeletionPreview(
      totalBytes: totalBytes ?? this.totalBytes,
      fileCount: fileCount ?? this.fileCount,
      oldestFileDate: oldestFileDate is DateTime?
          ? oldestFileDate
          : this.oldestFileDate,
    );
  }
}
