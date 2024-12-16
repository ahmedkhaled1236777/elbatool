import 'package:bloc/bloc.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit() : super(CustomersInitial());
  String customeertype = "INJECTION";
  String type = "MANUFACTURE";
  String paymenttype = "cash";
  String paymenttypesec = "inj";
  List<bool> injchecks = [
    true,
    true,
    true,
    true,
    true,
  ];
  List<bool> moldchecks = [
    true,
    true,
    true,
    true,
    true,
  ];
  changechecbox(
      {required bool val, required int index, required String pagename}) {
    if (pagename == "mold")
      moldchecks[index] = val;
    else
      injchecks[index] = val;

    emit(changechecboxstate());
  }

  changetcustomerype({required String value}) {
    customeertype = value;
    emit(CustomersChangeType());
  }

  changepaymenttypepay({required String value}) {
    paymenttypesec = value;
    emit(CustomersChangeType());
  }

  changetype({required String value}) {
    type = value;
    emit(ChangeTypeState());
  }

  changepaymenttype({required String value}) {
    paymenttype = value;
    emit(changepaymentState());
  }
}
