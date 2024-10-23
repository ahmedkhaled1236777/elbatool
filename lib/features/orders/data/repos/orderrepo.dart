import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/orders/data/models/ordermodel/ordermodel.dart';
import 'package:agman/features/orders/data/models/ordermodelrequest.dart';
import 'package:dartz/dartz.dart';

abstract class orderrepo {
  Future<Either<failure, String>> addorder(
      {required Ordermodelrequest orderrequest});
  Future<Either<failure, Ordermodel>> getorders(
      {required int page, Map<String, dynamic>? queryparms});
  Future<Either<failure, String>> deleteorder({required int orderid});
}
