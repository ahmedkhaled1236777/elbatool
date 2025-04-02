import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/wallets/data/model/walletmodel/walletmodel.dart';
import 'package:agman/features/wallets/data/model/walletmodelrequest.dart';
import 'package:agman/features/wallets/data/model/walletmotionmodel.dart';
import 'package:agman/features/wallets/data/model/walletmotionmodel/walletmotionmodel.dart';
import 'package:agman/features/wallets/data/repos/walletrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Walletrepoimp extends walletrepo {
  @override
  Future<Either<failure, String>> addwallet(
      {required Walletmodelrequest wallet}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.electronicwallets,
          queryParameters: wallet.tojson(),
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الاضافه  بنجاح");
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      print(e.toString());
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, Walletmodel>> getwallet() async {
    try {
      Response response = await Getdata.getdata(
        token: cashhelper.getdata(key: "token"),
        path: urls.electronicwallets,
      );

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Walletmodel.fromJson(response.data));
      } else {
        if (response.data["errors"] != null) {
          print("kkkkkkkkkkkkkkkkkkkkkkkkkk");
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      print("kkkkkkkkkkkkkkkkkkkkkkkkkk");
      print(e.toString());

      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletewallet({required int walletid}) async {
    try {
      Response response = await Deletedata.deletedata(
          path: "stores/${walletid}", token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الحذف بنجاح");
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      print(e.toString());
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> addwalletmotion(
      {required Walletmotionmodelrequest wallet}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.walletmoves,
          queryParameters: wallet.tojson(),
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الاضافه  بنجاح");
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      print(e.toString());
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, Walletmotionmodel>> getwalletmotion(
      {required int walletid, required int page}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.electronicwalletsmoves,
          queryParameters: {"store_id": walletid, "page": page});

      if (response.statusCode == 200 && response.data["success"] == true) {
        return right(Walletmotionmodel.fromJson(response.data));
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deletewalletmotion(
      {required int walletmotionid}) async {
    try {
      Response response = await Deletedata.deletedata(
          path: "storemoves/${walletmotionid}",
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الحذف بنجاح");
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      print(e.toString());
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
