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

abstract class SystemSettings
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = SystemSettingsTable();

  static const db = SystemSettingsRepository._();

  @override
  int? id;

  String key;

  String value;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SystemSettings',
      if (id != null) 'id': id,
      'key': key,
      'value': value,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static SystemSettingsInclude include() {
    return SystemSettingsInclude._();
  }

  static SystemSettingsIncludeList includeList({
    _i1.WhereExpressionBuilder<SystemSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemSettingsTable>? orderByList,
    SystemSettingsInclude? include,
  }) {
    return SystemSettingsIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemSettings.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SystemSettings.t),
      include: include,
    );
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

class SystemSettingsUpdateTable extends _i1.UpdateTable<SystemSettingsTable> {
  SystemSettingsUpdateTable(super.table);

  _i1.ColumnValue<String, String> key(String value) => _i1.ColumnValue(
    table.key,
    value,
  );

  _i1.ColumnValue<String, String> value(String value) => _i1.ColumnValue(
    table.value,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class SystemSettingsTable extends _i1.Table<int?> {
  SystemSettingsTable({super.tableRelation})
    : super(tableName: 'system_settings') {
    updateTable = SystemSettingsUpdateTable(this);
    key = _i1.ColumnString(
      'key',
      this,
    );
    value = _i1.ColumnString(
      'value',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final SystemSettingsUpdateTable updateTable;

  late final _i1.ColumnString key;

  late final _i1.ColumnString value;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    key,
    value,
    updatedAt,
  ];
}

class SystemSettingsInclude extends _i1.IncludeObject {
  SystemSettingsInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SystemSettings.t;
}

class SystemSettingsIncludeList extends _i1.IncludeList {
  SystemSettingsIncludeList._({
    _i1.WhereExpressionBuilder<SystemSettingsTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SystemSettings.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SystemSettings.t;
}

class SystemSettingsRepository {
  const SystemSettingsRepository._();

  /// Returns a list of [SystemSettings]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<SystemSettings>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SystemSettingsTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemSettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SystemSettings>(
      where: where?.call(SystemSettings.t),
      orderBy: orderBy?.call(SystemSettings.t),
      orderByList: orderByList?.call(SystemSettings.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SystemSettings] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<SystemSettings?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SystemSettingsTable>? where,
    int? offset,
    _i1.OrderByBuilder<SystemSettingsTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SystemSettingsTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SystemSettings>(
      where: where?.call(SystemSettings.t),
      orderBy: orderBy?.call(SystemSettings.t),
      orderByList: orderByList?.call(SystemSettings.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SystemSettings] by its [id] or null if no such row exists.
  Future<SystemSettings?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SystemSettings>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SystemSettings]s in the list and returns the inserted rows.
  ///
  /// The returned [SystemSettings]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SystemSettings>> insert(
    _i1.DatabaseSession session,
    List<SystemSettings> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SystemSettings>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SystemSettings] and returns the inserted row.
  ///
  /// The returned [SystemSettings] will have its `id` field set.
  Future<SystemSettings> insertRow(
    _i1.DatabaseSession session,
    SystemSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SystemSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SystemSettings]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SystemSettings>> update(
    _i1.DatabaseSession session,
    List<SystemSettings> rows, {
    _i1.ColumnSelections<SystemSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SystemSettings>(
      rows,
      columns: columns?.call(SystemSettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemSettings]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SystemSettings> updateRow(
    _i1.DatabaseSession session,
    SystemSettings row, {
    _i1.ColumnSelections<SystemSettingsTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SystemSettings>(
      row,
      columns: columns?.call(SystemSettings.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SystemSettings] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SystemSettings?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SystemSettingsUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SystemSettings>(
      id,
      columnValues: columnValues(SystemSettings.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SystemSettings]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SystemSettings>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SystemSettingsUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SystemSettingsTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SystemSettingsTable>? orderBy,
    _i1.OrderByListBuilder<SystemSettingsTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SystemSettings>(
      columnValues: columnValues(SystemSettings.t.updateTable),
      where: where(SystemSettings.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SystemSettings.t),
      orderByList: orderByList?.call(SystemSettings.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SystemSettings]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SystemSettings>> delete(
    _i1.DatabaseSession session,
    List<SystemSettings> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SystemSettings>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SystemSettings].
  Future<SystemSettings> deleteRow(
    _i1.DatabaseSession session,
    SystemSettings row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SystemSettings>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SystemSettings>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SystemSettingsTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SystemSettings>(
      where: where(SystemSettings.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SystemSettingsTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SystemSettings>(
      where: where?.call(SystemSettings.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SystemSettings] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SystemSettingsTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SystemSettings>(
      where: where(SystemSettings.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
