import 'package:agman/features/customers/data/models/clientrequest.dart';
import 'package:agman/features/customers/data/repos/clientsrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/clentmodel/datum.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  final Clientsrepoimp clientsrepoimp;
  CustomersCubit({required this.clientsrepoimp}) : super(CustomersInitial());
  String customeertype = "Customer";
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
  List<Datum> clients = [];
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

  addclient({required Clientrequest client}) async {
    emit(addCustomerloading());
    var result = await clientsrepoimp.addclient(client: client);

    result.fold((failure) {
      emit(addCustomerfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addCustomersuccess(successmessage: success));
    });
  }

  editclient({required Clientrequest client}) async {
    emit(editcustomerloading());
    var result = await clientsrepoimp.editclient(client: client);

    result.fold((failure) {
      emit(editCustomerfailure(errormessage: failure.error_message));
    }, (success) {
      emit(editCustomersuccess(successmessage: success));
    });
  }

  getCustomers() async {
    emit(getCustomersloading());
    var result = await clientsrepoimp.getclients();
    result.fold((failure) {
      emit(getCustomergfailure(errormessage: failure.error_message));
    }, (success) {
      clients.clear();
      success.data!.forEach((e) {
        clients.add(e);
      });
      emit(getCustomerssuccess(successmessage: "تم الحصول علي البيانات بنجاح"));
    });
  }

  deleteclient({required int clientid}) async {
    emit(deleteCustomerloading());
    var result = await clientsrepoimp.deleteclient(
      clientid: clientid,
    );
    result.fold((failure) {
      emit(deleteCustomerfailure(errormessage: failure.error_message));
    }, (success) {
      clients.removeWhere((e) {
        return e.id == clientid;
      });
      emit(deleteCustomersuccess(successmesssage: success));
    });
  }
}
