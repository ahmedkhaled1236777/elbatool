import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/customers/data/models/clentmodel/clentmodel.dart';
import 'package:agman/features/customers/data/models/clientrequest.dart';
import 'package:dartz/dartz.dart';

abstract class Clientsrepo {
  Future<Either<failure, String>> addclient({required Clientrequest client});
  Future<Either<failure, Clentmodel>> getclients(
      {Map<String, dynamic>? queryparms});
  Future<Either<failure, String>> editclient({required Clientrequest client});
  Future<Either<failure, String>> deleteclient({required int clientid});
}
