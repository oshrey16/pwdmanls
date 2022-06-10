// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DataSetData extends DataClass implements Insertable<DataSetData> {
  final int id;
  final String title;
  final String email;
  final String password;
  final String? url;
  DataSetData(
      {required this.id,
      required this.title,
      required this.email,
      required this.password,
      this.url});
  factory DataSetData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DataSetData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
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
    map['title'] = Variable<String>(title);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String?>(url);
    }
    return map;
  }

  DataSetCompanion toCompanion(bool nullToAbsent) {
    return DataSetCompanion(
      id: Value(id),
      title: Value(title),
      email: Value(email),
      password: Value(password),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
    );
  }

  factory DataSetData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DataSetData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
      url: serializer.fromJson<String?>(json['url']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
      'url': serializer.toJson<String?>(url),
    };
  }

  DataSetData copyWith(
          {int? id,
          String? title,
          String? email,
          String? password,
          String? url}) =>
      DataSetData(
        id: id ?? this.id,
        title: title ?? this.title,
        email: email ?? this.email,
        password: password ?? this.password,
        url: url ?? this.url,
      );
  @override
  String toString() {
    return (StringBuffer('DataSetData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('email: $email, ')
          ..write('password: $password, ')
          ..write('url: $url')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, email, password, url);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataSetData &&
          other.id == this.id &&
          other.title == this.title &&
          other.email == this.email &&
          other.password == this.password &&
          other.url == this.url);
}

class DataSetCompanion extends UpdateCompanion<DataSetData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> email;
  final Value<String> password;
  final Value<String?> url;
  const DataSetCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
    this.url = const Value.absent(),
  });
  DataSetCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String email,
    required String password,
    this.url = const Value.absent(),
  })  : title = Value(title),
        email = Value(email),
        password = Value(password);
  static Insertable<DataSetData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? email,
    Expression<String>? password,
    Expression<String?>? url,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
      if (url != null) 'url': url,
    });
  }

  DataSetCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? email,
      Value<String>? password,
      Value<String?>? url}) {
    return DataSetCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      email: email ?? this.email,
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
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
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
          ..write('title: $title, ')
          ..write('email: $email, ')
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
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _passwordMeta = const VerificationMeta('password');
  @override
  late final GeneratedColumn<String?> password = GeneratedColumn<String?>(
      'password', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String?> url = GeneratedColumn<String?>(
      'url', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [id, title, email, password, url];
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
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
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

class MySettings extends DataClass implements Insertable<MySettings> {
  final String email;
  MySettings({required this.email});
  factory MySettings.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return MySettings(
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['email'] = Variable<String>(email);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(
      email: Value(email),
    );
  }

  factory MySettings.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MySettings(
      email: serializer.fromJson<String>(json['email']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'email': serializer.toJson<String>(email),
    };
  }

  MySettings copyWith({String? email}) => MySettings(
        email: email ?? this.email,
      );
  @override
  String toString() {
    return (StringBuffer('MySettings(')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => email.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MySettings && other.email == this.email);
}

class SettingsCompanion extends UpdateCompanion<MySettings> {
  final Value<String> email;
  const SettingsCompanion({
    this.email = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String email,
  }) : email = Value(email);
  static Insertable<MySettings> custom({
    Expression<String>? email,
  }) {
    return RawValuesInsertable({
      if (email != null) 'email': email,
    });
  }

  SettingsCompanion copyWith({Value<String>? email}) {
    return SettingsCompanion(
      email: email ?? this.email,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('email: $email')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings
    with TableInfo<$SettingsTable, MySettings> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [email];
  @override
  String get aliasedName => _alias ?? 'settings';
  @override
  String get actualTableName => 'settings';
  @override
  VerificationContext validateIntegrity(Insertable<MySettings> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {email};
  @override
  MySettings map(Map<String, dynamic> data, {String? tablePrefix}) {
    return MySettings.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DataSetTable dataSet = $DataSetTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dataSet, settings];
}
