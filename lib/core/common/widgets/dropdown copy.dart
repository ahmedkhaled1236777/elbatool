import 'package:agman/core/colors/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Dropdownapp extends StatefulWidget {
  List<Map<String, String>> descs = [
    {"name": "سحب أموال", "image": "assets/images/app/cash-withdrawal.png"},
    {"name": "تحويل أموال", "image": "assets/images/app/transactions.png"},
    {"name": "الفواتير", "image": "assets/images/app/bills.png"},
    {"name": "التعليم", "image": "assets/images/app/education.png"},
    {"name": "الترفيه", "image": "assets/images/app/popcorn.png"},
    {"name": "العائله", "image": "assets/images/app/family.png"},
    {"name": "الاشتراكات والرسوم", "image": "assets/images/app/subscribe.png"},
    {"name": "الطعام", "image": "assets/images/app/food.png"},
    {"name": "التبرعات", "image": "assets/images/app/donation.png"},
    {"name": "الهدايا", "image": "assets/images/app/gifts.png"},
    {"name": "الصحه", "image": "assets/images/app/health.png"},
    {"name": "التأمينات", "image": "assets/images/app/insurance.png"},
    {"name": "الاستثمار", "image": "assets/images/app/investement.png"},
    {"name": "التسوق", "image": "assets/images/app/shopping.png"},
    {"name": "السفر والسياحه", "image": "assets/images/app/travelling.png"},
    {"name": "النقل", "image": "assets/images/app/transport.png"},
  ];
  String? valx;

  @override
  State<Dropdownapp> createState() => _DropdownappState();
}

class _DropdownappState extends State<Dropdownapp> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: appcolors.lightgrey)),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: DropdownButton(
              style: TextStyle(fontFamily: "alex", color: appcolors.lightgrey),
              alignment: Alignment.centerRight,
              isExpanded: true,
              underline: Text(""),
              hint: Text(
                style:
                    TextStyle(fontFamily: "alex", color: appcolors.lightgrey2),
                "اختر المجموعه",
                textAlign: TextAlign.right,
              ),
              icon: Image.asset(
                "assets/images/app/arrow.png",
                width: 15,
                height: 15,
              ),
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              value: widget.valx,
              items: widget.descs
                  .map(
                    (e) => DropdownMenuItem(
                      alignment: Alignment.center,
                      value: e["name"],
                      child: Align(
                        child: Container(
                          width: double.infinity,
                          child: Center(
                              child: Align(
                            alignment: Alignment.centerRight,
                            child: ListTile(
                              style: ListTileStyle.drawer,
                              title: Text(
                                e["name"]!,
                                style: TextStyle(
                                    fontFamily: "alex",
                                    color: appcolors.lightgrey2),
                              ),
                              leading: Image.asset(e["image"]!,
                                  height: 20, width: 20),
                            ),
                          )),
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (val) {
                widget.valx = val!;
                setState(() {});
              }),
        ),
      ),
    ));
  }
}
