import 'package:flutter/material.dart';

class Customtablegarditem extends StatelessWidget {
  final String toolname;
  final String totalbuy;
  final String totalconsume;

  final TextStyle textStyle;

  Customtablegarditem({
    super.key,
    required this.toolname,
    required this.textStyle,
    required this.totalbuy,
    required this.totalconsume,
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
              toolname,
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
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                totalconsume,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
        ],
      ),
    );
  }
}
