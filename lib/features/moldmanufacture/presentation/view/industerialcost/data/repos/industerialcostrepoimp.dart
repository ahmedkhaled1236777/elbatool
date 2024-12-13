import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/data/model/industerialcostmodel/industerialcostmodel.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/data/model/industerialcostrequest.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/data/repos/industerialcostrepo.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Industerialcostrepoimp extends Industerialcostrepo {
  @override
  Future<Either<failure, String>> addindusterialcost(
      {required Industerialcostrequest industerialcost}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.industrials,
          token: cashhelper.getdata(key: "token"),
          data: industerialcost.tojson());
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
  Future<Either<failure, Industerialcostmodel>> getindusterialcost(
      {required int stampid}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.industrials,
          queryParameters: {"stamp_id": stampid});

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Industerialcostmodel.fromJson(response.data));
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
  Future<Either<failure, String>> deleteindusterialcost(
      {required int id}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "industrials/${id}",
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم الحذف بنجاح");
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
}
