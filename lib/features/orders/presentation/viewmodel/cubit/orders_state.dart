part of 'orders_cubit.dart';

abstract class OrdersState {}

class OrdersInitial extends OrdersState {}

class getordermovesloading extends OrdersState {}

class getordermovessuccess extends OrdersState {
  final String successmessage;

  getordermovessuccess({required this.successmessage});
}

class getordermovesfailure extends OrdersState {
  final String errormessage;

  getordermovesfailure({required this.errormessage});
}

class changeorderstste extends OrdersState {}

class AddOrdersLoading extends OrdersState {}

class DeleteOrdersLoading extends OrdersState {}

class DeleteOrderSuccess extends OrdersState {
  final String successmessage;

  DeleteOrderSuccess({required this.successmessage});
}

class DeleteOrdersFailure extends OrdersState {
  final String errormessage;

  DeleteOrdersFailure({required this.errormessage});
}

class GetOrdersLoading extends OrdersState {}

class GetOrdersSuccess extends OrdersState {
  final String successmessage;

  GetOrdersSuccess({required this.successmessage});
}

class GetOrdersFailure extends OrdersState {
  final String errormessage;

  GetOrdersFailure({required this.errormessage});
}

class AddOrdersSuccess extends OrdersState {
  final String successmessage;

  AddOrdersSuccess({required this.successmessage});
}

class AddOrdersFailure extends OrdersState {
  final String errorrmessage;

  AddOrdersFailure({required this.errorrmessage});
}
