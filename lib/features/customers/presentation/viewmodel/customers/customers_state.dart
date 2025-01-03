part of 'customers_cubit.dart';

abstract class CustomersState {}

class CustomersInitial extends CustomersState {}

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
