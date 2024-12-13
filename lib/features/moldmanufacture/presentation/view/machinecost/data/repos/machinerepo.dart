import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/model/addmachinereques.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/model/machinesmodel/machinesmodel.dart';
import 'package:dartz/dartz.dart';

abstract class Machinerepo {
  Future<Either<failure, String>> addmachine(
      {required Addmachinereques machine});
  Future<Either<failure, String>> editmachine(
      {required int id, required Addmachinereques machine});
  Future<Either<failure, Machinesmodel>> getmachines();
  Future<Either<failure, String>> deletemachine({required int machineid});
}
