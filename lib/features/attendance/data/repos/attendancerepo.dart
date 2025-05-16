import 'package:agman/features/attendance/data/models/attendancemovemodel/attendancemovemodel.dart';
import 'package:agman/features/attendance/data/models/holidaymodel/holidaymodel.dart';
import 'package:agman/features/attendance/data/models/holidaymodelrequest.dart';
import 'package:agman/features/attendance/data/models/moneymodel/moneymodel.dart';
import 'package:agman/features/attendance/data/models/moneyrequest.dart';
import 'package:agman/features/attendance/data/models/permessionmodel/permessionmodel.dart';
import 'package:dartz/dartz.dart';
import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/attendance/data/models/attendancemodelrequest.dart';
import 'package:agman/features/attendance/data/models/attendancepermessionrequest.dart';
import 'package:agman/features/workers/data/models/workermodel/workermodel.dart';

abstract class attendancerepo {
  Future<Either<failure, String>> addattendance(
      {required Attendancemodelrequest attendance});
  Future<Either<failure, String>> addpermession(
      {required Attendancepermessionrequest permession});
  Future<Either<failure, String>> editattendancemove(
      {required String status, required int id});
  Future<Either<failure, String>> deletepermession({required int id});
  Future<Either<failure, String>> deleteholiday({
    required int id,
  });

  Future<Either<failure, String>> addmoney(
      {required moneyrequset moneyrequest});
  Future<Either<failure, Moneymodel>> getmoney(
      {required Map<String, dynamic> queryparma});
  Future<Either<failure, String>> deletemoney({required int id});
  Future<Either<failure, Holidaymodel>> getholidays(
      {required int employerid, required String month, required String year});
  Future<Either<failure, Permessionmodel>> getpermessionss(
      {required int employerid, required String month, required String year});
  Future<Either<failure, String>> addholiday({
    required Holidaymodelrequest holidayrequest,
  });
  Future<Either<failure, Workermodel>> getattendances(
      {required Map<String, dynamic> queryparma});
  Future<Either<failure, Attendancemovemodel>> getattendancesemoves(
      {required Map<String, dynamic> queryparma});
}
