import 'package:flutter/material.dart';

class Customerusageitem extends StatelessWidget {
  final String type;
  final String date;
  final String desc;
  final String total;
  final String sumingaftermotion;
  final String sumstampaftermotion;

  Widget estimate;
  Widget delet;
  final TextStyle textStyle;

  Customerusageitem({
    super.key,
    required this.type,
    required this.estimate,
    required this.textStyle,
    required this.sumingaftermotion,
    required this.sumstampaftermotion,
    required this.desc,
    required this.total,
    required this.delet,
    required this.date,
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
              )),
          Expanded(
              flex: 3,
              child: Text(
                type,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                desc,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                total,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                sumingaftermotion,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                sumstampaftermotion,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
            flex: 2,
            child: estimate,
          ),
          Expanded(
            flex: 2,
            child: delet,
          ),
        ],
      ),
    );
  }
}
