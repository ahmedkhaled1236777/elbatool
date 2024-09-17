import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Toaststate { succes, error, other }

showtoast({required String message, required Toaststate toaststate}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: toaststate == Toaststate.error
          ? Colors.red
          : toaststate == Toaststate.succes
              ? appcolors.maincolor
              : Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0);
}
