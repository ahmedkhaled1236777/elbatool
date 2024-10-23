import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/molds/data/models/moldmodel/moldmodel.dart';
import 'package:agman/features/molds/data/models/moldmodelrequest.dart';
import 'package:agman/features/molds/data/repos/moldrepos.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Moldrepoimp extends moldrepo {
  @override
  Future<Either<failure, Moldmodel>> getmolds() async {
    try {
      Response response = await Getdata.getdata(
        token: cashhelper.getdata(key: "token"),
        path: urls.stamps,
      );

      if (response.statusCode == 200) {
        return right(Moldmodel.fromJson(response.data));
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
  Future<Either<failure, String>> addmold(
      {required Moldmodelrequest mold}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.addstamp,
          data: mold.tojson());
      if (response.statusCode == 200) {
        return right(response.data["message"]);
      } else {
        if (response.data["data"] != null) {
          return left(requestfailure(error_message: response.data["data"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteMold({required int moldid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "stamps/${moldid}",
      );

      if (response.statusCode == 200) {
        return right("تم حذف الاسطمبه بنجاح");
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
  Future<Either<failure, String>> editmold(
      {required Moldmodelrequest mold, required int id}) async {
    try {
      Response response = await Postdata.postdata(
          path: "stamps/${id}",
          token: cashhelper.getdata(key: "token"),
          data: {
            "name": mold.moldname,
            "weight": mold.prodweight,
            "_method": "PUT",
            "pieces_quantity": mold.numberofpieces,
            "period_time": mold.cycletime,
          });
      if (response.statusCode == 200) {
        return right(response.data["message"]);
      } else {
        if (response.data["data"] != null) {
          return left(requestfailure(error_message: response.data["data"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
