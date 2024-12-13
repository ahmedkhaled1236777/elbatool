import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';

class customtableinjectionshallitem extends StatelessWidget {
  final String date;
  final String name;
  final String quantaity;
  final String ordernumber;
  final bool status;

  Widget delet;
  final TextStyle textStyle;
  customtableinjectionshallitem({
    super.key,
    required this.status,
    required this.date,
    required this.textStyle,
    required this.name,
    required this.ordernumber,
    required this.quantaity,
    required this.delet,
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
                name,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                ordernumber,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                quantaity,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 2,
              child: CircleAvatar(
                radius: 5,
                backgroundColor: status ? Colors.black : Colors.green,
              )),
          Expanded(
            flex: 2,
            child: delet,
          ),
        ],
      ),
    );
  }
}
