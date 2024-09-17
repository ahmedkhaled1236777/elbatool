import 'package:agman/core/colors/colors.dart';
import 'package:agman/features/oldproj/view/moneycon.dart';
import 'package:flutter/material.dart';

class Incomeexpense extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Moneycon(
            color: appcolors.incomecolor,
            image: "assets/images/Frame 27.png",
            status: "المبلغ المحصل"),
        Moneycon(
            color: appcolors.expensecolor,
            image: "assets/images/Frame 26.png",
            status: "المبلغ المتبقي"),
      ],
    );
  }
}
