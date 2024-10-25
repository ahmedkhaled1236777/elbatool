import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/users/data/models/addemployeerequest.dart';
import 'package:agman/features/users/data/models/employeemodel/employeemodel.dart';
import 'package:agman/features/users/data/repos/addemployeerepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class emplyeerepoimplementaion extends employeerepo {
  @override
  Future<Either<failure, String>> addemployee(
      {required String token, required addemployeemodel employee}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.adduser, token: token, data: employee.tojson());

      if (response.statusCode == 200 && response.data["status"] == 200) {
        return right(response.data["message"]);
      } else if (response.statusCode == 200 && response.data["code"] == 422) {
        return left(requestfailure(error_message: response.data["data"][0]));
      } else if (response.data["code"] == 411) {
        return left(requestfailure(error_message: response.data["message"]));
      } else
        return left(requestfailure(error_message: response.data["data"][0]));
    } catch (e) {
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, Employeemodel>> getemployees({
    required String token,
  }) async {
    Employeemodel employeesmodel;
    try {
      Response response = await Getdata.getdata(path: urls.users, token: token);
      print(response.data);
      if (response.statusCode == 200 && response.data["status"] == 200) {
        employeesmodel = Employeemodel.fromJson(response.data);
        return right(employeesmodel);
      } else if (response.statusCode == 200 && response.data["code"] == 422) {
        return left(requestfailure(error_message: response.data["data"][0]));
      } else {
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
  Future<Either<failure, String>> deleteemployee(
      {required String token, required int employeenumber}) async {
    try {
      Response response = await Deletedata.deletedata(
          path: "users/${employeenumber}", token: token);
      if (response.statusCode == 200 && response.data["status"] == 200)
        return right("تم حذف البيانات بنجاح");
      else if (response.statusCode == 200 && response.data["code"] == 422) {
        return left(requestfailure(error_message: response.data["data"][0]));
      } else {
        return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return left(requestfailure.fromdioexception(e));
      } else {
        return left(requestfailure(error_message: e.toString()));
      }
    }
  }

  @override
  Future<Either<failure, String>> editemployee(
      {required String token,
      required int id,
      required addemployeemodel employee}) async {
    try {
      Response response =
          await Postdata.postdata(path: "users/${id}", token: token, data: {
        "name": employee.name,
        "job_title": employee.jobtittle,
        "phone": employee.phone,
        "email": employee.email,
        "password": employee.password,
        "permissions": employee.permessions,
        "_method": "PUT",
        "is_active": employee.isactive,
      });
      if (response.statusCode == 200 && response.data["status"] == 200) {
        return right(response.data["message"]);
      } else if (response.statusCode == 200 && response.data["code"] == 422) {
        return left(requestfailure(error_message: response.data["data"][0]));
      } else if (response.data["code"] == 411) {
        return left(requestfailure(error_message: response.data["message"]));
      } else
        return left(requestfailure(error_message: response.data["data"][0]));
    } catch (e) {
      if (e is DioException)
        return left(requestfailure.fromdioexception(e));
      else
        return left(requestfailure(error_message: e.toString()));
    }
  }
}
