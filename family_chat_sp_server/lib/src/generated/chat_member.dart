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

abstract class ChatMember
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  ChatMember._({
    this.id,
    required this.chatId,
    required this.userId,
    required this.joinedAt,
    this.lastReadMessageId,
  });

  factory ChatMember({
    int? id,
    required int chatId,
    required int userId,
    required DateTime joinedAt,
    int? lastReadMessageId,
  }) = _ChatMemberImpl;

  factory ChatMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChatMember(
      id: jsonSerialization['id'] as int?,
      chatId: jsonSerialization['chatId'] as int,
      userId: jsonSerialization['userId'] as int,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
      lastReadMessageId: jsonSerialization['lastReadMessageId'] as int?,
    );
  }

  static final t = ChatMemberTable();

  static const db = ChatMemberRepository._();

  @override
  int? id;

  int chatId;

  int userId;

  DateTime joinedAt;

  int? lastReadMessageId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [ChatMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChatMember copyWith({
    int? id,
    int? chatId,
    int? userId,
    DateTime? joinedAt,
    int? lastReadMessageId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChatMember',
      if (id != null) 'id': id,
      'chatId': chatId,
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
      if (lastReadMessageId != null) 'lastReadMessageId': lastReadMessageId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ChatMember',
      if (id != null) 'id': id,
      'chatId': chatId,
      'userId': userId,
      'joinedAt': joinedAt.toJson(),
      if (lastReadMessageId != null) 'lastReadMessageId': lastReadMessageId,
    };
  }

  static ChatMemberInclude include() {
    return ChatMemberInclude._();
  }

  static ChatMemberIncludeList includeList({
    _i1.WhereExpressionBuilder<ChatMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatMemberTable>? orderByList,
    ChatMemberInclude? include,
  }) {
    return ChatMemberIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatMember.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(ChatMember.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChatMemberImpl extends ChatMember {
  _ChatMemberImpl({
    int? id,
    required int chatId,
    required int userId,
    required DateTime joinedAt,
    int? lastReadMessageId,
  }) : super._(
         id: id,
         chatId: chatId,
         userId: userId,
         joinedAt: joinedAt,
         lastReadMessageId: lastReadMessageId,
       );

  /// Returns a shallow copy of this [ChatMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChatMember copyWith({
    Object? id = _Undefined,
    int? chatId,
    int? userId,
    DateTime? joinedAt,
    Object? lastReadMessageId = _Undefined,
  }) {
    return ChatMember(
      id: id is int? ? id : this.id,
      chatId: chatId ?? this.chatId,
      userId: userId ?? this.userId,
      joinedAt: joinedAt ?? this.joinedAt,
      lastReadMessageId: lastReadMessageId is int?
          ? lastReadMessageId
          : this.lastReadMessageId,
    );
  }
}

class ChatMemberUpdateTable extends _i1.UpdateTable<ChatMemberTable> {
  ChatMemberUpdateTable(super.table);

  _i1.ColumnValue<int, int> chatId(int value) =>
      _i1.ColumnValue(table.chatId, value);

  _i1.ColumnValue<int, int> userId(int value) =>
      _i1.ColumnValue(table.userId, value);

  _i1.ColumnValue<DateTime, DateTime> joinedAt(DateTime value) =>
      _i1.ColumnValue(table.joinedAt, value);

  _i1.ColumnValue<int, int> lastReadMessageId(int? value) =>
      _i1.ColumnValue(table.lastReadMessageId, value);
}

class ChatMemberTable extends _i1.Table<int?> {
  ChatMemberTable({super.tableRelation}) : super(tableName: 'chat_members') {
    updateTable = ChatMemberUpdateTable(this);
    chatId = _i1.ColumnInt('chatId', this);
    userId = _i1.ColumnInt('userId', this);
    joinedAt = _i1.ColumnDateTime('joinedAt', this);
    lastReadMessageId = _i1.ColumnInt('lastReadMessageId', this);
  }

  late final ChatMemberUpdateTable updateTable;

  late final _i1.ColumnInt chatId;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnDateTime joinedAt;

  late final _i1.ColumnInt lastReadMessageId;

  @override
  List<_i1.Column> get columns => [
    id,
    chatId,
    userId,
    joinedAt,
    lastReadMessageId,
  ];
}

class ChatMemberInclude extends _i1.IncludeObject {
  ChatMemberInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => ChatMember.t;
}

class ChatMemberIncludeList extends _i1.IncludeList {
  ChatMemberIncludeList._({
    _i1.WhereExpressionBuilder<ChatMemberTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ChatMember.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => ChatMember.t;
}

class ChatMemberRepository {
  const ChatMemberRepository._();

  /// Returns a list of [ChatMember]s matching the given query parameters.
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
  Future<List<ChatMember>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChatMemberTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatMemberTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ChatMember>(
      where: where?.call(ChatMember.t),
      orderBy: orderBy?.call(ChatMember.t),
      orderByList: orderByList?.call(ChatMember.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ChatMember] matching the given query parameters.
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
  Future<ChatMember?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChatMemberTable>? where,
    int? offset,
    _i1.OrderByBuilder<ChatMemberTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ChatMemberTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ChatMember>(
      where: where?.call(ChatMember.t),
      orderBy: orderBy?.call(ChatMember.t),
      orderByList: orderByList?.call(ChatMember.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ChatMember] by its [id] or null if no such row exists.
  Future<ChatMember?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ChatMember>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ChatMember]s in the list and returns the inserted rows.
  ///
  /// The returned [ChatMember]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<ChatMember>> insert(
    _i1.DatabaseSession session,
    List<ChatMember> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<ChatMember>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [ChatMember] and returns the inserted row.
  ///
  /// The returned [ChatMember] will have its `id` field set.
  Future<ChatMember> insertRow(
    _i1.DatabaseSession session,
    ChatMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<ChatMember>(row, transaction: transaction);
  }

  /// Updates all [ChatMember]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<ChatMember>> update(
    _i1.DatabaseSession session,
    List<ChatMember> rows, {
    _i1.ColumnSelections<ChatMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<ChatMember>(
      rows,
      columns: columns?.call(ChatMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChatMember]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ChatMember> updateRow(
    _i1.DatabaseSession session,
    ChatMember row, {
    _i1.ColumnSelections<ChatMemberTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<ChatMember>(
      row,
      columns: columns?.call(ChatMember.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ChatMember] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ChatMember?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ChatMemberUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<ChatMember>(
      id,
      columnValues: columnValues(ChatMember.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ChatMember]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<ChatMember>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ChatMemberUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ChatMemberTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ChatMemberTable>? orderBy,
    _i1.OrderByListBuilder<ChatMemberTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<ChatMember>(
      columnValues: columnValues(ChatMember.t.updateTable),
      where: where(ChatMember.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ChatMember.t),
      orderByList: orderByList?.call(ChatMember.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [ChatMember]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<ChatMember>> delete(
    _i1.DatabaseSession session,
    List<ChatMember> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<ChatMember>(rows, transaction: transaction);
  }

  /// Deletes a single [ChatMember].
  Future<ChatMember> deleteRow(
    _i1.DatabaseSession session,
    ChatMember row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ChatMember>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<ChatMember>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChatMemberTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<ChatMember>(
      where: where(ChatMember.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ChatMemberTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<ChatMember>(
      where: where?.call(ChatMember.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ChatMember] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ChatMemberTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ChatMember>(
      where: where(ChatMember.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
