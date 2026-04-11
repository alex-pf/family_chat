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

abstract class Chat implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Chat._({
    this.id,
    required this.name,
    bool? isGroup,
    this.ownerUserId,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    required this.createdAt,
    required this.updatedAt,
  }) : isGroup = isGroup ?? false,
       backgroundId = backgroundId ?? 'default',
       textColor = textColor ?? '#FFFFFF',
       isArchived = isArchived ?? false;

  factory Chat({
    int? id,
    required String name,
    bool? isGroup,
    int? ownerUserId,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChatImpl;

  factory Chat.fromJson(Map<String, dynamic> jsonSerialization) {
    return Chat(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      isGroup: jsonSerialization['isGroup'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isGroup']),
      ownerUserId: jsonSerialization['ownerUserId'] as int?,
      backgroundId: jsonSerialization['backgroundId'] as String?,
      textColor: jsonSerialization['textColor'] as String?,
      isArchived: jsonSerialization['isArchived'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isArchived']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  static final t = ChatTable();

  static const db = ChatRepository._();

  @override
  int? id;

  String name;

  bool isGroup;

  int? ownerUserId;

  String backgroundId;

  String textColor;

  bool isArchived;

  DateTime createdAt;

  DateTime updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Chat copyWith({
    int? id,
    String? name,
    bool? isGroup,
    int? ownerUserId,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Chat',
      if (id != null) 'id': id,
      'name': name,
      'isGroup': isGroup,
      if (ownerUserId != null) 'ownerUserId': ownerUserId,
      'backgroundId': backgroundId,
      'textColor': textColor,
      'isArchived': isArchived,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Chat',
      if (id != null) 'id': id,
      'name': name,
      'isGroup': isGroup,
      if (ownerUserId != null) 'ownerUserId': ownerUserId,
      'backgroundId': backgroundId,
      'textColor': textColor,
      'isArchived': isArchived,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  static ChatInclude include() {
    return ChatInclude._();
  }

  static ChatIncludeList includeList({
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatTable>? orderByList,
    ChatInclude? include,
  }) {
    return ChatIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Chat.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Chat.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatImpl extends Chat {
  _ChatImpl({
    int? id,
    required String name,
    bool? isGroup,
    int? ownerUserId,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         name: name,
         isGroup: isGroup,
         ownerUserId: ownerUserId,
         backgroundId: backgroundId,
         textColor: textColor,
         isArchived: isArchived,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Chat]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Chat copyWith({
    Object? id = _Undefined,
    String? name,
    bool? isGroup,
    Object? ownerUserId = _Undefined,
    String? backgroundId,
    String? textColor,
    bool? isArchived,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Chat(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      isGroup: isGroup ?? this.isGroup,
      ownerUserId: ownerUserId is int? ? ownerUserId : this.ownerUserId,
      backgroundId: backgroundId ?? this.backgroundId,
      textColor: textColor ?? this.textColor,
      isArchived: isArchived ?? this.isArchived,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

class ChatUpdateTable extends _i1.UpdateTable<ChatTable> {
  ChatUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<bool, bool> isGroup(bool value) => _i1.ColumnValue(
    table.isGroup,
    value,
  );

  _i1.ColumnValue<int, int> ownerUserId(int? value) => _i1.ColumnValue(
    table.ownerUserId,
    value,
  );

  _i1.ColumnValue<String, String> backgroundId(String value) => _i1.ColumnValue(
    table.backgroundId,
    value,
  );

  _i1.ColumnValue<String, String> textColor(String value) => _i1.ColumnValue(
    table.textColor,
    value,
  );

  _i1.ColumnValue<bool, bool> isArchived(bool value) => _i1.ColumnValue(
    table.isArchived,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ChatTable extends _i1.Table<int?> {
  ChatTable({super.tableRelation}) : super(tableName: 'chats') {
    updateTable = ChatUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    isGroup = _i1.ColumnBool(
      'isGroup',
      this,
      hasDefault: true,
    );
    ownerUserId = _i1.ColumnInt(
      'ownerUserId',
      this,
    );
    backgroundId = _i1.ColumnString(
      'backgroundId',
      this,
      hasDefault: true,
    );
    textColor = _i1.ColumnString(
      'textColor',
      this,
      hasDefault: true,
    );
    isArchived = _i1.ColumnBool(
      'isArchived',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
    );
  }

  late final ChatUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnBool isGroup;

  late final _i1.ColumnInt ownerUserId;

  late final _i1.ColumnString backgroundId;

  late final _i1.ColumnString textColor;

  late final _i1.ColumnBool isArchived;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    isGroup,
    ownerUserId,
    backgroundId,
    textColor,
    isArchived,
    createdAt,
    updatedAt,
  ];
}

class ChatInclude extends _i1.IncludeObject {
  ChatInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Chat.t;
}

class ChatIncludeList extends _i1.IncludeList {
  ChatIncludeList._({
    _i1.WhereExpressionBuilder<ChatTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Chat.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Chat.t;
}

class ChatRepository {
  const ChatRepository._();

  /// Returns a list of [Chat]s matching the given query parameters.
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
  Future<List<Chat>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Chat>(
      where: where?.call(Chat.t),
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Chat] matching the given query parameters.
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
  Future<Chat?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChatTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Chat>(
      where: where?.call(Chat.t),
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Chat] by its [id] or null if no such row exists.
  Future<Chat?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Chat>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Chat]s in the list and returns the inserted rows.
  ///
  /// The returned [Chat]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Chat>> insert(
    _i1.DatabaseSession session,
    List<Chat> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Chat>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Chat] and returns the inserted row.
  ///
  /// The returned [Chat] will have its `id` field set.
  Future<Chat> insertRow(
    _i1.DatabaseSession session,
    Chat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Chat>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Chat]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Chat>> update(
    _i1.DatabaseSession session,
    List<Chat> rows, {
    _i1.ColumnSelections<ChatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Chat>(
      rows,
      columns: columns?.call(Chat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Chat]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Chat> updateRow(
    _i1.DatabaseSession session,
    Chat row, {
    _i1.ColumnSelections<ChatTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Chat>(
      row,
      columns: columns?.call(Chat.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Chat] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Chat?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChatUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Chat>(
      id,
      columnValues: columnValues(Chat.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Chat]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Chat>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChatUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ChatTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatTable>? orderBy,
    _i1.OrderByListBuilder<ChatTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Chat>(
      columnValues: columnValues(Chat.t.updateTable),
      where: where(Chat.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Chat.t),
      orderByList: orderByList?.call(Chat.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Chat]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Chat>> delete(
    _i1.DatabaseSession session,
    List<Chat> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Chat>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Chat].
  Future<Chat> deleteRow(
    _i1.DatabaseSession session,
    Chat row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Chat>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Chat>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChatTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Chat>(
      where: where(Chat.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChatTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Chat>(
      where: where?.call(Chat.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Chat] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChatTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Chat>(
      where: where(Chat.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
