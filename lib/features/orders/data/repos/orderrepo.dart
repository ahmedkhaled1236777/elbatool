import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/orders/data/models/ordermodel/ordermodel.dart';
import 'package:agman/features/orders/data/models/ordermodelrequest.dart';
import 'package:agman/features/orders/data/models/ordermoves/ordermoves.dart';
import 'package:dartz/dartz.dart';

abstract class orderrepo {
  Future<Either<failure, String>> addorder(
      {required Ordermodelrequest orderrequest});
  Future<Either<failure, Ordermodel>> getorders(
      {Map<String, dynamic>? queryparms});
  Future<Either<failure, Ordermoves>> getmoves({required int orderid});
  Future<Either<failure, String>> deleteorder({required int orderid});
}
