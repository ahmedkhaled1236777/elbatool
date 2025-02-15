import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/save/data/model/savemodel/savemodel.dart';
import 'package:agman/features/save/data/model/savemodelrequest.dart';
import 'package:agman/features/save/data/repos/saverepo.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Saverepoimp extends Saverepo {
  @override
  Future<Either<failure, String>> addsavemotion(
      {required Savemodelrequest saverequest}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.addcash,
          queryParameters: saverequest.tojson(),
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
  Future<Either<failure, Savemodel>> getsave({required String date}) async {
    try {
      Response response = await Getdata.getdata(
        token: cashhelper.getdata(key: "token"),
        queryParameters: {"date": date},
        path: urls.cash,
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        print("mmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm");
        return right(Savemodel.fromJson(response.data));
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      print("lllllllllllllllllllllllllllllllllll");
      print(e.toString());
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }
}
