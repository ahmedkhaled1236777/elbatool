part of 'wallet_cubit.dart';

abstract class walletState {}

class WalletInitial extends walletState {}

class changewalletstate extends walletState {}

class addwalletloading extends walletState {}

class addwalletsuccess extends walletState {
  final String successmessage;

  addwalletsuccess({required this.successmessage});
}

class addwalletfailure extends walletState {
  final String errormessage;

  addwalletfailure({required this.errormessage});
}

class addwalletmotionloading extends walletState {}

class addwalletmotionsuccess extends walletState {
  final String successmessage;

  addwalletmotionsuccess({required this.successmessage});
}

class addwalletmotionfailure extends walletState {
  final String errormessage;

  addwalletmotionfailure({required this.errormessage});
}

class getwalletloading extends walletState {}

class getwalletsuccess extends walletState {
  final String successmessage;

  getwalletsuccess({required this.successmessage});
}

class getwalletfailure extends walletState {
  final String errormessage;

  getwalletfailure({required this.errormessage});
}

class deletewalletloading extends walletState {}

class deletewalletsuccess extends walletState {
  final String successmessage;

  deletewalletsuccess({required this.successmessage});
}

class deletewalletfailure extends walletState {
  final String errormessage;

  deletewalletfailure({required this.errormessage});
}

class getwalletmotionloading extends walletState {}

class getwalletmotionsuccess extends walletState {
  final String successmessage;

  getwalletmotionsuccess({required this.successmessage});
}

class getwalletmotionfailure extends walletState {
  final String errormessage;

  getwalletmotionfailure({required this.errormessage});
}

class deletewalletmotionloading extends walletState {}

class deletewalletmotionsuccess extends walletState {
  final String successmessage;

  deletewalletmotionsuccess({required this.successmessage});
}

class deletewalletmotionfailure extends walletState {
  final String errormessage;

  deletewalletmotionfailure({required this.errormessage});
}
