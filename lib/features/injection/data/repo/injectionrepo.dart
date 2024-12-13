import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/injection/data/models/productionmodel.dart';
import 'package:dartz/dartz.dart';

abstract class injectionrepo {
  Future<Either<failure, String>> addinjection(
      {required productionmodel injectionrequest});
  Future<Either<failure, List<productionmodel>>> getinjections(
      {required String date});
  Future<Either<failure, String>> deleteinjection({required int injectionid});
}
