import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'suppliers.dart';

class SupplierssCubit extends Cubit<SupplierssState> {
  SupplierssCubit() : super(SupplierssInitial());
  String type = "SUPPLY";
  String paymenttype = "cash";
  String supplypart = "materiel";

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
}
