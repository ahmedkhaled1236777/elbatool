import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/model/addmachinereques.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/model/machinesmodel/machinesmodel.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/repos/machinerepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Machinerepoimp extends Machinerepo {
  @override
  Future<Either<failure, String>> addmachine(
      {required Addmachinereques machine}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.machines,
          token: cashhelper.getdata(key: "token"),
          queryParameters: machine.tojson());
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
  Future<Either<failure, String>> deletemachine(
      {required int machineid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "machines/${machineid}",
      );

      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم حذف الماكينه بنجاح");
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
  Future<Either<failure, String>> editmachine(
      {required int id, required Addmachinereques machine}) async {
    try {
      Response response = await Putdata.putdata(
          path: "machines/${id}",
          token: cashhelper.getdata(key: "token"),
          queryParameters: machine.tojson());
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
  Future<Either<failure, Machinesmodel>> getmachines() async {
    try {
      Response response = await Getdata.getdata(
        token: cashhelper.getdata(key: "token"),
        path: urls.machines,
      );

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Machinesmodel.fromJson(response.data));
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
