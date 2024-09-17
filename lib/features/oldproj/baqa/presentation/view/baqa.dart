import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/texts.dart';
import 'package:agman/core/common/widgets/custommaterialbutton.dart';
import 'package:agman/features/oldproj/baqa/presentation/view/widgets/customtextform.dart';
import 'package:flutter/material.dart';

class Baqa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolors.expensecolor,
          centerTitle: true,
          title: Text(
            "اضافة باقه",
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
                      height: 35,
                    ),
                    Image.asset(
                      "assets/images/atm-card.png",
                      height: 100,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    /*    Customtextformincex(
                      suffix: "جيجا",
                      hint: "مساحة الباقه",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Customtextformincex(
                      suffix: "جنيه",
                      hint: "سعر الباقه",
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
        backgroundColor: appcolors.expensecolor,
      ),
    );
  }
}
