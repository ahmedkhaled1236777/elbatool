import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/clients/data/models/clientmodel/clientmodel.dart';
import 'package:agman/features/clients/data/models/clientmodelrequestmotion.dart';
import 'package:agman/features/clients/data/models/clientmovesmodel/clientmovesmodel.dart';
import 'package:agman/features/clients/data/models/clientrequest.dart';

import 'package:dartz/dartz.dart';

abstract class Clientsrepo {
  Future<Either<failure, String>> addclient({required Clientrequest client});
  Future<Either<failure, String>> addclientmove(
      {required clientmoverequest Clientmovere});
  Future<Either<failure, Clientmodel>> getclients(
      {Map<String, dynamic>? queryparms});
  Future<Either<failure, String>> editclient({required Clientrequest client});
  Future<Either<failure, String>> deleteclient({required int clientid});
  Future<Either<failure, String>> deleteclientmove({required int moveid});
  Future<Either<failure, Clientmovesmodel>> getclientmoves(
      {required int page, required Map<String, dynamic> queryparms});
}
