import 'dart:ffi';

import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/texts.dart';
import 'package:agman/core/common/widgets/custommaterialbutton.dart';
import 'package:agman/features/oldproj/baqa/presentation/view/widgets/customtextform.dart';
import 'package:agman/features/oldproj/baqa/presentation/view/widgets/dropdown.dart';
import 'package:flutter/material.dart';

class Addemployee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolors.incomecolor,
          centerTitle: true,
          title: Text(
            "اضافة عميل",
            style: TextStyle(
                fontFamily: apptexts.appfonfamily, color: Colors.white),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
                child: Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Image.asset(
                      "assets/images/division.png",
                      height: 100,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    /* Customtextformincex(
                      hint: "الاسم",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Customtextformincex(
                      hint: "رقم التواصل",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Customtextformincex(
                      hint: "رقم الواتس",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Dropdownapp(
                      array: ["11", "12"],
                      hint: "اختر المجموعه",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Dropdownapp(
                      array: ["11", "12"],
                      hint: "اختر الباقه",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Customtextformincex(
                      suffix: "جنيه",
                      hint: "المبلغ المدفوع",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 15,
                    ),*/
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: custommaterialbutton(button_name: "تاكيد"),
                    )
                  ],
                ),
              ),
            ))
          ],
        ),
        backgroundColor: appcolors.incomecolor,
      ),
    );
  }
}
