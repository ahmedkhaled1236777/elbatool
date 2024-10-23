import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  CustomersCubit() : super(CustomersInitial());
  String customeertype = "INJECTION";
  String type = "MANUFACTURE";
  String paymenttype = "cash";

  changetcustomerype({required String value}) {
    customeertype = value;
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
