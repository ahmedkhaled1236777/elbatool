part of 'save_cubit.dart';

abstract class SaveState {}

class SaveInitial extends SaveState {}

class changesavestate extends SaveState {}

class addsaveloading extends SaveState {}

class addsavesuccess extends SaveState {
  final String successmessage;

  addsavesuccess({required this.successmessage});
}

class addsavefailure extends SaveState {
  final String errormessage;

  addsavefailure({required this.errormessage});
}

class getsaveloading extends SaveState {}

class getsavesuccess extends SaveState {
  final String successmessage;

  getsavesuccess({required this.successmessage});
}

class getsavefailure extends SaveState {
  final String errormessage;

  getsavefailure({required this.errormessage});
}

class deletesaveloading extends SaveState {}

class deletesavesuccess extends SaveState {
  final String successmessage;

  deletesavesuccess({required this.successmessage});
}

class deletesavefailure extends SaveState {
  final String errormessage;

  deletesavefailure({required this.errormessage});
}
