import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';

class Customtableordermoves extends StatelessWidget {
  final String date;
  final String quantaity;
  final String shift;
  final String employee;

  final TextStyle textStyle;
  Customtableordermoves({
    super.key,
    required this.shift,
    required this.date,
    required this.textStyle,
    required this.employee,
    required this.quantaity,
  });
  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height / 19),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              date,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
              flex: 3,
              child: Text(
                quantaity,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 2,
              child: Text(
                shift,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                employee,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
