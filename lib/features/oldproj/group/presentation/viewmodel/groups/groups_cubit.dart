import 'package:agman/core/common/localdata.dart';
import 'package:agman/features/oldproj/group/data/model/geoupmodel.dart';
import 'package:agman/features/oldproj/group/data/repo/grouprepoimp.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  String? groupstartdate;
  final Grouprepoimp grouprepoimp;
  bool internetconnection = true;
  GroupsCubit({required this.grouprepoimp}) : super(GroupsInitial());
  List<groupmodel> groups = [];
  List<groupmodel> localgroups = [];
  addgroup({required groupmodel group, required BuildContext context}) async {
    emit(AddGroupsLoading());
    var result = await grouprepoimp.addgroup(group: group, context: context);

    result.fold((failure) {
      emit(AddGroupsFailure(error_message: failure.error_message));
    }, (success) {
      emit(AddGroupsSuccess(success_message: success));
    });
  }

  getgroups({required BuildContext context}) async {
    emit(GetGroupsLoading());
    var result = await grouprepoimp.getgroups(context: context);
    result.fold((failure) {
      emit(GetGroupsFailure(error_message: failure.error_message));
    }, (success) async {
      groups = success;
      List<Map> response =
          await Localdata.readdatabase(sql: "SELECT * FROM groups");
      response.forEach((e) {
        localgroups.add(groupmodel.fromjson(e));
      });

      if (groups.length > localgroups.length) {
        groups.forEach((e) async {
          if (!localgroups.contains(e)) {
            await Localdata.addtodatabase(
                sql:
                    "INSERT INTO groups (groupnumber,groupstatrtdate) VALUES ('${e.groupnumber}','${e.groupstatrtdate}')");
          }
        });
      } else if (groups.length < localgroups.length) {
        groups.forEach((e) async {
          if (!localgroups.contains(e)) {
            print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
            print(e.id);
            await Localdata.deletefromdatabase(
                sql: 'DELETE FROM groups WHERE id = ${e.id}');
          }
        });
      } else {
        groups.forEach((e) async {
          if (!localgroups.contains(e)) {
            await Localdata.addtodatabase(
                sql:
                    "INSERT INTO groups (groupnumber,groupstatrtdate) VALUES ('${e.groupnumber}','${e.groupstatrtdate}')");
          }
        });
        localgroups.forEach((e) async {
          if (!groups.contains(e)) {
            print("iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
            print(e);
            await Localdata.deletefromdatabase(
                sql: 'DELETE FROM groups WHERE id = ${e.id}');
          }
        });
      }
      emit(GetGroupsSuccess(
          success_message: "تم الحصول على جميع المجموعات بنجاح"));
    });
  }

  groupdatechange(String val) {
    groupstartdate = val;
    emit(ChangeDropApp());
  }

  retsetdat() {
    groupstartdate = null;
    emit(ChangeDropApp());
  }
}
