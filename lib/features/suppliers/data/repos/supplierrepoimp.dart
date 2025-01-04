import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/customers/data/models/clentmodel/clentmodel.dart';
import 'package:agman/features/suppliers/data/models/suppliermodel/suppliermodel.dart';
import 'package:agman/features/suppliers/data/models/supplierrequest.dart';
import 'package:agman/features/suppliers/data/repos/supplierrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class suppliersrepoimp extends Supplierrepo {
  @override
  Future<Either<failure, String>> addsupplier(
      {required Supplierrequest supplier}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.suppliers,
          data: supplier.tojson());
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
  Future<Either<failure, String>> editsupplier(
      {required Supplierrequest supplier}) async {
    try {
      Response response = await Putdata.putdata(
          token: cashhelper.getdata(key: "token"),
          path: "suppliers/${supplier.id}",
          queryParameters: supplier.tojson());
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
  Future<Either<failure, Suppliermodel>> getsuppliers(
      {Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
        token: cashhelper.getdata(key: "token"),
        path: urls.suppliers,
      );

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Suppliermodel.fromJson(response.data));
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
  Future<Either<failure, String>> deletesupplier(
      {required int supplierid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "suppliers/${supplierid}",
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
}
