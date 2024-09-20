import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';

class customtableproductionsitem extends StatelessWidget {
  final String worker;
  final String machinenumber;
  final String productname;
  final String productquantity;

  Widget delet;
  TextStyle textStyle =
      TextStyle(fontSize: 12, fontFamily: "cairo", color: appcolors.maincolor);

  customtableproductionsitem({
    super.key,
    required this.worker,
    required this.machinenumber,
    required this.productname,
    required this.productquantity,
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
              machinenumber,
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
                worker,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                productname,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                productquantity,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
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
