import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/factorytools/data/models/factorytoolmodelrequest.dart';
import 'package:agman/features/factorytools/data/models/factorytoolmotionrequest.dart';
import 'package:agman/features/factorytools/data/models/factorytoolsmoves/factorytoolsmoves.dart';
import 'package:dartz/dartz.dart';

import '../models/factorytools/factorytools.dart';

abstract class factorytoolsrepo {
  Future<Either<failure, String>> addfactorytool(
      {required Factorytoolmodelrequest factorytool});
  Future<Either<failure, String>> addfactorytoolmotion(
      {required Factorytoolmotionrequest factorytool});
  Future<Either<failure, String>> editfactorytool(
      {required Factorytoolmodelrequest factorytool,
      required int factorytoolid});
  Future<Either<failure, String>> deletefactorytool(
      {required int factorytoolid});
  Future<Either<failure, Factorytools>> getfactorytools();
  Future<Either<failure, Factorytoolsmoves>> getfactorytoolsmotion({
    required int factorytoolid,
  });
  Future<Either<failure, String>> deletefactorytoolmove({required int move_id});

  /* Future<Either<failure, String>> putordeleteaccessorie(
      {required Deleteputmodelrequest accessorie});
  Future<Either<failure, String>> editaccessorie(
      {required Accessoriemodelrequest accessorie, required int accessorieid});
  Future<Either<failure, String>> deleteaccessorie(
      {required int accessorie_id});
  Future<Either<failure, String>> deletemove({required int move_id});

  Future<Either<failure, Accessoriemodel>> getfactorytools({
    Map<String, dynamic>? queryparms,
  });
  Future<Either<failure, Accessoriemotionmodel>> getfactorytoolsmotion({
    required int page,
    required int accessorieid,
  });*/
}
