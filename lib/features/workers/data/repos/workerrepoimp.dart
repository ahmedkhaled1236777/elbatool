import 'package:agman/features/attendance/data/models/attendancemovemodel/attendancemovemodel.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/workers/data/models/workermodel/workermodel.dart';
import 'package:agman/features/workers/data/models/workermodelrequest.dart';
import 'package:agman/features/workers/data/models/workermovemodel/workermovemodel.dart';
import 'package:agman/features/workers/data/repos/workerrepo.dart';

class Workerrepoimp extends Workerrepo {
  @override
  Future<Either<failure, String>> addworker(
      {required Workermodelrequest worker}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.employers,
          queryParameters: worker.tojson());
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم الانشاء بنجاح");
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
  Future<Either<failure, String>> deletworker({required int workerid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "employers/${workerid}",
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
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> editworker(
      {required Workermodelrequest worker, required int id}) async {
    try {
      Response response = await Putdata.putdata(
          token: cashhelper.getdata(key: "token"),
          path: "employers/${id}",
          queryParameters: worker.tojson());
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم التعديل بنجاح");
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
  Future<Either<failure, Workermodel>> getworkers(
      {Map<String, dynamic>? queryparma}) async {
    try {
      Response response = await Getdata.getdata(
          queryParameters: queryparma,
          token: cashhelper.getdata(key: "token"),
          path: urls.employers);
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Workermodel.fromJson(response.data));
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
  Future<Either<failure, Attendancemovemodel>> getworkersmoves(
      {required String workerid,
      required String month,
      required String year}) async {
    try {
      Response response = await Getdata.getdata(queryParameters: {
        "employer_name": workerid,
        "month": month,
        "year": year
      }, token: cashhelper.getdata(key: "token"), path: "employer-moves");
      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Attendancemovemodel.fromJson(response.data));
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
}
