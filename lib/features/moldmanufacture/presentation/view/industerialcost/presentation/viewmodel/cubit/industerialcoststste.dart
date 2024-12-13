abstract class myIndusterialcostState {}

class myIndusterialcostInitial extends myIndusterialcostState {}

class deletemyIndusterialcostloading extends myIndusterialcostState {}

class deletemyIndusterialcostsuccess extends myIndusterialcostState {
  final String successmessage;

  deletemyIndusterialcostsuccess({required this.successmessage});
}

class deletemyIndusterialcostfailure extends myIndusterialcostState {
  final String failuremessage;

  deletemyIndusterialcostfailure({required this.failuremessage});
}

class getmyIndusterialcostloading extends myIndusterialcostState {}

class getmyIndusterialcostsuccess extends myIndusterialcostState {
  final String successmessage;

  getmyIndusterialcostsuccess({required this.successmessage});
}

class getmyIndusterialcostfailure extends myIndusterialcostState {
  final String errormessage;

  getmyIndusterialcostfailure({required this.errormessage});
}

class addnewimagestate extends myIndusterialcostState {}

class addmyIndusterialcostloading extends myIndusterialcostState {}

class addmyIndusterialcostsuccess extends myIndusterialcostState {
  final String successmessage;

  addmyIndusterialcostsuccess({required this.successmessage});
}

class addmyIndusterialcostfailure extends myIndusterialcostState {
  final String errormessage;

  addmyIndusterialcostfailure({required this.errormessage});
}
