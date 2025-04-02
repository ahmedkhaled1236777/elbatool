import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_zkteco/flutter_zkteco.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class fingerprintrepo {
  Future<Either<failure, List<String>>> getconnect() async {
    final String deviceIp = "192.168.0.201"; // عنوان IP لجهاز ZKTeco
    final int port = 4370; // البورت الافتراضي لـ ZKTeco
    List<String> names = [];
    try {
      /* String databasepath = await getDatabasesPath();
      String path = join(databasepath, "data.db");
      Database database = await openDatabase(path);
      (await database.query('sqlite_master', columns: ['type', 'name']))
          .forEach((row) {
        print(row.values);
      });*/

      ZKTeco? fingerprintMachine =
          ZKTeco(deviceIp, port: 4370, tcp: true, debug: true, retry: 3);

// Initialize the connection
      bool iscon = await fingerprintMachine.connect();
      print(iscon);

      return right(names);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
