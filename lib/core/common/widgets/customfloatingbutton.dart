import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';

class customfloatingbutton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: appcolors.primarycolor,
      onPressed: () {},
      child: Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
