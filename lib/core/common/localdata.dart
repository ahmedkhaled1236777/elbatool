import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:dartz/dartz.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Localdata {
  static Database? db;
  static get smydb async {
    if (db == null) {
      db = await intitdatatbase();
      return db;
    } else
      return db;
  }

  static intitdatatbase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'demo.db');
    Database mydb = await openDatabase(path, version: 1, onCreate: onCreate);
    return mydb;
  }

  static onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE groups (id INTEGER PRIMARY KEY AUTOINCREMENT, groupnumber TEXT, groupstatrtdate TEXT)');
    await db.execute(
        'CREATE TABLE transactions (id INTEGER, groupnumber TEXT, groupstatrtdate TEXT)');
  }

  static readdatabase({required String sql}) async {
    Database? mydb = await smydb;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  static Future<int> addtodatabase({required String sql}) async {
    Database? mydb = await smydb;

    int response = await mydb!.rawInsert(sql);

    return response;
  }

  static updateindatabase({required String sql}) async {
    Database? mydb = await smydb;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  static deletefromdatabase({required String sql}) async {
    Database? mydb = await smydb;
    int response = await mydb!.rawDelete(sql);
    return response;
  }

  static deletedatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, 'demo.db');
    await deleteDatabase(path);
  }
}
/*INSERT INTO Persons (FirstName,LastName)
VALUES ('Lars','Monsen')*/
