import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/materiales/data/models/materialmodel/content.dart';
import 'package:agman/features/materiales/data/models/materialmodel/materialmodel.dart';
import 'package:agman/features/materiales/data/models/materialmodelrequest.dart';
import 'package:dartz/dartz.dart';

abstract class materialrepo {
  Future<Either<failure, String>> addmaterial(
      {required Materialmodelrequest material});
  Future<Either<failure, String>> editmaterial(
      {required Materialmodelrequest material, required int id});
  Future<Either<failure, Materialmodel>> getmateriales(
      {required int page, Map<String, dynamic>? queryparms});
  Future<Either<failure, String>> deleteMaterial({required int Materialid});
}
