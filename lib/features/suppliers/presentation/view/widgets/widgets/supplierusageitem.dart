import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class supplierusageitem extends StatelessWidget {
  final String type;
  final String date;
  final String quantity;
  final String desc;
  final String pieceprice;
  final String total;

  Widget delet;
  final TextStyle textStyle;

  supplierusageitem({
    super.key,
    required this.type,
    required this.textStyle,
    required this.pieceprice,
    required this.desc,
    required this.quantity,
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
                quantity,
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
                pieceprice,
                style: textStyle,
                textAlign: TextAlign.center,
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
