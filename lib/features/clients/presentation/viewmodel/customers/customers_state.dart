part of 'customers_cubit.dart';

abstract class CustomersState {}

class CustomersInitial extends CustomersState {}

class getclientmovesloading extends CustomersState {}

class getclientmovessuccess extends CustomersState {
  final String successmessage;

  getclientmovessuccess({required this.successmessage});
}

class getclientmovesfailure extends CustomersState {
  final String errormessage;

  getclientmovesfailure({required this.errormessage});
}

class deleteclientmoveloading extends CustomersState {}

class deleteclientmovesuccess extends CustomersState {
  final String successmessage;

  deleteclientmovesuccess({required this.successmessage});
}

class deleteclientmovefailure extends CustomersState {
  final String errormessage;

  deleteclientmovefailure({required this.errormessage});
}

class addclientmovesuccess extends CustomersState {
  final String successmessage;

  addclientmovesuccess({required this.successmessage});
}

class addclientmovefailure extends CustomersState {
  final String errormessage;

  addclientmovefailure({required this.errormessage});
}

class addclientmoveloading extends CustomersState {}

class CustomersChangeType extends CustomersState {}

class ChangeTypeState extends CustomersState {}

class changepaymentState extends CustomersState {}

class changechecboxstate extends CustomersState {}

class deleteCustomerloading extends CustomersState {}

class deleteCustomerfailure extends CustomersState {
  final String errormessage;

  deleteCustomerfailure({required this.errormessage});
}

class deleteCustomersuccess extends CustomersState {
  final String successmesssage;

  deleteCustomersuccess({required this.successmesssage});
}

class addCustomerloading extends CustomersState {}

class getCustomersloading extends CustomersState {}

class getCustomerssuccess extends CustomersState {
  final String successmessage;

  getCustomerssuccess({required this.successmessage});
}

class getCustomergfailure extends CustomersState {
  final String errormessage;

  getCustomergfailure({required this.errormessage});
}

class addCustomersuccess extends CustomersState {
  final String successmessage;

  addCustomersuccess({required this.successmessage});
}

class addCustomerfailure extends CustomersState {
  final String errormessage;

  addCustomerfailure({required this.errormessage});
}

class editCustomersuccess extends CustomersState {
  final String successmessage;

  editCustomersuccess({required this.successmessage});
}

class editCustomerfailure extends CustomersState {
  final String errormessage;

  editCustomerfailure({required this.errormessage});
}

class editcustomerloading extends CustomersState {}
