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
import 'user_role.dart' as _i2;

abstract class UserRoleAssignment
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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

  static final t = UserRoleAssignmentTable();

  static const db = UserRoleAssignmentRepository._();

  @override
  int? id;

  int userId;

  _i2.UserRole role;

  DateTime assignedAt;

  int assignedByUserId;

  @override
  _i1.Table<int?> get table => t;

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
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserRoleAssignment',
      if (id != null) 'id': id,
      'userId': userId,
      'role': role.toJson(),
      'assignedAt': assignedAt.toJson(),
      'assignedByUserId': assignedByUserId,
    };
  }

  static UserRoleAssignmentInclude include() {
    return UserRoleAssignmentInclude._();
  }

  static UserRoleAssignmentIncludeList includeList({
    _i1.WhereExpressionBuilder<UserRoleAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRoleAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRoleAssignmentTable>? orderByList,
    UserRoleAssignmentInclude? include,
  }) {
    return UserRoleAssignmentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRoleAssignment.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(UserRoleAssignment.t),
      include: include,
    );
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

class UserRoleAssignmentUpdateTable
    extends _i1.UpdateTable<UserRoleAssignmentTable> {
  UserRoleAssignmentUpdateTable(super.table);

  _i1.ColumnValue<int, int> userId(int value) =>
      _i1.ColumnValue(table.userId, value);

  _i1.ColumnValue<_i2.UserRole, _i2.UserRole> role(_i2.UserRole value) =>
      _i1.ColumnValue(table.role, value);

  _i1.ColumnValue<DateTime, DateTime> assignedAt(DateTime value) =>
      _i1.ColumnValue(table.assignedAt, value);

  _i1.ColumnValue<int, int> assignedByUserId(int value) =>
      _i1.ColumnValue(table.assignedByUserId, value);
}

class UserRoleAssignmentTable extends _i1.Table<int?> {
  UserRoleAssignmentTable({super.tableRelation})
    : super(tableName: 'user_role_assignments') {
    updateTable = UserRoleAssignmentUpdateTable(this);
    userId = _i1.ColumnInt('userId', this);
    role = _i1.ColumnEnum('role', this, _i1.EnumSerialization.byName);
    assignedAt = _i1.ColumnDateTime('assignedAt', this);
    assignedByUserId = _i1.ColumnInt('assignedByUserId', this);
  }

  late final UserRoleAssignmentUpdateTable updateTable;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnEnum<_i2.UserRole> role;

  late final _i1.ColumnDateTime assignedAt;

  late final _i1.ColumnInt assignedByUserId;

  @override
  List<_i1.Column> get columns => [
    id,
    userId,
    role,
    assignedAt,
    assignedByUserId,
  ];
}

class UserRoleAssignmentInclude extends _i1.IncludeObject {
  UserRoleAssignmentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => UserRoleAssignment.t;
}

class UserRoleAssignmentIncludeList extends _i1.IncludeList {
  UserRoleAssignmentIncludeList._({
    _i1.WhereExpressionBuilder<UserRoleAssignmentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(UserRoleAssignment.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => UserRoleAssignment.t;
}

class UserRoleAssignmentRepository {
  const UserRoleAssignmentRepository._();

  /// Returns a list of [UserRoleAssignment]s matching the given query parameters.
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
  Future<List<UserRoleAssignment>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserRoleAssignmentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRoleAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRoleAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<UserRoleAssignment>(
      where: where?.call(UserRoleAssignment.t),
      orderBy: orderBy?.call(UserRoleAssignment.t),
      orderByList: orderByList?.call(UserRoleAssignment.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [UserRoleAssignment] matching the given query parameters.
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
  Future<UserRoleAssignment?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserRoleAssignmentTable>? where,
    int? offset,
    _i1.OrderByBuilder<UserRoleAssignmentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<UserRoleAssignmentTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<UserRoleAssignment>(
      where: where?.call(UserRoleAssignment.t),
      orderBy: orderBy?.call(UserRoleAssignment.t),
      orderByList: orderByList?.call(UserRoleAssignment.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [UserRoleAssignment] by its [id] or null if no such row exists.
  Future<UserRoleAssignment?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<UserRoleAssignment>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [UserRoleAssignment]s in the list and returns the inserted rows.
  ///
  /// The returned [UserRoleAssignment]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<UserRoleAssignment>> insert(
    _i1.DatabaseSession session,
    List<UserRoleAssignment> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<UserRoleAssignment>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [UserRoleAssignment] and returns the inserted row.
  ///
  /// The returned [UserRoleAssignment] will have its `id` field set.
  Future<UserRoleAssignment> insertRow(
    _i1.DatabaseSession session,
    UserRoleAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<UserRoleAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [UserRoleAssignment]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<UserRoleAssignment>> update(
    _i1.DatabaseSession session,
    List<UserRoleAssignment> rows, {
    _i1.ColumnSelections<UserRoleAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<UserRoleAssignment>(
      rows,
      columns: columns?.call(UserRoleAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRoleAssignment]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<UserRoleAssignment> updateRow(
    _i1.DatabaseSession session,
    UserRoleAssignment row, {
    _i1.ColumnSelections<UserRoleAssignmentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<UserRoleAssignment>(
      row,
      columns: columns?.call(UserRoleAssignment.t),
      transaction: transaction,
    );
  }

  /// Updates a single [UserRoleAssignment] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<UserRoleAssignment?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<UserRoleAssignmentUpdateTable>
    columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<UserRoleAssignment>(
      id,
      columnValues: columnValues(UserRoleAssignment.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [UserRoleAssignment]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<UserRoleAssignment>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<UserRoleAssignmentUpdateTable>
    columnValues,
    required _i1.WhereExpressionBuilder<UserRoleAssignmentTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<UserRoleAssignmentTable>? orderBy,
    _i1.OrderByListBuilder<UserRoleAssignmentTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<UserRoleAssignment>(
      columnValues: columnValues(UserRoleAssignment.t.updateTable),
      where: where(UserRoleAssignment.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(UserRoleAssignment.t),
      orderByList: orderByList?.call(UserRoleAssignment.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [UserRoleAssignment]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<UserRoleAssignment>> delete(
    _i1.DatabaseSession session,
    List<UserRoleAssignment> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<UserRoleAssignment>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [UserRoleAssignment].
  Future<UserRoleAssignment> deleteRow(
    _i1.DatabaseSession session,
    UserRoleAssignment row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<UserRoleAssignment>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<UserRoleAssignment>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserRoleAssignmentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<UserRoleAssignment>(
      where: where(UserRoleAssignment.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<UserRoleAssignmentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<UserRoleAssignment>(
      where: where?.call(UserRoleAssignment.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [UserRoleAssignment] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<UserRoleAssignmentTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<UserRoleAssignment>(
      where: where(UserRoleAssignment.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
