import 'dart:async';
import 'dart:io' as io;

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'data/db_employ.dart';

class DBHelper {
  static Database? _db;
  static final String MOTHERNAME = 'motherName';
  static final String Tesh = "tesh";
  static const String ID = 'id';
  static const String Date = "date";
  static const String NAME = 'name';
  static const String FATHERNAME = 'fatherName';
  static const String TABLE = 'Employee';
  static const int version = 31;
  static const String DB_NAME = 'employe1.db';

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }
    _db = await initDb();
    return _db!;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(
      path,
      version: version,
      onCreate: _onCreate,
      // onUpgrade: onUpgrade,
    );
    return db;
  }

  _onCreate(Database db, int version) async {
    try {
      await db.execute(
          "CREATE TABLE $TABLE ($ID TEXT PRIMARY KEY, $NAME TEXT,$FATHERNAME TEXT,$Date TEXT)");
    } catch (e) {
      print(e);
      print('Error in execute');
    }
  }

  Future<void> save(Employ employ) async {
    try {
      print('Save in data base');
      var dbClient = await db;
      await dbClient.insert(TABLE, employ.toMap());
    } catch (e) {
      print(e);
      print('Unable to Send Employ');
    }
  }

  Future<List<Employ>?> getEmploy() async {
    try {
      print('Enter in  getdata in database');
      var dbClient = await db;
      List<Map<String, dynamic>> maps =
          await dbClient.query(TABLE, columns: [ID, NAME, FATHERNAME, Date]);
      List<Employ> list = [];

      for (var i = 0; i < maps.length; i++) {
        list.add(Employ.fromMap(maps[i]));
        // list.add(Employ.fromMap(maps![i]));
      }

      return list;
    } catch (e, stack) {
      print(e);
      print(stack);
      print('Failed To Get Employ');
    }
  }

  Future<int?> delete(String id) async {
    try {
      print(id);
      var dbClient = await this.db;
      print('data base delete');
      print(db);
      // int r;esult = await db.delete()
      return await dbClient.delete(TABLE, where: '$ID = ?', whereArgs: [id]);
    } catch (e) {
      print(e);
      print('DataBase Filed to delete');
    }
  }

  Future<int> update(
    Employ employ,
  ) async {
    print('Update');
    var dbClient = await db;
    return await dbClient.update(TABLE, employ.toMap(),
        where: '$ID = ?', whereArgs: [employ.id]);
  }

  // void onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   try {
  //     if (23 < newVersion) {
  //       print(StackTrace.current);
  //       print('Starting Updating');
  //       await db.execute(" ALTER TABLE  $TABLE  ADD COLUMN $MOTHERNAME TEXT");
  //     } else {
  //       print('error in data base');
  //     }
  //   } catch (e) {
  //     print(e);
  //     print('Unable TO Create New Table');
  //   }
  // }
}
