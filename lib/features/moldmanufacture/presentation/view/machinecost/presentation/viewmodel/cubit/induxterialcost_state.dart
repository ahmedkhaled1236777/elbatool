part of 'induxterialcost_cubit.dart';

abstract class InduxterialcostState {}

class InduxterialcostInitial extends InduxterialcostState {}

class changemachinestate extends InduxterialcostState {}

class editmachineloading extends InduxterialcostState {}

class editmachinesuccess extends InduxterialcostState {
  final String successmessage;

  editmachinesuccess({required this.successmessage});
}

class editmachinefailure extends InduxterialcostState {
  final String errormessage;

  editmachinefailure({required this.errormessage});
}

class getmachinesloading extends InduxterialcostState {}

class getmachinessuccess extends InduxterialcostState {
  final String successmessage;

  getmachinessuccess({required this.successmessage});
}

class getmachinesfailure extends InduxterialcostState {
  final String errormessage;

  getmachinesfailure({required this.errormessage});
}

class deletemachineloading extends InduxterialcostState {}

class deletemachinesuccess extends InduxterialcostState {
  final String successmessage;

  deletemachinesuccess({required this.successmessage});
}

class deletemachinefailure extends InduxterialcostState {
  final String errormessage;

  deletemachinefailure({required this.errormessage});
}

class addmachineloading extends InduxterialcostState {}

class addmachinesuccess extends InduxterialcostState {
  final String successmessage;

  addmachinesuccess({required this.successmessage});
}

class addmachinefailure extends InduxterialcostState {
  final String errormessage;

  addmachinefailure({required this.errormessage});
}
