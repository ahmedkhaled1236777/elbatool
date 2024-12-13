import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/moldmanufacture/data/model/moldmanufacturemodel/moldmanufacturemodel.dart';
import 'package:agman/features/moldmanufacture/data/model/moldmanufacturerequest.dart';
import 'package:agman/features/moldmanufacture/data/repo/moldmanfacturerepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Moldmanufacturerepoimp extends Moldmanfacturerepo {
  @override
  Future<Either<failure, String>> addmold(
      {required Moldmanufacturerequest moldrequest}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.stamps,
          queryParameters: moldrequest.tojson(),
          token: token);
      if (response.statusCode == 200 && response.data["success"] == true) {
        return right("تم اضافة الاسطمبه بنجاح");
      } else if (response.data["errors"] != null)
        return left(requestfailure(error_message: response.data["errors"][0]));
      else
        return left(requestfailure(error_message: response.data["message"]));
    } catch (e) {
      print(e.toString());
      if (e is DioException) return left(requestfailure.fromdioexception(e));
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, Moldmanufacturemodel>> getmoldsmanufacture(
      {required int page, Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
          token: token,
          path: "stamps?page=${page}",
          queryParameters: queryparms);
      print("lllllllllllllllllllllllllllllllllll");
      print(response.data);
      if (response.data["success"] == true && response.statusCode == 200) {
        return right(Moldmanufacturemodel.fromJson(response.data));
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
  Future<Either<failure, String>> deletestampmanufacture(
      {required int stampid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: token,
        path: "${urls.stamps}/${stampid}",
      );

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الحذف بنجاح");
      } else {
        if (response.data["data"] != null) {
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
  Future<Either<failure, String>> editmoldmanufacture(
      {required Moldmanufacturerequest stamp, required int stampid}) async {
    try {
      Response response = await Putdata.putdata(
        queryParameters: stamp.tojson(),
        token: token,
        path: "stamps/${stampid}",
      );

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم التعديل بنجاح");
      } else {
        if (response.data["data"] != null) {
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
