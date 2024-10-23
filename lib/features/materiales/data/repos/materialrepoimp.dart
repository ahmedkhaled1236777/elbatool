import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/materiales/data/models/materialmodel/materialmodel.dart';
import 'package:agman/features/materiales/data/models/materialmodelrequest.dart';
import 'package:agman/features/materiales/data/repos/materialrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Materialrepoimp extends materialrepo {
  @override
  Future<Either<failure, String>> addmaterial(
      {required Materialmodelrequest material}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.raw_material_stores,
          token: cashhelper.getdata(key: "token"),
          data: material.tojson());
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
  Future<Either<failure, Materialmodel>> getmateriales(
      {required int page, Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: "raw_material_stores?page=${page}",
          queryParameters: queryparms);

      if (response.statusCode == 200) {
        return right(Materialmodel.fromJson(response.data));
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
  Future<Either<failure, String>> deleteMaterial(
      {required int Materialid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "raw_material_stores/${Materialid}",
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
  Future<Either<failure, String>> editmaterial(
      {required Materialmodelrequest material, required int id}) async {
    try {
      Response response = await Postdata.postdata(
          path: "raw_material_stores/${id}",
          token: cashhelper.getdata(key: "token"),
          data: {
            "name": material.name,
            "quantity": material.quantity,
            "_method": material.type
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
