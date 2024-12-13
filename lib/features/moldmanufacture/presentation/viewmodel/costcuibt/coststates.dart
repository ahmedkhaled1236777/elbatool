abstract class Coststates {}

class costintial extends Coststates {}

class addnewimagestate extends Coststates {}

class editmoldmanufactureloading extends Coststates {}

class editmoldmanufacturesuccess extends Coststates {
  final String succcessmessage;

  editmoldmanufacturesuccess({required this.succcessmessage});
}

class editmoldmanufacturefailure extends Coststates {
  final String errormessage;

  editmoldmanufacturefailure({required this.errormessage});
}

class deletemoldmanufactureloading extends Coststates {}

class deletemoldmanufacturesuccess extends Coststates {
  final String successmessage;

  deletemoldmanufacturesuccess({required this.successmessage});
}

class deletemoldmanufacturefailure extends Coststates {
  final String errrormessage;

  deletemoldmanufacturefailure({required this.errrormessage});
}

class getmoldsmanufactureloading extends Coststates {}

class getmoldmanufacturesuccess extends Coststates {
  final String successmessage;

  getmoldmanufacturesuccess({required this.successmessage});
}

class getmoldsmanufacturefailure extends Coststates {
  final String errormessage;

  getmoldsmanufacturefailure({required this.errormessage});
}

class addmoldmanufactureloading extends Coststates {}

class addmoldmanufacturesuccess extends Coststates {
  final String successmessage;

  addmoldmanufacturesuccess({required this.successmessage});
}

class addmoldmanufacturefailure extends Coststates {
  final String errorrmessage;

  addmoldmanufacturefailure({required this.errorrmessage});
}
