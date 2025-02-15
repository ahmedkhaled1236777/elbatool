import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/features/save/data/model/savemodel/savemodel.dart';
import 'package:agman/features/save/data/model/savemodelrequest.dart';
import 'package:agman/features/wallets/data/model/walletmotionmodel.dart';
import 'package:dartz/dartz.dart';

abstract class Saverepo {
  Future<Either<failure, String>> addsavemotion(
      {required Savemodelrequest saverequest});
  Future<Either<failure, Savemodel>> getsave({required String date});

  /* Future<Either<failure, String>> editwallet(
      {required walletmodelrequest wallet,
      required int walletid});
  Future<Either<failure, String>> deletewallet(
      {required int walletid});
  Future<Either<failure, wallet>> getwallet();
  Future<Either<failure, walletmoves>> getwalletmotion({
    required int walletid,
  });
  Future<Either<failure, String>> deletewalletmove({required int move_id});*/

  /* Future<Either<failure, String>> putordeleteaccessorie(
      {required Deleteputmodelrequest accessorie});
  Future<Either<failure, String>> editaccessorie(
      {required Accessoriemodelrequest accessorie, required int accessorieid});
  Future<Either<failure, String>> deleteaccessorie(
      {required int accessorie_id});
  Future<Either<failure, String>> deletemove({required int move_id});

  Future<Either<failure, Accessoriemodel>> getwallet({
    Map<String, dynamic>? queryparms,
  });
  Future<Either<failure, Accessoriemotionmodel>> getwalletmotion({
    required int page,
    required int accessorieid,
  });*/
}
