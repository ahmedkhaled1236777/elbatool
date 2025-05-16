import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';

class Customtablepermessionitem extends StatelessWidget {
  final String date;
  final String hours;
  final String status;
  final String notes;
  Widget delete;

  TextStyle textStyle = TextStyle(
    fontSize: 12,
    fontFamily: "cairo",
    color: appcolors.maincolor,
  );

  Customtablepermessionitem({
    super.key,
    required this.date,
    required this.notes,
    required this.status,
    required this.hours,
    required this.delete,
  });

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 19,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(date, style: textStyle, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 2,
            child: Text(status, style: textStyle, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 3,
            child: Text(hours, style: textStyle, textAlign: TextAlign.center),
          ),
          Expanded(
            flex: 3,
            child: Text(notes, style: textStyle, textAlign: TextAlign.center),
          ),
          Expanded(flex: 2, child: delete),
        ],
      ),
    );
  }
}
