import 'package:agman/features/wallets/data/model/walletmodel/datum.dart';
import 'package:agman/features/wallets/data/model/walletmodelrequest.dart';
import 'package:agman/features/wallets/data/model/walletmotionmodel.dart';
import 'package:agman/features/wallets/data/model/walletmotionmodel/datum.dart';
import 'package:agman/features/wallets/data/repos/walletrepoimp.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<walletState> {
  WalletCubit(this.walletrepoimp) : super(WalletInitial());

  int wallettype = 0;
  int motionpage = 1;
  Map<String, dynamic>? queryparms;
  bool motionloading = false;

  bool firstloadingmotion = false;
  changewallettype(int val) {
    wallettype = val;
    emit(changewalletstate());
  }

  final Walletrepoimp walletrepoimp;
  List<Datum> data = [];
  List<Datumwalletmotion> datamotions = [];

  addwallet({required Walletmodelrequest wallet}) async {
    emit(addwalletloading());
    var result = await walletrepoimp.addwallet(wallet: wallet);
    result.fold((failure) {
      emit(addwalletfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addwalletsuccess(successmessage: success));
    });
  }

  addwalletmotion({required Walletmotionmodelrequest wallet}) async {
    emit(addwalletmotionloading());
    var result = await walletrepoimp.addwalletmotion(wallet: wallet);
    result.fold((failure) {
      emit(addwalletmotionfailure(errormessage: failure.error_message));
    }, (success) {
      emit(addwalletmotionsuccess(successmessage: success));
    });
  }

  deletewallet({
    required int walletid,
  }) async {
    emit(deletewalletloading());
    var result = await walletrepoimp.deletewallet(walletid: walletid);
    result.fold((failure) {
      emit(deletewalletfailure(errormessage: failure.error_message));
    }, (success) {
      data.removeWhere((e) {
        return e.id == walletid;
      });
      emit(deletewalletsuccess(successmessage: success));
    });
  }

  deletewalletmotion({
    required int walletmotionid,
  }) async {
    emit(deletewalletmotionloading());
    var result =
        await walletrepoimp.deletewalletmotion(walletmotionid: walletmotionid);
    result.fold((failure) {
      emit(deletewalletmotionfailure(errormessage: failure.error_message));
    }, (success) {
      datamotions.removeWhere((e) {
        return e.id == walletmotionid;
      });
      emit(deletewalletmotionsuccess(successmessage: success));
    });
  }

  getwallets({Map<String, dynamic>? queryparms}) async {
    emit(getwalletloading());
    var result = await walletrepoimp.getwallet();
    result.fold((failue) {
      emit(getwalletfailure(errormessage: failue.error_message));
    }, (success) {
      data = success.data!;

      emit(getwalletsuccess(successmessage: ""));
    });
  }

  getwalletsmotion({required int walletid}) async {
    if (firstloadingmotion == false) emit(getwalletmotionloading());
    this.motionpage = 1;
    var result = await walletrepoimp.getwalletmotion(
        page: motionpage, walletid: walletid);
    motionloading = true;
    result.fold((failue) {
      emit(getwalletmotionfailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        motionloading = false;
      }
      datamotions.clear();

      success.data!.forEach((e) {
        datamotions.add(e);
      });

      emit(getwalletmotionsuccess(successmessage: ""));
    });
  }

  getmorewalletmotion({required int walletid}) async {
    motionpage++;
    var result = await walletrepoimp.getwalletmotion(
        page: motionpage, walletid: walletid);
    motionloading = true;
    result.fold((failue) {
      motionloading = false;

      emit(getwalletmotionfailure(errormessage: failue.error_message));
    }, (success) {
      if (success.nextPageUrl == null) {
        motionloading = false;
      }
      success.data!.forEach((e) {
        datamotions.add(e);
      });
      emit(getwalletmotionsuccess(successmessage: ""));
    });
  }
}
