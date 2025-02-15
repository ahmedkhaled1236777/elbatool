import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/factorytools/data/models/factorytoolmodelrequest.dart';
import 'package:agman/features/factorytools/data/models/factorytoolmotionrequest.dart';
import 'package:agman/features/factorytools/data/models/factorytools/factorytools.dart';
import 'package:agman/features/factorytools/data/models/factorytoolsmoves/factorytoolsmoves.dart';
import 'package:agman/features/factorytools/data/models/factorytoolssearch/factorytoolssearch.dart';
import 'package:agman/features/factorytools/data/repos/factorytoolsrep.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/factorytoolssearch.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Factorytoolsrepoimp extends factorytoolsrepo {
  @override
  Future<Either<failure, String>> addfactorytool(
      {required Factorytoolmodelrequest factorytool}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.factorytools,
          queryParameters: factorytool.tojson(),
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الاضافه بنجاح بنجاح");
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
  Future<Either<failure, String>> editfactorytool(
      {required Factorytoolmodelrequest factorytool,
      required int factorytoolid}) async {
    try {
      Response response = await Putdata.putdata(
          path: "stocks/${factorytoolid}",
          queryParameters: factorytool.tojson(),
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الاضافه بنجاح بنجاح");
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
  Future<Either<failure, String>> deletefactorytool(
      {required int factorytoolid}) async {
    try {
      Response response = await Deletedata.deletedata(
          path: "stocks/${factorytoolid}",
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الحذف بنجاح بنجاح");
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
  Future<Either<failure, Factorytools>> getfactorytools(
      {Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.factorytools,
          queryParameters: queryparms);

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Factorytools.fromJson(response.data));
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
  Future<Either<failure, Factorytoolssearchmodel>> getfactorytoolssearch(
      {Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.factorytools,
          queryParameters: queryparms);

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Factorytoolssearchmodel.fromJson(response.data));
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
  Future<Either<failure, Factorytoolsmoves>> getfactorytoolsmotion(
      {required int factorytoolid}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.factorytoolsmoves,
          queryParameters: {"stock_id": factorytoolid});

      if (response.statusCode == 200 && response.data["success"] == true) {
        return right(Factorytoolsmoves.fromJson(response.data));
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
  Future<Either<failure, String>> addfactorytoolmotion(
      {required Factorytoolmotionrequest factorytool}) async {
    try {
      Response response = await Postdata.postdata(
          path: urls.factorytoolsmoves,
          queryParameters: factorytool.tojson(),
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الاضافه بنجاح بنجاح");
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
  Future<Either<failure, String>> deletefactorytoolmove(
      {required int move_id}) async {
    try {
      Response response = await Deletedata.deletedata(
          path: "stockmoves/${move_id}",
          token: cashhelper.getdata(key: "token"));

      if (response.data["success"] == true && response.statusCode == 200) {
        return right("تم الحذف بنجاح بنجاح");
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
}
