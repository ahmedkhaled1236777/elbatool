part of 'suppliers_cubit.dart';

abstract class SupplierssState {}

class SupplierssInitial extends SupplierssState {}

class SupplierssChangeType extends SupplierssState {}

class ChangesupplierTypeState extends SupplierssState {}

class changepaymentsupplierState extends SupplierssState {}

class deleteSupplierloading extends SupplierssState {}

class deleteSupplierfailure extends SupplierssState {
  final String errormessage;

  deleteSupplierfailure({required this.errormessage});
}

class deleteSuppliersuccess extends SupplierssState {
  final String successmesssage;

  deleteSuppliersuccess({required this.successmesssage});
}

class addSupplierloading extends SupplierssState {}

class getSuppliersloading extends SupplierssState {}

class getSupplierssuccess extends SupplierssState {
  final String successmessage;

  getSupplierssuccess({required this.successmessage});
}

class getSuppliergfailure extends SupplierssState {
  final String errormessage;

  getSuppliergfailure({required this.errormessage});
}

class addSuppliersuccess extends SupplierssState {
  final String successmessage;

  addSuppliersuccess({required this.successmessage});
}

class addSupplierfailure extends SupplierssState {
  final String errormessage;

  addSupplierfailure({required this.errormessage});
}

class editSuppliersuccess extends SupplierssState {
  final String successmessage;

  editSuppliersuccess({required this.successmessage});
}

class editSupplierfailure extends SupplierssState {
  final String errormessage;

  editSupplierfailure({required this.errormessage});
}

class editSupplierloading extends SupplierssState {}
