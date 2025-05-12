import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agman/features/attendance/data/models/attendancemodelrequest.dart';
import 'package:agman/features/attendance/data/models/attendancemovemodel/datum.dart';
import 'package:agman/features/attendance/data/models/attendancepermessionrequest.dart';
import 'package:agman/features/attendance/data/repos/attendancerepoimp.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';

import '../../../../workers/data/models/workermodel/datum.dart';

class Attendancecuibt extends Cubit<Attendancestate> {
  Attendancecuibt(this.attendancerepo) : super(attendanceintial());
  final attendancerepoimp attendancerepo;
  List<Datum> attendances = [];
  List<datamoves> employeeattendances = [];
  String? month;
  String? year;
  String? attendancestatus;
  String date = "${DateTime.now().month}-${DateTime.now().year}";

  String permessionstatus = "0";
  changedate(String value) {
    date = value;
    emit(changedatestate());
  }

  changepermessiontype(String value) {
    permessionstatus = value;
    emit(changepermessionstatus());
  }

  editchangeattendancestatus({required String value}) {
    attendancestatus = value;
    emit(changestatus());
  }

  addworker({required Attendancemodelrequest attendance}) async {
    emit(addattendanceloading());
    var result = await attendancerepo.addattendance(attendance: attendance);
    result.fold((failure) {
      emit(addattendancefailure(errormessage: failure.error_message));
    }, (success) {
      emit(addattendancesuccess(successmessage: success));
    });
  }

  addpermession({required Attendancepermessionrequest permession}) async {
    emit(addpermessionloading());
    var result = await attendancerepo.addpermession(permession: permession);
    result.fold((failure) {
      emit(addpermessionfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addpermessionsuccess(successmessage: success));
    });
  }

  editattendance({required Attendancemodelrequest attendance}) async {
    emit(editattendanceloading());
    var result = await attendancerepo.editattendance(attendance: attendance);
    result.fold((failure) {
      emit(editattendancefailure(errormessage: failure.error_message));
    }, (success) {
      emit(editattendencesuccess(successmessage: success));
    });
  }

  editpermession(
      {required Attendancepermessionrequest attendance,
      required int id}) async {
    emit(editattendanceloading());
    var result =
        await attendancerepo.editpermession(attendance: attendance, id: id);
    result.fold((failure) {
      emit(editattendancefailure(errormessage: failure.error_message));
    }, (success) {
      emit(editattendencesuccess(successmessage: success));
    });
  }

  getaattendance({required Map<String, dynamic> queryparma}) async {
    emit(attendanceloading());
    var result = await attendancerepo.getattendances(queryparma: queryparma);
    result.fold((failure) {
      emit(attendancefailure(errormessage: failure.error_message));
    }, (Success) {
      attendances.clear();
      Success.data!.forEach((e) {
        attendances.add(e);
      });
      emit(attendancesuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getaattendanceemployermoves(
      {required Map<String, dynamic> queryparma}) async {
    emit(getattendancemoveloading());
    var result =
        await attendancerepo.getattendancesemoves(queryparma: queryparma);
    result.fold((failure) {
      emit(getattendancemovefailure(errormessage: failure.error_message));
    }, (Success) {
      emit(getattendancemovesuccess(
          successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  getsalary(Datum data) {
    return "6222";
    /* if ((data.totalAttendance! + data.totalVacation!) == 31) {
      return (int.parse(data.salary!) -
              (((double.parse(data.salary!) / 30) /
                      double.parse(data.workedHours!)) *
                  data.totalPermissions!))
          .ceil()
          .toString();
    } else {
      int totalabsense = 0;
      totalabsense = data.totalVacation! + (data.totalVacation! / 4).floor();
      return ((((data.totalAttendance! + data.totalAbsence!) *
                      (double.parse(data.salary!) / 30)) -
                  (totalabsense * (double.parse(data.salary!) / 30))) -
              (((double.parse(data.salary!) / 30) /
                      double.parse(data.workedHours!)) *
                  data.totalPermissions!) +
              (((double.parse(data.salary!) / 30) /
                      double.parse(data.workedHours!)) *
                  data.totalExtraTime!))
          .ceil()
          .toString();
    }*/
  }

  editatttendancemove({required String status, required int id}) async {
    emit(editattendanceloading());
    var result =
        await attendancerepo.editattendancemove(status: status, id: id);
    result.fold((failure) {
      emit(editattendancefailure(errormessage: failure.error_message));
    }, (success) {
      emit(editattendencesuccess(successmessage: success));
    });
  }
}
