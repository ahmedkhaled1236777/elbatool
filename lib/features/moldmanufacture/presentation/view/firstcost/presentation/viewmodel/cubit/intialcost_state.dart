part of 'intialcost_cubit.dart';

abstract class IntialcostState {}

class IntialcostInitial extends IntialcostState {}

class deleteintialcostloading extends IntialcostState {}

class deleteintialcostsuccess extends IntialcostState {
  final String successmessage;

  deleteintialcostsuccess({required this.successmessage});
}

class deleteintialcostfailure extends IntialcostState {
  final String failuremessage;

  deleteintialcostfailure({required this.failuremessage});
}

class getintialcostloading extends IntialcostState {}

class getintialcostsuccess extends IntialcostState {
  final String successmessage;

  getintialcostsuccess({required this.successmessage});
}

class getintialcostfailure extends IntialcostState {
  final String errormessage;

  getintialcostfailure({required this.errormessage});
}

class addnewimagestate extends IntialcostState {}

class addintialcostloading extends IntialcostState {}

class addintialcostsuccess extends IntialcostState {
  final String successmessage;

  addintialcostsuccess({required this.successmessage});
}

class addintialcostfailure extends IntialcostState {
  final String errormessage;

  addintialcostfailure({required this.errormessage});
}
