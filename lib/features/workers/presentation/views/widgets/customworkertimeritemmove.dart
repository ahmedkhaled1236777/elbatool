import 'package:flutter/material.dart';

class Customworkermovesitem extends StatelessWidget {
  final String date;
  final String chexkin;
  final String checkout;
  final Widget edit;

  final TextStyle textStyle;

  const Customworkermovesitem(
      {super.key,
      required this.date,
      required this.edit,
      required this.checkout,
      required this.chexkin,
      required this.textStyle});

  // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 19,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              date,
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
              chexkin,
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
              checkout,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: edit,
            flex: 2,
          )
        ],
      ),
    );
  }
}
