import 'package:flutter/material.dart';

class Customtablefactorytoolitem extends StatelessWidget {
  final String factorytoolname;
  final String quantity;
  final String totalbuy;
  final String totalconsume;
  final String totalsell;
  String? firsttime;
  String? lasttime;
  Widget? delet;
  Widget? edit;
  final TextStyle textStyle;

  Customtablefactorytoolitem({
    super.key,
    required this.factorytoolname,
    required this.textStyle,
    required this.totalsell,
    this.firsttime,
    this.lasttime,
    required this.totalconsume,
    required this.totalbuy,
    required this.quantity,
    this.edit,
    this.delet,
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
              factorytoolname,
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
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          Expanded(
            flex: 3,
            child: Text(
              totalconsume,
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
              totalsell,
              style: textStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            width: 3,
          ),
          if (firsttime != null)
            Expanded(
                flex: 3,
                child: Text(
                  firsttime!,
                  style: textStyle,
                  textAlign: TextAlign.center,
                )),
          if (firsttime != null)
            const SizedBox(
              width: 3,
            ),
          if (lasttime != null)
            Expanded(
                flex: 3,
                child: Text(
                  lasttime!,
                  style: textStyle,
                  textAlign: TextAlign.center,
                )),
          if (lasttime != null)
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
          if (this.edit != null)
            Expanded(
              flex: 2,
              child: edit!,
            ),
          if (this.edit != null)
            const SizedBox(
              width: 3,
            ),
          if (this.delet != null)
            Expanded(
              flex: 2,
              child: delet!,
            ),
        ],
      ),
    );
  }
}
