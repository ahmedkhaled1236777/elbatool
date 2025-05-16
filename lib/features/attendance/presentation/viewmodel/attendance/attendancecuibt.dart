import 'package:agman/features/attendance/data/models/holidaymodel/datum.dart';
import 'package:agman/features/attendance/data/models/holidaymodelrequest.dart';
import 'package:agman/features/attendance/data/models/moneymodel/datum.dart';
import 'package:agman/features/attendance/data/models/moneyrequest.dart';
import 'package:agman/features/attendance/data/models/permessionmodel/datum.dart';
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

  List<Datumholiday> holidays = [];
  List<Datumpermession> permessions = [];
  List<datamoves> employeeattendances = [];
  String? month;
  String? year;
  String moneyname = "credit";
  List<moneymoves> moneys = [];

  String? attendancestatus;
  String date = "${DateTime.now().month}-${DateTime.now().year}";

  String permessionstatus = "0";
  changedate(String value) {
    date = value;
    emit(changedatestate());
  }

  getmoneymoves({required Map<String, dynamic> queryparma}) async {
    emit(getmoneymoveloading());
    var result = await attendancerepo.getmoney(queryparma: queryparma);
    result.fold((failure) {
      emit(getmoneymovefailure(errormessage: failure.error_message));
    }, (Success) {
      moneys = Success.data!;
      emit(getmoneymovesuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  changepermessiontype(String value) {
    permessionstatus = value;
    emit(changepermessionstatus());
  }

  changemoneytype(String value) {
    moneyname = value;
    emit(changemoneytypestate());
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

  addholiday({
    required Holidaymodelrequest holidayrequest,
  }) async {
    emit(addholidayloading());
    var result =
        await attendancerepo.addholiday(holidayrequest: holidayrequest);
    result.fold((failure) {
      emit(addholidayfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addholidaysuccess(successmessage: success));
    });
  }

  addpermession({
    required Attendancepermessionrequest permession,
  }) async {
    emit(addpermessionloading());
    var result = await attendancerepo.addpermession(permession: permession);
    result.fold((failure) {
      emit(addpermessionfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addpermessionsuccess(successmessage: success));
    });
  }

  deleteholiday({
    required int id,
  }) async {
    emit(deleteholidayloading());
    var result = await attendancerepo.deleteholiday(id: id);
    result.fold((failure) {
      emit(deleteholidayfailure(errormessage: failure.error_message));
    }, (success) {
      holidays.removeWhere((e) {
        return e.id == id;
      });
      emit(deleteholidaysuccess(successmessage: success));
    });
  }

  getholiday(
      {required String month,
      required int employerid,
      required String year}) async {
    emit(getholidayloading());
    var result = await attendancerepo.getholidays(
        month: month, employerid: employerid, year: year);
    result.fold((failure) {
      emit(getholidayfailure(errormessage: failure.error_message));
    }, (success) {
      holidays = success.data!;
      emit(getholidaysuccess(successmessage: "success"));
    });
  }

  getpermessions(
      {required String month,
      required int employerid,
      required String year}) async {
    emit(getpermessionloading());
    var result = await attendancerepo.getpermessionss(
        month: month, employerid: employerid, year: year);
    result.fold((failure) {
      emit(getpermessionfailure(errormessage: failure.error_message));
    }, (success) {
      permessions = success.data!;
      emit(getpermessionsuccess(successmessage: "success"));
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

  deletepermession({required int id}) async {
    emit(deletepermessionloading());
    var result = await attendancerepo.deletepermession(id: id);
    result.fold((failure) {
      emit(deletepermessionfailure(errormessage: failure.error_message));
    }, (success) {
      permessions.removeWhere((e) {
        return e.id == id;
      });
      emit(deletepermessionsuccess(successmessage: success));
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

  addmoney({required moneyrequset money}) async {
    emit(addmoneyloading());
    var result = await attendancerepo.addmoney(moneyrequest: money);
    result.fold((failure) {
      emit(addmoneyfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addmoneysuccess(successmessage: success));
    });
  }

  deletemoney({required int id}) async {
    emit(deletemoneyloading());
    var result = await attendancerepo.deletemoney(id: id);
    result.fold((failure) {
      emit(deletemoneyfailure(errormessage: failure.error_message));
    }, (success) {
      moneys.removeWhere((e) {
        return e.id == id;
      });
      emit(deletemoneysuccess(successmessage: success));
    });
  }

  getsalary(Datum data, int month, int year) {
    return DateTime(year, month + 1, 0).day.toString();
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
