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

abstract class OneTimeToken
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = OneTimeTokenTable();

  static const db = OneTimeTokenRepository._();

  @override
  int? id;

  String token;

  int userId;

  DateTime expiresAt;

  DateTime? usedAt;

  int? requestedByUserId;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
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

  static OneTimeTokenInclude include() {
    return OneTimeTokenInclude._();
  }

  static OneTimeTokenIncludeList includeList({
    _i1.WhereExpressionBuilder<OneTimeTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OneTimeTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OneTimeTokenTable>? orderByList,
    OneTimeTokenInclude? include,
  }) {
    return OneTimeTokenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OneTimeToken.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(OneTimeToken.t),
      include: include,
    );
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

class OneTimeTokenUpdateTable extends _i1.UpdateTable<OneTimeTokenTable> {
  OneTimeTokenUpdateTable(super.table);

  _i1.ColumnValue<String, String> token(String value) =>
      _i1.ColumnValue(table.token, value);

  _i1.ColumnValue<int, int> userId(int value) =>
      _i1.ColumnValue(table.userId, value);

  _i1.ColumnValue<DateTime, DateTime> expiresAt(DateTime value) =>
      _i1.ColumnValue(table.expiresAt, value);

  _i1.ColumnValue<DateTime, DateTime> usedAt(DateTime? value) =>
      _i1.ColumnValue(table.usedAt, value);

  _i1.ColumnValue<int, int> requestedByUserId(int? value) =>
      _i1.ColumnValue(table.requestedByUserId, value);
}

class OneTimeTokenTable extends _i1.Table<int?> {
  OneTimeTokenTable({super.tableRelation})
    : super(tableName: 'one_time_tokens') {
    updateTable = OneTimeTokenUpdateTable(this);
    token = _i1.ColumnString('token', this);
    userId = _i1.ColumnInt('userId', this);
    expiresAt = _i1.ColumnDateTime('expiresAt', this);
    usedAt = _i1.ColumnDateTime('usedAt', this);
    requestedByUserId = _i1.ColumnInt('requestedByUserId', this);
  }

  late final OneTimeTokenUpdateTable updateTable;

  late final _i1.ColumnString token;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDateTime expiresAt;

  late final _i1.ColumnDateTime usedAt;

  late final _i1.ColumnInt requestedByUserId;

  @override
  List<_i1.Column> get columns => [
    id,
    token,
    userId,
    expiresAt,
    usedAt,
    requestedByUserId,
  ];
}

class OneTimeTokenInclude extends _i1.IncludeObject {
  OneTimeTokenInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => OneTimeToken.t;
}

class OneTimeTokenIncludeList extends _i1.IncludeList {
  OneTimeTokenIncludeList._({
    _i1.WhereExpressionBuilder<OneTimeTokenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(OneTimeToken.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => OneTimeToken.t;
}

class OneTimeTokenRepository {
  const OneTimeTokenRepository._();

  /// Returns a list of [OneTimeToken]s matching the given query parameters.
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
  Future<List<OneTimeToken>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OneTimeTokenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OneTimeTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OneTimeTokenTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<OneTimeToken>(
      where: where?.call(OneTimeToken.t),
      orderBy: orderBy?.call(OneTimeToken.t),
      orderByList: orderByList?.call(OneTimeToken.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [OneTimeToken] matching the given query parameters.
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
  Future<OneTimeToken?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OneTimeTokenTable>? where,
    int? offset,
    _i1.OrderByBuilder<OneTimeTokenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<OneTimeTokenTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<OneTimeToken>(
      where: where?.call(OneTimeToken.t),
      orderBy: orderBy?.call(OneTimeToken.t),
      orderByList: orderByList?.call(OneTimeToken.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [OneTimeToken] by its [id] or null if no such row exists.
  Future<OneTimeToken?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<OneTimeToken>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [OneTimeToken]s in the list and returns the inserted rows.
  ///
  /// The returned [OneTimeToken]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<OneTimeToken>> insert(
    _i1.DatabaseSession session,
    List<OneTimeToken> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<OneTimeToken>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [OneTimeToken] and returns the inserted row.
  ///
  /// The returned [OneTimeToken] will have its `id` field set.
  Future<OneTimeToken> insertRow(
    _i1.DatabaseSession session,
    OneTimeToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<OneTimeToken>(row, transaction: transaction);
  }

  /// Updates all [OneTimeToken]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<OneTimeToken>> update(
    _i1.DatabaseSession session,
    List<OneTimeToken> rows, {
    _i1.ColumnSelections<OneTimeTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<OneTimeToken>(
      rows,
      columns: columns?.call(OneTimeToken.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OneTimeToken]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<OneTimeToken> updateRow(
    _i1.DatabaseSession session,
    OneTimeToken row, {
    _i1.ColumnSelections<OneTimeTokenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<OneTimeToken>(
      row,
      columns: columns?.call(OneTimeToken.t),
      transaction: transaction,
    );
  }

  /// Updates a single [OneTimeToken] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<OneTimeToken?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<OneTimeTokenUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<OneTimeToken>(
      id,
      columnValues: columnValues(OneTimeToken.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [OneTimeToken]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<OneTimeToken>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<OneTimeTokenUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<OneTimeTokenTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<OneTimeTokenTable>? orderBy,
    _i1.OrderByListBuilder<OneTimeTokenTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<OneTimeToken>(
      columnValues: columnValues(OneTimeToken.t.updateTable),
      where: where(OneTimeToken.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(OneTimeToken.t),
      orderByList: orderByList?.call(OneTimeToken.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [OneTimeToken]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<OneTimeToken>> delete(
    _i1.DatabaseSession session,
    List<OneTimeToken> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<OneTimeToken>(rows, transaction: transaction);
  }

  /// Deletes a single [OneTimeToken].
  Future<OneTimeToken> deleteRow(
    _i1.DatabaseSession session,
    OneTimeToken row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<OneTimeToken>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<OneTimeToken>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OneTimeTokenTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<OneTimeToken>(
      where: where(OneTimeToken.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<OneTimeTokenTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<OneTimeToken>(
      where: where?.call(OneTimeToken.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [OneTimeToken] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<OneTimeTokenTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<OneTimeToken>(
      where: where(OneTimeToken.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
