import 'package:flutter/material.dart';

class Customtablewalletitem extends StatelessWidget {
  final String walletname;
  final String salary;
  final String date;
  final Widget delete;
  final TextStyle textStyle;

  Customtablewalletitem(
      {super.key,
      required this.walletname,
      required this.date,
      required this.delete,
      required this.salary,
      required this.textStyle});

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
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 3,
            child: Text(
              walletname,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                salary,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(flex: 2, child: delete),
        ],
      ),
    );
  }
}
