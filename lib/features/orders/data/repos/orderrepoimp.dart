import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/orders/data/models/ordermodel/ordermodel.dart';
import 'package:agman/features/orders/data/models/ordermodelrequest.dart';
import 'package:agman/features/orders/data/models/ordermoves/ordermoves.dart';
import 'package:agman/features/orders/data/repos/orderrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class orderrepoimp extends orderrepo {
  @override
  Future<Either<failure, String>> addorder(
      {required Ordermodelrequest orderrequest}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.orders,
          data: orderrequest.tojson());
      if (response.statusCode == 200 && response.data["success"]) {
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
  Future<Either<failure, Ordermodel>> getorders(
      {Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: "orders",
          queryParameters: queryparms);

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Ordermodel.fromJson(response.data));
      } else {
        if (response.data["data"] != null) {
          return left(requestfailure(error_message: response.data["data"][0]));
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
  Future<Either<failure, String>> deleteorder({required int orderid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "orders/${orderid}",
      );

      if (response.statusCode == 200) {
        return right("تم حذف الاوردر بنجاح");
      } else {
        if (response.data["data"] != null) {
          return left(requestfailure(error_message: response.data["data"][0]));
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
  Future<Either<failure, Ordermoves>> getmoves({required int orderid}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: "ordermoves",
          queryParameters: {"order_id": orderid});

      if (response.statusCode == 200 && response.data["success"] == true) {
        return right(Ordermoves.fromJson(response.data));
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
