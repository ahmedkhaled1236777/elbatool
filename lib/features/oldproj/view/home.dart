import 'dart:math';

import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/icons.dart';
import 'package:agman/features/oldproj/view/drawer.dart';
import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  @override
  void initState() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CircularMenu(
      backgroundWidget: drawer(),
      toggleButtonBoxShadow: [
        BoxShadow(color: appcolors.maincolor),
        BoxShadow(color: appcolors.maincolor),
        BoxShadow(color: appcolors.maincolor),
      ],
      alignment: Alignment.bottomCenter,
      toggleButtonColor: appcolors.maincolor,
      toggleButtonPadding: 2,
      toggleButtonSize: 40,
      toggleButtonMargin: 42,
      startingAngleInRadian: 1.2 * pi,
      endingAngleInRadian: 1.8 * pi,
      items: [
        CircularMenuItem(
            margin: 0,
            padding: 10,
            icon: MyFlutterApp.result,
            color: appcolors.incomecolor,
            onTap: () {}),
        CircularMenuItem(
            margin: 0,
            icon: MyFlutterApp.result,
            color: Colors.blue,
            onTap: () {
              setState(() {});
            }),
        CircularMenuItem(
            margin: 0,
            icon: MyFlutterApp.result,
            color: appcolors.expensecolor,
            onTap: () {}),
      ],
    ));
  }
}
