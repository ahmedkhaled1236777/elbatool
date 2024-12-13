part of 'accessories_cubit.dart';

abstract class plasticaccessoriesState {}

class accessoriesInitial extends plasticaccessoriesState {}

class addordeleteloading extends plasticaccessoriesState {}

class addordeletesuccess extends plasticaccessoriesState {
  final String successmessage;

  addordeletesuccess({required this.successmessage});
}

class addordeletefailure extends plasticaccessoriesState {
  final String errormessage;

  addordeletefailure({required this.errormessage});
}

class editaccessorieloading extends plasticaccessoriesState {}

class editaccessoriesuccess extends plasticaccessoriesState {
  final String successmessage;

  editaccessoriesuccess({required this.successmessage});
}

class editaccessoriefailure extends plasticaccessoriesState {
  final String errormessage;

  editaccessoriefailure({required this.errormessage});
}

class deleteaccessorieloading extends plasticaccessoriesState {}

class deleteaccessoriesuccess extends plasticaccessoriesState {
  final String successmessage;

  deleteaccessoriesuccess({required this.successmessage});
}

class deleteaccessoriefailure extends plasticaccessoriesState {
  final String errormessage;

  deleteaccessoriefailure({required this.errormessage});
}

class deleteaccessoriemoveloading extends plasticaccessoriesState {}

class deleteaccessorienovesuccess extends plasticaccessoriesState {
  final String successmessage;

  deleteaccessorienovesuccess({required this.successmessage});
}

class deleteaccessoriemovefailure extends plasticaccessoriesState {
  final String errormessage;

  deleteaccessoriemovefailure({required this.errormessage});
}

class getaccessoriesloading extends plasticaccessoriesState {}

class getaccessoriesfailure extends plasticaccessoriesState {
  final String errormessage;

  getaccessoriesfailure({required this.errormessage});
}

class getaccessoriessuccess extends plasticaccessoriesState {
  final String successmessage;

  getaccessoriessuccess({required this.successmessage});
}

class getaccessoriesmotionloading extends plasticaccessoriesState {}

class getaccessoriesmotionfailure extends plasticaccessoriesState {
  final String errormessage;

  getaccessoriesmotionfailure({required this.errormessage});
}

class getaccessoriesmotionsuccess extends plasticaccessoriesState {
  final String successmessage;

  getaccessoriesmotionsuccess({required this.successmessage});
}

class changetypestate extends plasticaccessoriesState {}

class addaccessorieloading extends plasticaccessoriesState {}

class addaccessoriesuccess extends plasticaccessoriesState {
  final String successmessage;

  addaccessoriesuccess({required this.successmessage});
}

class addaccessoriefailure extends plasticaccessoriesState {
  final String errormessage;

  addaccessoriefailure({required this.errormessage});
}
