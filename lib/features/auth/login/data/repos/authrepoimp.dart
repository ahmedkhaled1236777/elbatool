import 'dart:io';

import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/auth/login/data/model/loginmodel/loginmodel.dart';
import 'package:agman/features/auth/login/data/model/loginrequest.dart';
import 'package:agman/features/auth/login/data/model/updatemodel/updatemodel.dart';
import 'package:agman/features/auth/login/data/repos/authrepo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Authrepoimp extends Authrepo {
  @override
  Future<Either<failure, Loginmodel>> login(
      {required loginrequest login}) async {
    Loginmodel loginModel;
    try {
      var response =
          await Postdata.postdata(path: urls.login, data: login.tojson());

      if (response.statusCode == 200) {
        loginModel = Loginmodel.fromJson(response.data);
        print("dddddddddddddddddddddddddddddddddddddddddd");

        return right(loginModel);
      } else if (response.statusCode == 200 && response.data["code"] == 422) {
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
  Future<Either<failure, String>> logout() async {
    try {
      Response response = await Postdata.postdata(
          path: urls.logout, token: cashhelper.getdata(key: "token"));
      if (response.statusCode == 200 && response.data["status"] == 200) {
        return right("تم تسجيل الخروج");
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
  Future<Either<failure, Updatemodel>> updateprofile(
      {required String email,
      required String phone,
      required String name,
      required String oldpass,
      required String newpass,
      File? photo}) async {
    try {
      FormData data = FormData.fromMap({
        "name": name,
        "email": email,
        "phone": phone,
        "old_password": oldpass,
        "password": newpass,
        "password_confirmation": newpass,
        if (photo != null)
          "image": await MultipartFile.fromFile(photo.path,
              filename: photo.path.split("/").last)
      });
      Response response = await Postdata.postdata(
          path: urls.updateprofile,
          token: cashhelper.getdata(key: "token"),
          data: data);
      if (response.statusCode == 200 && response.data["status"] == 200) {
        return right(Updatemodel.fromJson(response.data));
      } else {
        if (response.data["data"] != null) {
          return left(requestfailure(error_message: response.data["data"][0]));
        } else
          return left(requestfailure(error_message: response.data["message"]));
      }
    } catch (e) {
      if (e is DioException) {
        return left(requestfailure.fromdioexception(e));
      } else {
        print(e);
        return left(requestfailure(error_message: e.toString()));
      }
    }
  }
}
