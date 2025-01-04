import 'package:agman/features/suppliers/data/models/supplierrequest.dart';
import 'package:agman/features/suppliers/data/repos/supplierrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/suppliermodel/datum.dart';

part 'suppliers.dart';

class SupplierssCubit extends Cubit<SupplierssState> {
  final suppliersrepoimp supplierepo;
  SupplierssCubit({required this.supplierepo}) : super(SupplierssInitial());
  String type = "SUPPLY";
  String paymenttype = "cash";
  String supplypart = "materiel";
  List<Datum> suppliers = [];
  changetype({required String value}) {
    type = value;
    emit(ChangesupplierTypeState());
  }

  changesupplytype({required String value}) {
    supplypart = value;
    emit(ChangesupplierTypeState());
  }

  changepaymenttype({required String value}) {
    paymenttype = value;
    emit(changepaymentsupplierState());
  }

  addsupplier({required Supplierrequest supplier}) async {
    emit(addSupplierloading());
    var result = await supplierepo.addsupplier(supplier: supplier);

    result.fold((failure) {
      emit(addSupplierfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addSuppliersuccess(successmessage: success));
    });
  }

  editsupplier({required Supplierrequest supplier}) async {
    emit(editSupplierloading());
    var result = await supplierepo.editsupplier(supplier: supplier);

    result.fold((failure) {
      emit(editSupplierfailure(errormessage: failure.error_message));
    }, (success) {
      emit(editSuppliersuccess(successmessage: success));
    });
  }

  getSuppliers() async {
    emit(getSuppliersloading());
    var result = await supplierepo.getsuppliers();
    result.fold((failure) {
      emit(getSuppliergfailure(errormessage: failure.error_message));
    }, (success) {
      suppliers.clear();
      success.data!.forEach((e) {
        suppliers.add(e);
      });
      emit(getSupplierssuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  deletesupplier({required int supplierid}) async {
    emit(deleteSupplierloading());
    var result = await supplierepo.deletesupplier(
      supplierid: supplierid,
    );
    result.fold((failure) {
      emit(deleteSupplierfailure(errormessage: failure.error_message));
    }, (success) {
      suppliers.removeWhere((e) {
        return e.id == supplierid;
      });
      emit(deleteSuppliersuccess(successmesssage: success));
    });
  }
}
