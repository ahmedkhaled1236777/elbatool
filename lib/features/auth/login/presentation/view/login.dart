import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/texts.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform%20copy%202.dart';
import 'package:agman/features/auth/forgetpass/presentation/view/forgetpass.dart';
import 'package:agman/features/auth/login/presentation/view/signup.dart';
import 'package:agman/features/auth/login/presentation/view/widgets/noaccount.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width > 600
                  ? MediaQuery.sizeOf(context).width * 0.4
                  : double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 60,
                  ),
                  /* Text(
                    "تسجيل الدخول",
                    style:
                        TextStyle(fontFamily: apptexts.appfonfamily, fontSize: 20),
                  ),*/
                  Image.asset(
                    fit: BoxFit.fitHeight,
                    "assets/images/LASTB.png",
                    height: 160,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "تسجيل الدخول",
                      style: TextStyle(
                          fontFamily: apptexts.appfonfamily, fontSize: 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  customtextform(
                      controller: email, hintText: "البريد الالكتروني"),
                  const SizedBox(
                    height: 24,
                  ),
                  customtextform(
                    controller: password,
                    hintText: "كلمة المرور",
                    suffixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.visibility,
                          color: appcolors.lighttext,
                        )),
                  ),
                  const SizedBox(
                    height: 45,
                  ),
                  const custommaterialbutton(button_name: "تسجيل الدخول"),
                  const SizedBox(
                    height: 20,
                  ),
                  /* TextButton(
                      onPressed: () {
                        navigateto(context: context, page: Forgetpass());
                      },
                      child: Text(
                        "نسيت كلمة المرور ؟",
                        style: TextStyle(
                            fontFamily: apptexts.appfonfamily,
                            color: appcolors.maincolors,
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      )),*/
                  const SizedBox(
                    height: 15,
                  ),
                  noaccount(
                      maintext: "لم تمتلك حساب بعد ؟",
                      buttontext: "انشاء حساب",
                      navigated_widget: Signup())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
