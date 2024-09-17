import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Dropdownapp extends StatefulWidget {
  List<String> array;
  String? valx;
  String hint;
  final void Function(String?)? onChanged;
  Dropdownapp(
      {required this.hint,
      required this.array,
      required this.onChanged,
      this.valx});

  @override
  State<Dropdownapp> createState() => _DropdownappState();
}

class _DropdownappState extends State<Dropdownapp> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: appcolors.lightgrey)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButton(
              style: TextStyle(
                  fontFamily: apptexts.appfonfamily, color: Colors.black),
              alignment: Alignment.centerRight,
              isExpanded: true,
              underline: Text(""),
              hint: Text(
                style: TextStyle(
                    fontFamily: apptexts.appfonfamily, color: Colors.black),
                widget.hint,
                textAlign: TextAlign.right,
              ),
              icon: Image.asset(
                "assets/images/arrow.png",
                width: 15,
                height: 15,
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              value: widget.valx,
              items: widget.array
                  .map(
                    (e) => DropdownMenuItem(
                      alignment: Alignment.center,
                      value: e,
                      child: Align(
                        child: Container(
                          width: double.infinity,
                          child: Center(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              e,
                              style: TextStyle(
                                  fontFamily: apptexts.appfonfamily,
                                  color: Colors.black),
                            ),
                          )),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: widget.onChanged),
        ),
      ),
    ));
  }
}
