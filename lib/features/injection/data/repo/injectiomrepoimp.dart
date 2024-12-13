import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/injection/data/models/productionmodel.dart';
import 'package:agman/features/injection/data/repo/injectionrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:dio/dio.dart';

class Injectiomrepoimp extends injectionrepo {
  @override
  Future<Either<failure, String>> addinjection(
      {required productionmodel injectionrequest}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.reports,
          data: injectionrequest.tojson());
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right(response.data["message"]);
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteinjection(
      {required int injectionid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "reports/${injectionid}",
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم حذف التقرير بنجاح");
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
  Future<Either<failure, List<productionmodel>>> getinjections(
      {required String date}) async {
    List<productionmodel> productions = [];
    try {
      Response response = await Getdata.getdata(
        token: cashhelper.getdata(key: "token"),
        queryParameters: {"date": date},
        path: urls.reports,
      );

      if (response.statusCode == 200 && response.data["status"] == true) {
        response.data["data"].forEach((e) {
          productions.add(productionmodel.fromjson(e));
        });
        return right(productions);
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      print("llllllllllllllllllllllllllllllll");
      print(e.toString());
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }
}
