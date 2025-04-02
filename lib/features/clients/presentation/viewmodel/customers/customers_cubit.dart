import 'package:agman/features/clients/data/models/clientmodelrequestmotion.dart';
import 'package:agman/features/clients/data/models/clientmovesmodel/datum.dart';
import 'package:agman/features/clients/data/models/clientrequest.dart';
import 'package:agman/features/clients/data/repos/clientsrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/clientmodel/datum.dart';

part 'customers_state.dart';

class CustomersCubit extends Cubit<CustomersState> {
  final Clientsrepoimp clientsrepoimp;
  CustomersCubit({required this.clientsrepoimp}) : super(CustomersInitial());
  String moneytype = "7aan";
  String type = "7aan";
  String paymenttype = "cash";
  String searchtype = "اختر مجال البحث";
  List<String> searchtypes = [
    "حقن",
    "اسطمبات",
    "مرتجع وحقن",
    "صيانه",
    "نقدي",
    "تحويل"
  ];
  Map<String, String> searchtypemap = {
    "حقن": "7aan",
    "نقدي": "naqdi",
    "تحويل": "ta7weel",
    "اسطمبات": "stampa",
    "صيانه": "stampasyana",
    "مرتجع وحقن": "7aanback",
  };
  String paymenttypesec = "inj";
  List<Datum> data = [];
  List<bool> checks = [];

  List<Datummove> mymoves = [];
  bool loading = false;

  int page = 1;
  bool firstloading = false;
  List total = [];
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
  Map<String, dynamic> queryparms = {};
  List<Datum> clients = [];
  changecheckbox(bool val, int i) {
    checks[i] = val;
    emit(changechecboxstate());
  }

  changemonetytype({required String value}) {
    moneytype = value;
    emit(CustomersChangeType());
  }

  changesearchtype({required String value}) {
    searchtype = value;
    emit(searchtypechange());
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

  addclientmove({required clientmoverequest clientmove}) async {
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

  getCustomers({Map<String, dynamic>? parms}) async {
    emit(getCustomersloading());
    var result = await clientsrepoimp.getclients(queryparms: parms);
    result.fold((failure) {
      emit(getCustomergfailure(errormessage: failure.error_message));
    }, (success) {
      clients.clear();
      total.clear();
      success.data!.forEach((e) {
        clients.add(e);
        total.add(e.total7aan + e.totalStamba);
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
      mymoves.removeWhere((e) {
        return e.id == clientid;
      });
      emit(deleteCustomersuccess(successmesssage: success));
    });
  }

  deleteclientmove({required int moveid}) async {
    emit(deleteclientmoveloading());
    var result = await clientsrepoimp.deleteclientmove(
      moveid: moveid,
    );
    result.fold((failure) {
      emit(deleteclientmovefailure(errormessage: failure.error_message));
    }, (success) {
      mymoves.removeWhere((e) {
        return e.id == moveid;
      });
      emit(deleteclientmovesuccess(successmessage: success));
    });
  }

  getclientmoves() async {
    if (firstloading == false) emit(getclientmovesloading());
    this.page = 1;

    var result = await clientsrepoimp.getclientmoves(
      queryparms: queryparms,
      page: page,
    );
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

  getamoreclientmoves() async {
    page++;
    var result =
        await clientsrepoimp.getclientmoves(page: page, queryparms: queryparms);
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
