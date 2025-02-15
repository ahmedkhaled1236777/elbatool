import 'package:agman/features/clients/data/models/clientmoverequest/clientmoverequest.dart';
import 'package:agman/features/clients/data/models/clientmovesmodel/datum.dart';
import 'package:agman/features/clients/data/models/clientrequest.dart';
import 'package:agman/features/clients/data/repos/clientsrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/clientmodel/datum.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  final Clientsrepoimp clientsrepoimp;
  CustomersCubit({required this.clientsrepoimp}) : super(CustomersInitial());
  String customeertype = "Customer";
  String type = "MANUFACTURE";
  String paymenttype = "cash";
  String paymenttypesec = "inj";
  List<Datum> data = [];
  List<bool> checks = [];

  List<Datummove> mymoves = [];
  bool loading = false;

  int page = 1;
  bool firstloading = false;
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
  changecheckbox(bool val, int i) {
    checks[i] = val;
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

  addclientmove({required Clientmoverequest clientmove}) async {
    emit(addclientmoveloading());
    var result = await clientsrepoimp.addclientmove(Clientmovere: clientmove);

    result.fold((failure) {
      emit(addclientmovefailure(errormessage: failure.error_message));
    }, (success) {
      emit(addclientmovesuccess(successmessage: success));
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

  deleteclientmove({required int moveid}) async {
    emit(deleteCustomerloading());
    var result = await clientsrepoimp.deleteclientmove(
      moveid: moveid,
    );
    result.fold((failure) {
      emit(deleteclientmovefailure(errormessage: failure.error_message));
    }, (success) {
      /*  clients.removeWhere((e) {
        return e.id == clientid;
      });*/
      emit(deleteclientmovesuccess(successmessage: success));
    });
  }

  getclientmoves({required int client_id, String? status, String? date}) async {
    if (firstloading == false) emit(getclientmovesloading());
    this.page = 1;

    var result = await clientsrepoimp.getclientmoves(
        page: page, clientid: client_id, status: status, date: date);
    loading = true;
    result.fold((failue) {
      emit(getclientmovesfailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        loading = false;
      }
      mymoves.clear();
      checks.clear();

      firstloading = true;
      success.data!.forEach((e) {
        mymoves.add(e);
        checks.add(false);
      });

      emit(getclientmovessuccess(successmessage: ""));
    });
  }

  getamoreclientmoves(
      {required int client_id, String? status, String? date}) async {
    page++;
    var result = await clientsrepoimp.getclientmoves(
        page: page, clientid: client_id, date: date, status: status);
    loading = true;
    result.fold((failue) {
      emit(getclientmovesfailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        loading = false;
      }
      success.data!.forEach((e) {
        mymoves.add(e);
        checks.add(false);
      });
      emit(getclientmovessuccess(successmessage: ""));
    });
  }
}
