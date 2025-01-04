import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/suppliers/data/models/suppliermodel/suppliermodel.dart';
import 'package:agman/features/suppliers/data/models/supplierrequest.dart';
import 'package:dartz/dartz.dart';

abstract class Supplierrepo {
  Future<Either<failure, String>> addsupplier(
      {required Supplierrequest supplier});
  Future<Either<failure, Suppliermodel>> getsuppliers(
      {Map<String, dynamic>? queryparms});
  Future<Either<failure, String>> editsupplier(
      {required Supplierrequest supplier});
  Future<Either<failure, String>> deletesupplier({required int supplierid});
}
