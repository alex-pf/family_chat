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

abstract class AppNotification
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  AppNotification._({
    this.id,
    required this.recipientUserId,
    required this.type,
    required this.title,
    required this.body,
    this.relatedEntityId,
    bool? isRead,
    required this.createdAt,
  }) : isRead = isRead ?? false;

  factory AppNotification({
    int? id,
    required int recipientUserId,
    required String type,
    required String title,
    required String body,
    int? relatedEntityId,
    bool? isRead,
    required DateTime createdAt,
  }) = _AppNotificationImpl;

  factory AppNotification.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppNotification(
      id: jsonSerialization['id'] as int?,
      recipientUserId: jsonSerialization['recipientUserId'] as int,
      type: jsonSerialization['type'] as String,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      relatedEntityId: jsonSerialization['relatedEntityId'] as int?,
      isRead: jsonSerialization['isRead'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isRead']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  static final t = AppNotificationTable();

  static const db = AppNotificationRepository._();

  @override
  int? id;

  int recipientUserId;

  String type;

  String title;

  String body;

  int? relatedEntityId;

  bool isRead;

  DateTime createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AppNotification copyWith({
    int? id,
    int? recipientUserId,
    String? type,
    String? title,
    String? body,
    int? relatedEntityId,
    bool? isRead,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppNotification',
      if (id != null) 'id': id,
      'recipientUserId': recipientUserId,
      'type': type,
      'title': title,
      'body': body,
      if (relatedEntityId != null) 'relatedEntityId': relatedEntityId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppNotification',
      if (id != null) 'id': id,
      'recipientUserId': recipientUserId,
      'type': type,
      'title': title,
      'body': body,
      if (relatedEntityId != null) 'relatedEntityId': relatedEntityId,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  static AppNotificationInclude include() {
    return AppNotificationInclude._();
  }

  static AppNotificationIncludeList includeList({
    _i1.WhereExpressionBuilder<AppNotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppNotificationTable>? orderByList,
    AppNotificationInclude? include,
  }) {
    return AppNotificationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppNotification.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(AppNotification.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppNotificationImpl extends AppNotification {
  _AppNotificationImpl({
    int? id,
    required int recipientUserId,
    required String type,
    required String title,
    required String body,
    int? relatedEntityId,
    bool? isRead,
    required DateTime createdAt,
  }) : super._(
         id: id,
         recipientUserId: recipientUserId,
         type: type,
         title: title,
         body: body,
         relatedEntityId: relatedEntityId,
         isRead: isRead,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AppNotification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AppNotification copyWith({
    Object? id = _Undefined,
    int? recipientUserId,
    String? type,
    String? title,
    String? body,
    Object? relatedEntityId = _Undefined,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return AppNotification(
      id: id is int? ? id : this.id,
      recipientUserId: recipientUserId ?? this.recipientUserId,
      type: type ?? this.type,
      title: title ?? this.title,
      body: body ?? this.body,
      relatedEntityId: relatedEntityId is int?
          ? relatedEntityId
          : this.relatedEntityId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

class AppNotificationUpdateTable extends _i1.UpdateTable<AppNotificationTable> {
  AppNotificationUpdateTable(super.table);

  _i1.ColumnValue<int, int> recipientUserId(int value) =>
      _i1.ColumnValue(table.recipientUserId, value);

  _i1.ColumnValue<String, String> type(String value) =>
      _i1.ColumnValue(table.type, value);

  _i1.ColumnValue<String, String> title(String value) =>
      _i1.ColumnValue(table.title, value);

  _i1.ColumnValue<String, String> body(String value) =>
      _i1.ColumnValue(table.body, value);

  _i1.ColumnValue<int, int> relatedEntityId(int? value) =>
      _i1.ColumnValue(table.relatedEntityId, value);

  _i1.ColumnValue<bool, bool> isRead(bool value) =>
      _i1.ColumnValue(table.isRead, value);

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(table.createdAt, value);
}

class AppNotificationTable extends _i1.Table<int?> {
  AppNotificationTable({super.tableRelation})
    : super(tableName: 'app_notifications') {
    updateTable = AppNotificationUpdateTable(this);
    recipientUserId = _i1.ColumnInt('recipientUserId', this);
    type = _i1.ColumnString('type', this);
    title = _i1.ColumnString('title', this);
    body = _i1.ColumnString('body', this);
    relatedEntityId = _i1.ColumnInt('relatedEntityId', this);
    isRead = _i1.ColumnBool('isRead', this, hasDefault: true);
    createdAt = _i1.ColumnDateTime('createdAt', this);
  }

  late final AppNotificationUpdateTable updateTable;

  late final _i1.ColumnInt recipientUserId;

  late final _i1.ColumnString type;

  late final _i1.ColumnString title;

  late final _i1.ColumnString body;

  late final _i1.ColumnInt relatedEntityId;

  late final _i1.ColumnBool isRead;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    recipientUserId,
    type,
    title,
    body,
    relatedEntityId,
    isRead,
    createdAt,
  ];
}

class AppNotificationInclude extends _i1.IncludeObject {
  AppNotificationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => AppNotification.t;
}

class AppNotificationIncludeList extends _i1.IncludeList {
  AppNotificationIncludeList._({
    _i1.WhereExpressionBuilder<AppNotificationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppNotification.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => AppNotification.t;
}

class AppNotificationRepository {
  const AppNotificationRepository._();

  /// Returns a list of [AppNotification]s matching the given query parameters.
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
  Future<List<AppNotification>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppNotificationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppNotificationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AppNotification>(
      where: where?.call(AppNotification.t),
      orderBy: orderBy?.call(AppNotification.t),
      orderByList: orderByList?.call(AppNotification.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AppNotification] matching the given query parameters.
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
  Future<AppNotification?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppNotificationTable>? where,
    int? offset,
    _i1.OrderByBuilder<AppNotificationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<AppNotificationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AppNotification>(
      where: where?.call(AppNotification.t),
      orderBy: orderBy?.call(AppNotification.t),
      orderByList: orderByList?.call(AppNotification.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AppNotification] by its [id] or null if no such row exists.
  Future<AppNotification?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AppNotification>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AppNotification]s in the list and returns the inserted rows.
  ///
  /// The returned [AppNotification]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<AppNotification>> insert(
    _i1.DatabaseSession session,
    List<AppNotification> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<AppNotification>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [AppNotification] and returns the inserted row.
  ///
  /// The returned [AppNotification] will have its `id` field set.
  Future<AppNotification> insertRow(
    _i1.DatabaseSession session,
    AppNotification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<AppNotification>(row, transaction: transaction);
  }

  /// Updates all [AppNotification]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<AppNotification>> update(
    _i1.DatabaseSession session,
    List<AppNotification> rows, {
    _i1.ColumnSelections<AppNotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<AppNotification>(
      rows,
      columns: columns?.call(AppNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppNotification]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppNotification> updateRow(
    _i1.DatabaseSession session,
    AppNotification row, {
    _i1.ColumnSelections<AppNotificationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppNotification>(
      row,
      columns: columns?.call(AppNotification.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppNotification] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AppNotification?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<AppNotificationUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<AppNotification>(
      id,
      columnValues: columnValues(AppNotification.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AppNotification]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<AppNotification>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<AppNotificationUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<AppNotificationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<AppNotificationTable>? orderBy,
    _i1.OrderByListBuilder<AppNotificationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<AppNotification>(
      columnValues: columnValues(AppNotification.t.updateTable),
      where: where(AppNotification.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppNotification.t),
      orderByList: orderByList?.call(AppNotification.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [AppNotification]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<AppNotification>> delete(
    _i1.DatabaseSession session,
    List<AppNotification> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<AppNotification>(rows, transaction: transaction);
  }

  /// Deletes a single [AppNotification].
  Future<AppNotification> deleteRow(
    _i1.DatabaseSession session,
    AppNotification row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AppNotification>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<AppNotification>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppNotificationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<AppNotification>(
      where: where(AppNotification.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<AppNotificationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<AppNotification>(
      where: where?.call(AppNotification.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AppNotification] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<AppNotificationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AppNotification>(
      where: where(AppNotification.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
