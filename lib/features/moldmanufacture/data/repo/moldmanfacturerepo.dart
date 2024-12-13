import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/moldmanufacture/data/model/moldmanufacturemodel/moldmanufacturemodel.dart';
import 'package:agman/features/moldmanufacture/data/model/moldmanufacturerequest.dart';
import 'package:dartz/dartz.dart';

abstract class Moldmanfacturerepo {
  Future<Either<failure, String>> addmold(
      {required Moldmanufacturerequest moldrequest});
  Future<Either<failure, Moldmanufacturemodel>> getmoldsmanufacture({
    required int page,
    Map<String, dynamic>? queryparms,
  });
  Future<Either<failure, String>> editmoldmanufacture(
      {required Moldmanufacturerequest stamp, required int stampid});
  Future<Either<failure, String>> deletestampmanufacture(
      {required int stampid});
}
