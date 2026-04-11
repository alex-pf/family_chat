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

abstract class MessageStatus
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  MessageStatus._({
    this.id,
    required this.messageId,
    required this.userId,
    required this.status,
    required this.updatedAt,
  });

  factory MessageStatus({
    int? id,
    required int messageId,
    required int userId,
    required String status,
    required DateTime updatedAt,
  }) = _MessageStatusImpl;

  factory MessageStatus.fromJson(Map<String, dynamic> jsonSerialization) {
    return MessageStatus(
      id: jsonSerialization['id'] as int?,
      messageId: jsonSerialization['messageId'] as int,
      userId: jsonSerialization['userId'] as int,
      status: jsonSerialization['status'] as String,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = MessageStatusTable();

  static const db = MessageStatusRepository._();

  @override
  int? id;

  int messageId;

  int userId;

  String status;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [MessageStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  MessageStatus copyWith({
    int? id,
    int? messageId,
    int? userId,
    String? status,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'MessageStatus',
      if (id != null) 'id': id,
      'messageId': messageId,
      'userId': userId,
      'status': status,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'MessageStatus',
      if (id != null) 'id': id,
      'messageId': messageId,
      'userId': userId,
      'status': status,
      'updatedAt': updatedAt.toJson(),
    };
  }

  static MessageStatusInclude include() {
    return MessageStatusInclude._();
  }

  static MessageStatusIncludeList includeList({
    _i1.WhereExpressionBuilder<MessageStatusTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessageStatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessageStatusTable>? orderByList,
    MessageStatusInclude? include,
  }) {
    return MessageStatusIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MessageStatus.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(MessageStatus.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _MessageStatusImpl extends MessageStatus {
  _MessageStatusImpl({
    int? id,
    required int messageId,
    required int userId,
    required String status,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         messageId: messageId,
         userId: userId,
         status: status,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [MessageStatus]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  MessageStatus copyWith({
    Object? id = _Undefined,
    int? messageId,
    int? userId,
    String? status,
    DateTime? updatedAt,
  }) {
    return MessageStatus(
      id: id is int? ? id : this.id,
      messageId: messageId ?? this.messageId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class MessageStatusUpdateTable extends _i1.UpdateTable<MessageStatusTable> {
  MessageStatusUpdateTable(super.table);

  _i1.ColumnValue<int, int> messageId(int value) => _i1.ColumnValue(
    table.messageId,
    value,
  );

  _i1.ColumnValue<int, int> userId(int value) => _i1.ColumnValue(
    table.userId,
    value,
  );

  _i1.ColumnValue<String, String> status(String value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class MessageStatusTable extends _i1.Table<int?> {
  MessageStatusTable({super.tableRelation})
    : super(tableName: 'message_statuses') {
    updateTable = MessageStatusUpdateTable(this);
    messageId = _i1.ColumnInt(
      'messageId',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    status = _i1.ColumnString(
      'status',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final MessageStatusUpdateTable updateTable;

  late final _i1.ColumnInt messageId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnString status;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    messageId,
    userId,
    status,
    updatedAt,
  ];
}

class MessageStatusInclude extends _i1.IncludeObject {
  MessageStatusInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => MessageStatus.t;
}

class MessageStatusIncludeList extends _i1.IncludeList {
  MessageStatusIncludeList._({
    _i1.WhereExpressionBuilder<MessageStatusTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(MessageStatus.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => MessageStatus.t;
}

class MessageStatusRepository {
  const MessageStatusRepository._();

  /// Returns a list of [MessageStatus]s matching the given query parameters.
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
  Future<List<MessageStatus>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MessageStatusTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessageStatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessageStatusTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<MessageStatus>(
      where: where?.call(MessageStatus.t),
      orderBy: orderBy?.call(MessageStatus.t),
      orderByList: orderByList?.call(MessageStatus.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [MessageStatus] matching the given query parameters.
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
  Future<MessageStatus?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MessageStatusTable>? where,
    int? offset,
    _i1.OrderByBuilder<MessageStatusTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<MessageStatusTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<MessageStatus>(
      where: where?.call(MessageStatus.t),
      orderBy: orderBy?.call(MessageStatus.t),
      orderByList: orderByList?.call(MessageStatus.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [MessageStatus] by its [id] or null if no such row exists.
  Future<MessageStatus?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<MessageStatus>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [MessageStatus]s in the list and returns the inserted rows.
  ///
  /// The returned [MessageStatus]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<MessageStatus>> insert(
    _i1.DatabaseSession session,
    List<MessageStatus> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<MessageStatus>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [MessageStatus] and returns the inserted row.
  ///
  /// The returned [MessageStatus] will have its `id` field set.
  Future<MessageStatus> insertRow(
    _i1.DatabaseSession session,
    MessageStatus row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<MessageStatus>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [MessageStatus]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<MessageStatus>> update(
    _i1.DatabaseSession session,
    List<MessageStatus> rows, {
    _i1.ColumnSelections<MessageStatusTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<MessageStatus>(
      rows,
      columns: columns?.call(MessageStatus.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MessageStatus]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<MessageStatus> updateRow(
    _i1.DatabaseSession session,
    MessageStatus row, {
    _i1.ColumnSelections<MessageStatusTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<MessageStatus>(
      row,
      columns: columns?.call(MessageStatus.t),
      transaction: transaction,
    );
  }

  /// Updates a single [MessageStatus] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<MessageStatus?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<MessageStatusUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<MessageStatus>(
      id,
      columnValues: columnValues(MessageStatus.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [MessageStatus]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<MessageStatus>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<MessageStatusUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<MessageStatusTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<MessageStatusTable>? orderBy,
    _i1.OrderByListBuilder<MessageStatusTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<MessageStatus>(
      columnValues: columnValues(MessageStatus.t.updateTable),
      where: where(MessageStatus.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(MessageStatus.t),
      orderByList: orderByList?.call(MessageStatus.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [MessageStatus]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<MessageStatus>> delete(
    _i1.DatabaseSession session,
    List<MessageStatus> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<MessageStatus>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [MessageStatus].
  Future<MessageStatus> deleteRow(
    _i1.DatabaseSession session,
    MessageStatus row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<MessageStatus>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<MessageStatus>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MessageStatusTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<MessageStatus>(
      where: where(MessageStatus.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<MessageStatusTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<MessageStatus>(
      where: where?.call(MessageStatus.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [MessageStatus] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<MessageStatusTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<MessageStatus>(
      where: where(MessageStatus.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
