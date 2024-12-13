part of 'mold_cubit.dart';

abstract class MoldState {}

class MoldInitial extends MoldState {}

class changemoldstate extends MoldState {}

class AddMoldLoading extends MoldState {}

class AddMoldSuccess extends MoldState {
  final String successmessage;

  AddMoldSuccess({required this.successmessage});
}

class AddMoldFailure extends MoldState {
  final String errormessage;

  AddMoldFailure({required this.errormessage});
}

class GetMoldLoading extends MoldState {}

class GetMoldFailure extends MoldState {
  final String errormessage;

  GetMoldFailure({required this.errormessage});
}

class GetMoldSuccess extends MoldState {
  final String successmessage;

  GetMoldSuccess({required this.successmessage});
}

class Updatemoldloading extends MoldState {}

class updatemoldsuccess extends MoldState {
  final String successmessage;

  updatemoldsuccess({required this.successmessage});
}

class updatemoldfailure extends MoldState {
  final String errormessage;

  updatemoldfailure({required this.errormessage});
}

class DeletemoldsLoading extends MoldState {}

class searchmold extends MoldState {}

class DeletemoldSuccess extends MoldState {
  final String successmessage;

  DeletemoldSuccess({required this.successmessage});
}

class DeletemoldsFailure extends MoldState {
  final String errormessage;

  DeletemoldsFailure({required this.errormessage});
}
