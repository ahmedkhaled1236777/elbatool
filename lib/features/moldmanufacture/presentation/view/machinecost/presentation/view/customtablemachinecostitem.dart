import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';

class Customtablemachinecostitem extends StatelessWidget {
  final String machinecostname;
  final String cost;

  Widget delet;
  Widget edit;
  final TextStyle textStyle;

  Customtablemachinecostitem({
    super.key,
    required this.machinecostname,
    required this.textStyle,
    required this.cost,
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
              machinecostname,
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
                cost,
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
