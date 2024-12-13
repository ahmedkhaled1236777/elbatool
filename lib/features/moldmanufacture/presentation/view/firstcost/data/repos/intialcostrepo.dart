import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/model/intialcostmodel/intialcostmodel.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/model/intialcostmodelrequest.dart';
import 'package:dartz/dartz.dart';

abstract class Intialcostrepo {
  Future<Either<failure, String>> addintialcost(
      {required Intialcostmodelrequest intialmodel});
  Future<Either<failure, Intialcostmodel>> getintialcost(
      {required int stampid});
  Future<Either<failure, String>> deleteintialcost({required int id});
}
