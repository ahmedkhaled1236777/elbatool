import 'package:agman/core/common/navigation.dart';
import 'package:agman/features/auth/login/presentation/view/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LogoAnimationScreen extends StatefulWidget {
  const LogoAnimationScreen();

  @override
  LogoAnimationScreenState createState() => LogoAnimationScreenState();
}

class LogoAnimationScreenState extends State<LogoAnimationScreen> {
  int align = 0;
  bool showtext = false;

  @override
  void initState() {
    Future.delayed(Duration(microseconds: 1500), () {
      setState(() {
        showtext = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 18,
          ),
          AnimatedOpacity(
            onEnd: () async {
              navigateto(context: context, page: Login());
            },
            opacity: showtext ? 1.0 : 0.0,
            duration: const Duration(seconds: 1),
            child: Container(
                child: Image.asset(
              "assets/images/result.png",
              width: 300,
              height: 300,
            )),
          ),
        ],
      ),
    ));
  }
}
