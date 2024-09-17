import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Customtextformincex extends StatelessWidget {
  String? hint;
  String? suffix;
  final TextEditingController controller;
  String? valid;
  Customtextformincex(
      {this.hint, this.suffix, required this.controller, this.valid});
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
                  controller: controller,
                  validator: (value) {
                    if (value == null) return valid;
                  },
                  style: TextStyle(
                      fontFamily: apptexts.appfonfamily,
                      fontSize: 15,
                      color: Colors.black),
                  decoration: InputDecoration(
                      suffix: Text(suffix ?? ""),
                      labelStyle: TextStyle(
                          fontFamily: apptexts.appfonfamily,
                          color: Colors.black),
                      hintText: hint ?? "الوصف",
                      hintStyle: TextStyle(
                          fontFamily: apptexts.appfonfamily,
                          fontSize: 15,
                          color: Colors.black),
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
