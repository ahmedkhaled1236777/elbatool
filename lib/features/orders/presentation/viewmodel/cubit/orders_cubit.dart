import 'package:agman/features/orders/data/models/ordermodel/content.dart';
import 'package:agman/features/orders/data/models/ordermodelrequest.dart';
import 'package:agman/features/orders/data/repos/orderrepoimp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final orderrepoimp orderrepo;
  int page = 1;
  bool loading = false;
  List<Content> data = [];
  bool firstloading = false;
  Map<String, dynamic>? queryparms;
  OrdersCubit(this.orderrepo) : super(OrdersInitial());
  addorder({required Ordermodelrequest order}) async {
    emit(AddOrdersLoading());
    var result = await orderrepo.addorder(orderrequest: order);
    result.fold((failure) {
      emit(AddOrdersFailure(errorrmessage: failure.error_message));
    }, (success) {
      emit(AddOrdersSuccess(successmessage: success));
    });
  }

  getorders({required int page}) async {
    if (firstloading == false) emit(GetOrdersLoading());
    this.page = 1;
    var result = await orderrepo.getorders(page: page, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(GetOrdersFailure(errormessage: failue.error_message));
    }, (success) {
      if (success.data!.pagination!.links!.next == null) {
        loading = false;
      }
      data.clear();
      firstloading = true;
      data.addAll(success.data!.content!);
      emit(GetOrdersSuccess(successmessage: ""));
    });
  }

  getamoreorders() async {
    page++;
    var result = await orderrepo.getorders(page: page, queryparms: queryparms);
    loading = true;
    result.fold((failue) {
      emit(GetOrdersFailure(errormessage: failue.error_message));
    }, (success) {
      if (success.data!.pagination!.links!.next == null) {
        loading = false;
      }
      data.addAll(success.data!.content!);
      emit(GetOrdersSuccess(successmessage: ""));
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
