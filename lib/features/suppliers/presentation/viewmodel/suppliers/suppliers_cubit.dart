import 'package:agman/features/suppliers/data/models/suppliermotionrequest.dart';
import 'package:agman/features/suppliers/data/models/supplierrequest.dart';
import 'package:agman/features/suppliers/data/repos/supplierrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/suppliermodel/datum.dart';
import '../../../data/models/suppliermotionmodel/datum.dart';

part 'suppliers.dart';

class SupplierssCubit extends Cubit<SupplierssState> {
  final suppliersrepoimp supplierepo;
  SupplierssCubit({required this.supplierepo}) : super(SupplierssInitial());
  String type = "SUPPLY";
  String materialtype = "pure";
  String paymenttype = "cash";
  String supplypart = "material";
  List<Datum> suppliers = [];
  List<bool> checks = [];
  String totaldaen = "0";
  String totalmaden = "0";
  List<Datummove> mymoves = [];
  bool loading = false;

  int page = 1;
  bool firstloading = false;
  changetype({required String value}) {
    type = value;
    emit(ChangesupplierTypeState());
  }

  changesupplytype({required String value}) {
    supplypart = value;
    emit(ChangesupplierTypeState());
  }

  changesupplymaterialtype({required String value}) {
    materialtype = value;
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

  addsuppliermotion({required Suppliermotionrequest supplier}) async {
    emit(addsuppliermotionloading());
    var result = await supplierepo.addsuppliermotion(supppliermotion: supplier);

    result.fold((failure) {
      emit(addsuppliermotionfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addsuppliermotionsuccess(successmessage: success));
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

  getsuppliermovesmoves({Map<String, dynamic>? queryparmes}) async {
    if (firstloading == false) emit(getSuppliersmovesloading());
    this.page = 1;

    var result = await supplierepo.getsuppliersmotion(queryparms: queryparmes);
    loading = true;
    result.fold((failue) {
      emit(getSuppliersmovesfailure(errormessage: failue.error_message));
    }, (success) {
      if (success.moves!.nextPageUrl == null) {
        loading = false;
      }
      totaldaen = success.totalCredit.toString();
      totalmaden = success.totalDue.toString();
      mymoves.clear();
      checks.clear();

      firstloading = true;
      success.moves!.data!.forEach((e) {
        mymoves.add(e);
        checks.add(false);
      });

      emit(getSuppliersmovessuccess(successmessage: ""));
    });
  }

  getamoresuppliermoves({Map<String, dynamic>? queryparmes}) async {
    page++;
    var result = await supplierepo.getsuppliersmotion(queryparms: queryparmes);
    loading = true;
    result.fold((failue) {
      emit(getSuppliersmovesfailure(errormessage: failue.error_message));
    }, (success) {
      if (success.moves!.nextPageUrl == null) {
        loading = false;
      }
      success.moves!.data!.forEach((e) {
        mymoves.add(e);
        checks.add(false);
      });
      emit(getSuppliersmovessuccess(successmessage: ""));
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

  deletesuppliermove({required int moveid}) async {
    emit(deleteSuppliermoveloading());
    var result = await supplierepo.deletesuppliermotion(
      suppliermotionid: moveid,
    );
    result.fold((failure) {
      emit(deletesuppliermovefailure(errormessage: failure.error_message));
    }, (success) {
      mymoves.removeWhere((e) {
        return e.id == moveid;
      });
      emit(deletesuppliermovesuccess(successmessage: success));
    });
  }

  changecheckbox(bool val, int i) {
    checks[i] = val;
    emit(changechecboxstate());
  }
}
