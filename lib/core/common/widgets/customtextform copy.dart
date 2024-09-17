import 'package:agman/core/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customtextformincex extends StatelessWidget {
  String? hint;
  Customtextformincex({this.hint});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextFormField(
                  style: TextStyle(
                      fontFamily: "alex",
                      fontSize: 15,
                      color: appcolors.lightgrey2),
                  decoration: InputDecoration(
                      labelStyle: TextStyle(
                          fontFamily: "alex", color: appcolors.lightgrey2),
                      hintText: hint ?? "الوصف",
                      hintStyle: TextStyle(
                          fontFamily: "alex",
                          fontSize: 15,
                          color: appcolors.lightgrey2),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: appcolors.lightgrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appcolors.lightgrey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: appcolors.lightgrey),
                        borderRadius: BorderRadius.circular(20),
                      )),
                ))));
  }
}
