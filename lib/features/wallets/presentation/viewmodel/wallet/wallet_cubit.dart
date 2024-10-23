import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());

  String wallettype = "DELETE";
  changewallettype(String val) {
    wallettype = val;
    emit(changesavestate());
  }
}
