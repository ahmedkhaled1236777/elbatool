import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';

class Customtablemolditem extends StatelessWidget {
  final String mold;
  final double time;
  final String weight;
  final String numberofpieces;

  final Widget edit;
  final Widget delete;

  final TextStyle textStyle;

  Customtablemolditem(
      {super.key,
      required this.mold,
      required this.time,
      required this.textStyle,
      required this.weight,
      required this.numberofpieces,
      required this.edit,
      required this.delete});

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
              mold,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 2,
            child: Text(
              numberofpieces,
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
                time.toString(),
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(
              flex: 3,
              child: Text(
                weight.toString(),
                style: textStyle,
                textAlign: TextAlign.center,
              )),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: edit),
          const SizedBox(
            width: 3,
          ),
          Expanded(flex: 2, child: delete),
        ],
      ),
    );
  }
}
