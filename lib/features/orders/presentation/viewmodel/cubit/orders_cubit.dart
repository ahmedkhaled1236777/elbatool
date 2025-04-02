import 'package:agman/features/orders/data/models/ordermodelrequest.dart';
import 'package:agman/features/orders/data/models/ordermoves/datum.dart';
import 'package:agman/features/orders/data/repos/orderrepoimp.dart';
import 'package:bloc/bloc.dart';

import '../../../data/models/ordermodel/datum.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final orderrepoimp orderrepo;
  int page = 1;
  bool loading = false;
  List<Datum> data = [];
  List<Datummoves> datamoves = [];
  List<String> orders = [];
  Map<String, Map> orderid = {};
  Map<String, String> ordermold = {};

  bool firstloading = false;
  Map<String, dynamic>? queryparms;
  String ordername = "اختر الاوردر";

  OrdersCubit(this.orderrepo) : super(OrdersInitial());
  changeorder(String value) {
    ordername = value;
    emit(changeorderstste());
  }

  resetorder() {
    ordername = "اختر الاوردر";
    ;
    emit(changeorderstste());
  }

  addorder({required Ordermodelrequest order}) async {
    emit(AddOrdersLoading());
    var result = await orderrepo.addorder(orderrequest: order);
    result.fold((failure) {
      emit(AddOrdersFailure(errorrmessage: failure.error_message));
    }, (success) {
      emit(AddOrdersSuccess(successmessage: success));
    });
  }

  getorders() async {
    if (firstloading == false) emit(GetOrdersLoading());
    var result = await orderrepo.getorders(queryparms: queryparms);
    result.fold((failue) {
      emit(GetOrdersFailure(errormessage: failue.error_message));
    }, (success) {
      orders.clear();
      data.clear();
      success.data!.forEach((e) {
        data.add(e);
        orders.add("${e.orderNum}-${e.stampName}");
        ordermold.addAll({"${e.orderNum}-${e.stampName}": e.stampName!});
        orderid.addAll({
          "${e.orderNum}-${e.stampName}": {
            "id": e.id,
            "color": e.colorName,
            "mold": e.stampId
          }
        });
      });
      emit(GetOrdersSuccess(successmessage: ""));
    });
  }

  getordersmoves({required int id}) async {
    emit(getordermovesloading());
    var result = await orderrepo.getmoves(orderid: id);
    result.fold((failue) {
      emit(getordermovesfailure(errormessage: failue.error_message));
    }, (success) {
      datamoves.clear();

      success.data!.forEach((e) {
        datamoves.add(e);
      });
      emit(getordermovessuccess(successmessage: ""));
    });
  }

  deleteorder({required int orderid}) async {
    emit(DeleteOrdersLoading());
    var result = await orderrepo.deleteorder(
      orderid: orderid,
    );
    result.fold((failure) {
      emit(DeleteOrdersFailure(errormessage: failure.error_message));
    }, (success) {
      data.removeWhere((e) {
        return e.id == orderid;
      });
      emit(DeleteOrderSuccess(successmessage: success));
    });
  }
}
