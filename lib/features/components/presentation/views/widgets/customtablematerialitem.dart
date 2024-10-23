import 'package:agman/core/colors/colors.dart';
import 'package:flutter/material.dart';

class Customtablecomponentitem extends StatelessWidget {
  final String componentname;
  final String quantity;

  Widget delet;
  Widget edit;
  final TextStyle textStyle;

  Customtablecomponentitem({
    super.key,
    required this.componentname,
    required this.textStyle,
    required this.quantity,
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
              componentname,
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
