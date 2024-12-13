import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/model/intialcostmodel/intialcostmodel.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/model/intialcostmodelrequest.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/repos/intialcostrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Intialcostrepoimp extends Intialcostrepo {
  @override
  Future<Either<failure, String>> addintialcost(
      {required Intialcostmodelrequest intialmodel}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.stamp_initial_costs,
          token: cashhelper.getdata(key: "token"),
          data: intialmodel.tojson());
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
  Future<Either<failure, Intialcostmodel>> getintialcost(
      {required int stampid}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.stamp_initial_costs,
          queryParameters: {"stamp_id": stampid});

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Intialcostmodel.fromJson(response.data));
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
  Future<Either<failure, String>> deleteintialcost({required int id}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "stamp_initial_costs/${id}",
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
