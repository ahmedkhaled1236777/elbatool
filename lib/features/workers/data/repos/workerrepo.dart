import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/attendance/data/models/attendancemovemodel/attendancemovemodel.dart';
import 'package:agman/features/workers/data/models/workermodel/workermodel.dart';
import 'package:agman/features/workers/data/models/workermodelrequest.dart';
import 'package:dartz/dartz.dart';

abstract class Workerrepo {
  Future<Either<failure, String>> addworker(
      {required Workermodelrequest worker});
  Future<Either<failure, String>> editworker(
      {required Workermodelrequest worker, required int id});

  Future<Either<failure, String>> deletworker({required int workerid});
  // Future<Either<failure, String>> deletecompmove({required int compmoveid});
  Future<Either<failure, Workermodel>> getworkers(
      {Map<String, dynamic>? queryparma});
  Future<Either<failure, Attendancemovemodel>> getworkersmoves(
      {required String workerid, required String month, required String year});
}
