part of 'factorytools_cubit.dart';

abstract class FactorytoolsState {}

class FactorytoolsInitial extends FactorytoolsState {}

class changetypestate extends FactorytoolsState {}

class edittoolloading extends FactorytoolsState {}

class edittoolsuccess extends FactorytoolsState {
  final String successmessage;

  edittoolsuccess({required this.successmessage});
}

class edittoolfailure extends FactorytoolsState {
  final String errormessage;

  edittoolfailure({required this.errormessage});
}

class addtoolloading extends FactorytoolsState {}

class addtoolsuccess extends FactorytoolsState {
  final String successmessage;

  addtoolsuccess({required this.successmessage});
}

class addtoolfailure extends FactorytoolsState {
  final String errormessage;

  addtoolfailure({required this.errormessage});
}

class addtoolmotionloading extends FactorytoolsState {}

class addtoolmotionsuccess extends FactorytoolsState {
  final String successmessage;

  addtoolmotionsuccess({required this.successmessage});
}

class addtoolmotionfailure extends FactorytoolsState {
  final String errormessage;

  addtoolmotionfailure({required this.errormessage});
}

class deletetoolloading extends FactorytoolsState {}

class deletetoolsuccess extends FactorytoolsState {
  final String successmessage;

  deletetoolsuccess({required this.successmessage});
}

class deletetoolfailure extends FactorytoolsState {
  final String errormessage;

  deletetoolfailure({required this.errormessage});
}

class deletetoolmoveloading extends FactorytoolsState {}

class deletetoolmovesuccess extends FactorytoolsState {
  final String successmessage;

  deletetoolmovesuccess({required this.successmessage});
}

class deletetoolmovefailure extends FactorytoolsState {
  final String errormessage;

  deletetoolmovefailure({required this.errormessage});
}

class gettoolloading extends FactorytoolsState {}

class gettoolsuccess extends FactorytoolsState {
  final String successmessage;

  gettoolsuccess({required this.successmessage});
}

class gettoolfailure extends FactorytoolsState {
  final String errormessage;

  gettoolfailure({required this.errormessage});
}

class gettoolmotionloading extends FactorytoolsState {}

class gettoolmotionsuccess extends FactorytoolsState {
  final String successmessage;

  gettoolmotionsuccess({required this.successmessage});
}

class gettoolmotionfailure extends FactorytoolsState {
  final String errormessage;

  gettoolmotionfailure({required this.errormessage});
}
