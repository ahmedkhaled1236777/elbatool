import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/materiales/data/models/materialmodel/materialmodel.dart';
import 'package:agman/features/materiales/data/models/materialmodelrequest.dart';
import 'package:agman/features/materiales/data/models/materialmovemodelrequest.dart';
import 'package:dartz/dartz.dart';

abstract class materialrepo {
  Future<Either<failure, String>> addmaterial(
      {required Materialmodelrequest material});
  Future<Either<failure, String>> addmaterialmove(
      {required Materialmovemodelrequest material});
  Future<Either<failure, String>> editmaterial(
      {required int id, required double quantity, required String type});
  Future<Either<failure, Materialmodel>> getmateriales(
      {required int page, Map<String, dynamic>? queryparms});
  Future<Either<failure, String>> deleteMaterial(
      {required int Materialid, String? type});
}
