import 'package:flutter/material.dart';

class Accessoriesearchitem extends StatelessWidget {
  final String firsttime;
  final String lasttime;
  final String totalbuy;
  final String totalsell;
  final String totalconsume;

  final TextStyle textStyle;

  Accessoriesearchitem({
    super.key,
    required this.textStyle,
    required this.totalsell,
    required this.firsttime,
    required this.lasttime,
    required this.totalconsume,
    required this.totalbuy,
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
              firsttime,
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
              totalbuy,
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
              totalconsume,
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
              totalsell,
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
              lasttime,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
