import 'package:internet_connection_checker/internet_connection_checker.dart';

class Checkconnection {
  static Checkmyconnection() async {
    bool isConnected = await InternetConnectionChecker().hasConnection;

    if (isConnected) {
      return true;
    } else {
      return false;
    }
  }
}
