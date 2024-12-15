part of 'injection_cubit.dart';

abstract class InjectionState {}

class InjectionInitial extends InjectionState {}

class getmoldandordersloading extends InjectionState {}

class getmoldandorderssuccess extends InjectionState {
  final String successmessage;

  getmoldandorderssuccess({required this.successmessage});
}

class getmoldandordersfailure extends InjectionState {
  final String errormessage;

  getmoldandordersfailure({required this.errormessage});
}

class deleteinjectionloading extends InjectionState {}

class deleteinjectionfailure extends InjectionState {
  final String errormessage;

  deleteinjectionfailure({required this.errormessage});
}

class deleteinjectionsuccess extends InjectionState {
  final String successmesssage;

  deleteinjectionsuccess({required this.successmesssage});
}

class addinjectionloading extends InjectionState {}

class getinjectionsloading extends InjectionState {}

class getinjectionssuccess extends InjectionState {
  final String successmessage;

  getinjectionssuccess({required this.successmessage});
}

class getinjectiongfailure extends InjectionState {
  final String errormessage;

  getinjectiongfailure({required this.errormessage});
}

class addinjectionsuccess extends InjectionState {
  final String successmessage;

  addinjectionsuccess({required this.successmessage});
}

class addinjectionfailure extends InjectionState {
  final String errormessage;

  addinjectionfailure({required this.errormessage});
}
