import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';

class customtablsupplieritem extends StatelessWidget {
  final String name;
  final String phone;
  final String place;

  Widget edit;
  Widget delet;
  final TextStyle textStyle;

  customtablsupplieritem({
    super.key,
    required this.phone,
    required this.textStyle,
    required this.place,
    required this.name,
    required this.delet,
    required this.edit,
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
                name,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 3,
              child: Text(
                phone,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
              flex: 2,
              child: Text(
                place,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          Expanded(
            flex: 2,
            child: edit,
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
