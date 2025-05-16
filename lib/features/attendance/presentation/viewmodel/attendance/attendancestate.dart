abstract class Attendancestate {}

class attendanceintial extends Attendancestate {}

class changedatestate extends Attendancestate {}

class addholidayloading extends Attendancestate {}

class addholidaysuccess extends Attendancestate {
  final String successmessage;

  addholidaysuccess({required this.successmessage});
}

class addholidayfailure extends Attendancestate {
  final String errormessage;

  addholidayfailure({required this.errormessage});
}

class getholidayloading extends Attendancestate {}

class getholidaysuccess extends Attendancestate {
  final String successmessage;

  getholidaysuccess({required this.successmessage});
}

class getholidayfailure extends Attendancestate {
  final String errormessage;

  getholidayfailure({required this.errormessage});
}

class deleteholidayloading extends Attendancestate {}

class deleteholidaysuccess extends Attendancestate {
  final String successmessage;

  deleteholidaysuccess({required this.successmessage});
}

class deleteholidayfailure extends Attendancestate {
  final String errormessage;

  deleteholidayfailure({required this.errormessage});
}

class getmoneymoveloading extends Attendancestate {}

class getmoneymovesuccess extends Attendancestate {
  final String successmessage;

  getmoneymovesuccess({required this.successmessage});
}

class getmoneymovefailure extends Attendancestate {
  final String errormessage;

  getmoneymovefailure({required this.errormessage});
}

class addmoneyloading extends Attendancestate {}

class addmoneysuccess extends Attendancestate {
  final String successmessage;

  addmoneysuccess({required this.successmessage});
}

class addmoneyfailure extends Attendancestate {
  final String errormessage;

  addmoneyfailure({required this.errormessage});
}

class deletemoneyloading extends Attendancestate {}

class deletepermessionloading extends Attendancestate {}

class deletemoneysuccess extends Attendancestate {
  final String successmessage;

  deletemoneysuccess({required this.successmessage});
}

class deletepermessionsuccess extends Attendancestate {
  final String successmessage;

  deletepermessionsuccess({required this.successmessage});
}

class deletemoneyfailure extends Attendancestate {
  final String errormessage;

  deletemoneyfailure({required this.errormessage});
}

class deletepermessionfailure extends Attendancestate {
  final String errormessage;

  deletepermessionfailure({required this.errormessage});
}

class getpermessionfailure extends Attendancestate {
  final String errormessage;

  getpermessionfailure({required this.errormessage});
}

class addpermessionloading extends Attendancestate {}

class getpermessionloading extends Attendancestate {}

class changemoneytypestate extends Attendancestate {}

class changepermessionstatus extends Attendancestate {}

class addpermessionsuccess extends Attendancestate {
  final String successmessage;

  addpermessionsuccess({required this.successmessage});
}

class getpermessionsuccess extends Attendancestate {
  final String successmessage;

  getpermessionsuccess({required this.successmessage});
}

class addpermessionfailure extends Attendancestate {
  final String errormessage;

  addpermessionfailure({required this.errormessage});
}

class editattendanceloading extends Attendancestate {}

class editattendencesuccess extends Attendancestate {
  final String successmessage;

  editattendencesuccess({required this.successmessage});
}

class editattendancefailure extends Attendancestate {
  final String errormessage;

  editattendancefailure({required this.errormessage});
}

class changestatus extends Attendancestate {}

class getattendancemoveloading extends Attendancestate {}

class getattendancemovesuccess extends Attendancestate {
  final String successmessage;

  getattendancemovesuccess({required this.successmessage});
}

class getattendancemovefailure extends Attendancestate {
  final String errormessage;

  getattendancemovefailure({required this.errormessage});
}

class addattendanceloading extends Attendancestate {}

class addattendancesuccess extends Attendancestate {
  final String successmessage;

  addattendancesuccess({required this.successmessage});
}

class addattendancefailure extends Attendancestate {
  final String errormessage;

  addattendancefailure({required this.errormessage});
}

class attendanceloading extends Attendancestate {}

class attendancesuccess extends Attendancestate {
  final String successmessage;

  attendancesuccess({required this.successmessage});
}

class attendancefailure extends Attendancestate {
  final String errormessage;

  attendancefailure({required this.errormessage});
}
