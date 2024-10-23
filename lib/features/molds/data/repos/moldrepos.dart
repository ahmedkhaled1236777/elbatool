import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/molds/data/models/moldmodel/datum.dart';
import 'package:agman/features/molds/data/models/moldmodel/moldmodel.dart';
import 'package:agman/features/molds/data/models/moldmodelrequest.dart';
import 'package:dartz/dartz.dart';

abstract class moldrepo {
  Future<Either<failure, String>> addmold({required Moldmodelrequest mold});
  Future<Either<failure, Moldmodel>> getmolds();
  Future<Either<failure, String>> editmold(
      {required Moldmodelrequest mold, required int id});

  Future<Either<failure, String>> deleteMold({required int moldid});
}
