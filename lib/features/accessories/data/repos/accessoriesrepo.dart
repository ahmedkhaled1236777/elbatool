import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/accessories/data/model/accessoriemodel/accessoriemodel.dart';
import 'package:agman/features/accessories/data/model/accessoriemodelrequest.dart';
import 'package:agman/features/accessories/data/model/accessoriemotionmodel/accessoriemotionmodel.dart';
import 'package:agman/features/accessories/data/model/deleteputmodelrequest.dart';
import 'package:agman/features/accessories/presentation/views/widgets/widgets/accessoriemotion.dart';
import 'package:dartz/dartz.dart';

abstract class Accessoriesrepo {
  Future<Either<failure, String>> addaccessorie(
      {required Accessoriemodelrequest accessorie});
  Future<Either<failure, String>> putordeleteaccessorie(
      {required Deleteputmodelrequest accessorie});
  Future<Either<failure, String>> editaccessorie(
      {required Accessoriemodelrequest accessorie, required int accessorieid});
  Future<Either<failure, String>> deleteaccessorie(
      {required int accessorie_id});
  Future<Either<failure, String>> deletemove({required int move_id});

  Future<Either<failure, Accessoriemodel>> getaccessories({
    Map<String, dynamic>? queryparms,
  });
  Future<Either<failure, Accessoriemotionmodel>> getaccessoriesmotion({
    required int page,
    required int accessorieid,
  });
}
