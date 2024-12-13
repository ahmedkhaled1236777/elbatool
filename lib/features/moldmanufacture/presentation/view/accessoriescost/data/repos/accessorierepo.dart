import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/moldmanufacture/presentation/view/accessoriescost/data/model/accessoriecostmodel/accessoriecostmodel.dart';
import 'package:agman/features/moldmanufacture/presentation/view/accessoriescost/data/model/accessoriescostmodelrequest.dart';
import 'package:dartz/dartz.dart';

abstract class Accessorierepo {
  Future<Either<failure, String>> addaccessoriecost(
      {required accessoriecostmodelrequest accessoriemodel});
  Future<Either<failure, Accessoriecostmodel>> getaccessoriecost(
      {required int stampid});
  Future<Either<failure, String>> deleteaccessoriecost({required int id});
}
