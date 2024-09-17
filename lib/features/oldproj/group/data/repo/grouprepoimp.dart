import 'package:agman/core/common/checkconnectivity.dart';
import 'package:agman/core/common/errors/failure.dart';
import 'package:agman/core/common/errors/handlingerror.dart';
import 'package:agman/core/common/localdata.dart';
import 'package:agman/features/oldproj/group/data/model/geoupmodel.dart';
import 'package:agman/features/oldproj/group/data/repo/grouprepo.dart';
import 'package:agman/features/oldproj/group/presentation/viewmodel/groups/groups_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Grouprepoimp extends Grouprepo {
  @override
  Future<Either<failure, String>> addgroup(
      {required groupmodel group, required BuildContext context}) async {
    try {
      int? response;
      BlocProvider.of<GroupsCubit>(context).internetconnection
          ? {
              await Localdata.addtodatabase(
                      sql:
                          "INSERT INTO groups (groupnumber,groupstatrtdate) VALUES ('${group.groupnumber}','${group.groupstatrtdate}')")
                  .then((va) async {
                await FirebaseFirestore.instance
                    .collection("groups")
                    .doc("${va}")
                    .set(group.tojson(id: va));
              }),
            }
          : {
              await Localdata.addtodatabase(
                      sql:
                          "INSERT INTO groups (groupnumber,groupstatrtdate) VALUES ('${group.groupnumber}','${group.groupstatrtdate}')")
                  .then((va) async {
                Localdata.addtodatabase(
                    sql:
                        "INSERT INTO transactions (id,groupnumber,groupstatrtdate) VALUES ('${va}','${group.groupnumber}','${group.groupstatrtdate}')");
              }),
            };
      return right("تم تسجيل بيانات التقرير بنجاح");
      // ignore: empty_catches
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }

  @override
  Future<Either<failure, List<groupmodel>>> getgroups(
      {required BuildContext context}) async {
    List<groupmodel> groups = [];
    List<Map> localgroups = [];
    try {
      BlocProvider.of<GroupsCubit>(context).internetconnection
          ? {
              await FirebaseFirestore.instance
                  .collection("groups")
                  .orderBy("id", descending: true)
                  .get()
                  .then((value) {
                value.docs.forEach((element) {
                  groups.add(groupmodel.fromjson(element.data()));
                });
              })
            }
          : {
              localgroups = Localdata.readdatabase(sql: "SELECT * FROM groups"),
              localgroups.forEach((e) {
                groups.add(groupmodel.fromjson(e));
              })
            };
      return right(groups);
    } catch (e) {
      return left(requestfailure(error_message: e.toString()));
    }
  }
}
