import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/urls.dart';
import 'package:agman/core/services/apiservice.dart';
import 'package:agman/features/clients/data/models/clientmodel/clientmodel.dart';
import 'package:agman/features/clients/data/models/clientmoverequest/clientmoverequest.dart';
import 'package:agman/features/clients/data/models/clientmovesmodel/clientmovesmodel.dart';
import 'package:agman/features/clients/data/models/clientrequest.dart';
import 'package:agman/features/clients/data/repos/clientsrepo.dart';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class Clientsrepoimp extends Clientsrepo {
  @override
  Future<Either<failure, String>> addclient(
      {required Clientrequest client}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.clients,
          data: client.tojson());
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
  Future<Either<failure, String>> editclient(
      {required Clientrequest client}) async {
    try {
      Response response = await Putdata.putdata(
          token: cashhelper.getdata(key: "token"),
          path: "clients/${client.id}",
          queryParameters: client.tojson());
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
  Future<Either<failure, Clientmodel>> getclients(
      {Map<String, dynamic>? queryparms}) async {
    try {
      Response response = await Getdata.getdata(
        token: cashhelper.getdata(key: "token"),
        path: urls.clients,
      );

      if (response.statusCode == 200 && response.data["status"] == true) {
        return right(Clientmodel.fromJson(response.data));
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
  Future<Either<failure, String>> deleteclient({required int clientid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "clients/${clientid}",
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

  @override
  Future<Either<failure, String>> addclientmove(
      {required Clientmoverequest Clientmovere}) async {
    try {
      Response response = await Postdata.postdata(
          token: cashhelper.getdata(key: "token"),
          path: urls.clientmoves,
          queryParameters: Clientmovere.tojson());
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
  Future<Either<failure, String>> deleteclientmove(
      {required int moveid}) async {
    try {
      Response response = await Deletedata.deletedata(
        token: cashhelper.getdata(key: "token"),
        path: "clientmoves/${moveid}",
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

  @override
  Future<Either<failure, Clientmovesmodel>> getclientmoves(
      {required int page,
      required int clientid,
      String? date,
      String? status}) async {
    try {
      Response response = await Getdata.getdata(
          token: cashhelper.getdata(key: "token"),
          path: "clientmoves?page=${page}",
          queryParameters: {
            "client_id": clientid,
            "date": date,
            "status": status
          });

      if (response.data["success"] == true && response.statusCode == 200) {
        return right(Clientmovesmodel.fromJson(response.data));
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
