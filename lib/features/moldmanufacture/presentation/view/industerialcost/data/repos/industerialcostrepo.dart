import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/model/intialcostmodel/intialcostmodel.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/model/intialcostmodelrequest.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/data/model/industerialcostmodel/industerialcostmodel.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/data/model/industerialcostrequest.dart';
import 'package:dartz/dartz.dart';

abstract class Industerialcostrepo {
  Future<Either<failure, String>> addindusterialcost(
      {required Industerialcostrequest industerialcost});
  Future<Either<failure, Industerialcostmodel>> getindusterialcost(
      {required int stampid});
  Future<Either<failure, String>> deleteindusterialcost({required int id});
}
