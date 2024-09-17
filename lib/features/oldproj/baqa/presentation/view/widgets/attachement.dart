import 'package:agman/core/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Attachement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.attachment_sharp,
              color: appcolors.lightgrey2,
            )),
        Text(
          "ارفاق ملصق",
          style: TextStyle(
              fontFamily: "alex", fontSize: 15, color: appcolors.lightgrey2),
        ),
      ],
    );
  }
}
