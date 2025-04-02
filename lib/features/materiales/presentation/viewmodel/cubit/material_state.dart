part of 'material_cubit.dart';

abstract class plasticMaterialState {}

class MaterialInitial extends plasticMaterialState {}

class changetypestate extends plasticMaterialState {}

class Updatematerialloading extends plasticMaterialState {}

class updatematerialsuccess extends plasticMaterialState {
  final String successmessage;

  updatematerialsuccess({required this.successmessage});
}

class updatematerialfailure extends plasticMaterialState {
  final String errormessage;

  updatematerialfailure({required this.errormessage});
}

class changetypematerialstate extends plasticMaterialState {}

class AddMaterialLoading extends plasticMaterialState {}

class AddMaterialmoveLoading extends plasticMaterialState {}

class AddMaterialmovesuccess extends plasticMaterialState {
  final String successmessage;

  AddMaterialmovesuccess({required this.successmessage});
}

class AddMaterialmovefailure extends plasticMaterialState {
  final String errormessage;

  AddMaterialmovefailure({required this.errormessage});
}

class AddMaterialSuccess extends plasticMaterialState {
  final String successmessage;

  AddMaterialSuccess({required this.successmessage});
}

class AddMaterialFailure extends plasticMaterialState {
  final String errormessage;

  AddMaterialFailure({required this.errormessage});
}

class DeleteMaterialsLoading extends plasticMaterialState {}

class DeleteMaterialSuccess extends plasticMaterialState {
  final String successmessage;

  DeleteMaterialSuccess({required this.successmessage});
}

class DeleteMaterialsFailure extends plasticMaterialState {
  final String errormessage;

  DeleteMaterialsFailure({required this.errormessage});
}

class GetMaterialsLoading extends plasticMaterialState {}

class deletematerialmovesloading extends plasticMaterialState {}

class deletematerialmovessuccess extends plasticMaterialState {
  final String successmessage;

  deletematerialmovessuccess({required this.successmessage});
}

class deletematerialmovesfailure extends plasticMaterialState {
  final String errormessage;

  deletematerialmovesfailure({required this.errormessage});
}

class GetMaterialsmovesLoading extends plasticMaterialState {}

class GetMaterialsmovessuccess extends plasticMaterialState {
  final String successmessage;

  GetMaterialsmovessuccess({required this.successmessage});
}

class GetMaterialsmovesfailure extends plasticMaterialState {
  final String errormessage;

  GetMaterialsmovesfailure({required this.errormessage});
}

class GetMaterialsSuccess extends plasticMaterialState {
  final String successmessage;

  GetMaterialsSuccess({required this.successmessage});
}

class GetMaterialsFailure extends plasticMaterialState {
  final String errormessage;

  GetMaterialsFailure({required this.errormessage});
}
