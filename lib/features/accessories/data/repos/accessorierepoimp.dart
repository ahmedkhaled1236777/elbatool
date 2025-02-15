import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/accessories/data/model/accessoriemodel/accessoriemodel.dart';
import 'package:agman/features/accessories/data/model/accessoriemodelrequest.dart';
import 'package:agman/features/accessories/data/model/accessoriemotionmodel/accessoriemotionmodel.dart';
import 'package:agman/features/accessories/data/model/deleteputmodelrequest.dart';
import 'package:agman/features/accessories/data/repos/accessoriesrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Accessorierepoimp extends Accessoriesrepo {
  @override
  Future<Either<failure, String>> addaccessorie(
      {required Accessoriemodelrequest accessorie}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.addaccessorie,
          queryParameters: accessorie.tojson(),
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الاضافه بنجاح");
      } else {
        if (response.data["data"] != null) {
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
  Future<Either<failure, Accessoriemodel>> getaccessories(
      {Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: "accessories",
          queryParameters: queryparms);

      if (response.data["status"] == true && response.statusCode == 200) {
        print("jjjjjjjjjjjjjjjjjjjjjjjj");
        return right(Accessoriemodel.fromJson(response.data));
      } else {
        if (response.data["errors"] != null) {
          return left(
              requestfailure(error_message: response.data["errors"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      print("jjjjjjjjjjjjjjjjjjjjjjjj");
      print(e.toString());
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, String>> deleteaccessorie(
      {required int accessorie_id}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "${urls.addaccessorie}/$accessorie_id{}",
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
  Future<Either<failure, String>> editaccessorie(
      {required Accessoriemodelrequest accessorie,
      required int accessorieid}) async {
    try {
      Response response = await Putdata.putdata(
        queryParameters: accessorie.tojson(),
        token: cashhelper.getdata(key: "token"),
        path: "accessories/${accessorieid}",
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

  @override
  Future<Either<failure, Accessoriemotionmodel>> getaccessoriesmotion(
      {required int page,
      required int accessorieid,
      String? datefrom,
      String? dateto}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: "accessories?page=${page}",
          queryParameters: {
            "accessory_id": accessorieid,
            if (datefrom != null) "date_from": datefrom,
            if (dateto != null) "date_to": dateto,
          });

      if (response.data["success"] == true && response.statusCode == 200) {
        return right(Accessoriemotionmodel.fromJson(response.data));
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
  Future<Either<failure, String>> putordeleteaccessorie(
      {required Deleteputmodelrequest accessorie}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.addmove,
          queryParameters: accessorie.tojson(),
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم التسجيل بنجاح");
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
  Future<Either<failure, String>> deletemove({required int move_id}) async {
    try {
      Response response = await Postdata.postdata(
        token: cashhelper.getdata(key: "token"),
        queryParameters: {"move_id": move_id},
        path: "${urls.deletemov}",
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
}
