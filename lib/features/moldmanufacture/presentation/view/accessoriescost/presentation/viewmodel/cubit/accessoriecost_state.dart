part of 'accessoriecost_cubit.dart';

abstract class accessoriecostState {}

class accessoriecostInitial extends accessoriecostState {}

class deleteaccessoriecostloading extends accessoriecostState {}

class deleteaccessoriecostsuccess extends accessoriecostState {
  final String successmessage;

  deleteaccessoriecostsuccess({required this.successmessage});
}

class deleteaccessoriecostfailure extends accessoriecostState {
  final String failuremessage;

  deleteaccessoriecostfailure({required this.failuremessage});
}

class getaccessoriecostloading extends accessoriecostState {}

class getaccessoriecostsuccess extends accessoriecostState {
  final String successmessage;

  getaccessoriecostsuccess({required this.successmessage});
}

class getaccessoriecostfailure extends accessoriecostState {
  final String errormessage;

  getaccessoriecostfailure({required this.errormessage});
}

class addnewimagestate extends accessoriecostState {}

class addaccessoriecostloading extends accessoriecostState {}

class addaccessoriecostsuccess extends accessoriecostState {
  final String successmessage;

  addaccessoriecostsuccess({required this.successmessage});
}

class addaccessoriecostfailure extends accessoriecostState {
  final String errormessage;

  addaccessoriecostfailure({required this.errormessage});
}
