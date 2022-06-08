// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DataSetData extends DataClass implements Insertable<DataSetData> {
  final int id;
  final String username;
  final String password;
  final String? url;
  DataSetData(
      {required this.id,
      required this.username,
      required this.password,
      this.url});
  factory DataSetData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DataSetData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      username: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      password: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}password'])!,
      url: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}url']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(username);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String?>(url);
    }
    return map;
  }

  DataSetCompanion toCompanion(bool nullToAbsent) {
    return DataSetCompanion(
      id: Value(id),
      username: Value(username),
      password: Value(password),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
    );
  }

  factory DataSetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataSetData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      password: serializer.fromJson<String>(json['password']),
      url: serializer.fromJson<String?>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'password': serializer.toJson<String>(password),
      'url': serializer.toJson<String?>(url),
    };
  }

  DataSetData copyWith(
          {int? id, String? username, String? password, String? url}) =>
      DataSetData(
        id: id ?? this.id,
        username: username ?? this.username,
        password: password ?? this.password,
        url: url ?? this.url,
      );
  @override
  String toString() {
    return (StringBuffer('DataSetData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, password, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataSetData &&
          other.id == this.id &&
          other.username == this.username &&
          other.password == this.password &&
          other.url == this.url);
}

class DataSetCompanion extends UpdateCompanion<DataSetData> {
  final Value<int> id;
  final Value<String> username;
  final Value<String> password;
  final Value<String?> url;
  const DataSetCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.password = const Value.absent(),
    this.url = const Value.absent(),
  });
  DataSetCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required String password,
    this.url = const Value.absent(),
  })  : username = Value(username),
        password = Value(password);
  static Insertable<DataSetData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<String>? password,
    Expression<String?>? url,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'name': username,
      if (password != null) 'password': password,
      if (url != null) 'url': url,
    });
  }

  DataSetCompanion copyWith(
      {Value<int>? id,
      Value<String>? username,
      Value<String>? password,
      Value<String?>? url}) {
    return DataSetCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      password: password ?? this.password,
      url: url ?? this.url,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['name'] = Variable<String>(username.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    if (url.present) {
      map['url'] = Variable<String?>(url.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DataSetCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('password: $password, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }
}

class $DataSetTable extends DataSet with TableInfo<$DataSetTable, DataSetData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DataSetTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _usernameMeta = const VerificationMeta('username');
  @override
  late final GeneratedColumn<String?> username = GeneratedColumn<String?>(
      'name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 8, maxTextLength: 32),
      type: const StringType(),
      requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, username, password, url];
  @override
  String get aliasedName => _alias ?? 'data_set';
  @override
  String get actualTableName => 'data_set';
  @override
  VerificationContext validateIntegrity(Insertable<DataSetData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_usernameMeta,
          username.isAcceptableOrUnknown(data['name']!, _usernameMeta));
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('password')) {
      context.handle(_passwordMeta,
          password.isAcceptableOrUnknown(data['password']!, _passwordMeta));
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DataSetData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DataSetData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DataSetTable createAlias(String alias) {
    return $DataSetTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DataSetTable dataSet = $DataSetTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dataSet];
}
