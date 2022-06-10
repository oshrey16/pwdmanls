import 'dart:convert';
import 'dart:math';

import 'package:drift/drift.dart';
// These imports are only needed to open the database
import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:encrypt/encrypt.dart';

// assuming that your file is called filename.dart. This will give an error at
// first, but it's needed for drift to know about the generated code
part 'db.g.dart';

// this will generate a table called "todos" for us. The rows of that table will
// be represented by a class called "Todo".
class DataSet extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get email => text()();
  TextColumn get password => text()();
  TextColumn get url => text().nullable()();
}

@DataClassName('MySettings')
class Settings extends Table{
  TextColumn get email => text()();

  @override
  Set<Column> get primaryKey => {email};
}

// This will make drift generate a class called "Category" to represent a row in
// this table. By default, "Categorie" would have been used because it only
//strips away the trailing "s" in the table name.
// @DataClassName('Category')
// class Categories extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get description => text()();
// }

// this annotation tells drift to prepare a database class that uses both of the
// tables we just defined. We'll see how to use that database class in a moment.
@DriftDatabase(tables: [DataSet,Settings])
class MyDatabase extends _$MyDatabase {
  MyDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  @override
  int get schemaVersion => 1;

  Future<List<DataSetData>> getDataSet() async{
    return await select(dataSet).get();
  }

  Future<int> insertDataSet(DataSetCompanion data) async{
    return await into(dataSet).insert(data);
  }

  Stream<DataSetData> entryById(int id) {
  return (select(dataSet)..where((t) => t.id.equals(id))).watchSingle();
  }

  // My Settings
  Future<int> insertEmailSettings(SettingsCompanion data) async{
    return await into(settings).insertOnConflictUpdate(data);
  }
    Future updateEmailSettings(SettingsCompanion data) async{
    return await (update(settings)..where((t) => t.email.like('%@%'))).write(SettingsCompanion(email: data.email));
  }
  Future<List<MySettings>> getDefaultEmail() async {
    return await select(settings).get();
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    print(dbFolder);
    File(p.join(dbFolder.path, 'db.sqlite')).exists().then((value) async { 
      if(value == false){
        const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
        Random _rnd = Random();
        String getRandomString(int length) => String.fromCharCodes(Iterable.generate(length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
        const storage = FlutterSecureStorage();
        final key1 = getRandomString(32);
        await storage.write(key: "pkey", value: key1.toString());
      }
    }); 
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}
