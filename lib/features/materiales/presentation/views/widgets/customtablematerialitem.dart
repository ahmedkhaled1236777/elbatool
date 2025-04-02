import 'package:flutter/material.dart';

class Customtablematerialitem extends StatelessWidget {
  final String materialname;
  final String quantity;
  final String datefrom;
  final String dateto;
  final TextStyle textStyle;
  Widget delet;
  Widget edit;

  Customtablematerialitem({
    super.key,
    required this.textStyle,
    required this.materialname,
    required this.quantity,
    required this.datefrom,
    required this.dateto,
    required this.edit,
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
              materialname,
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
                datefrom,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                dateto,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                quantity,
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 2,
            child: edit,
          ),
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
