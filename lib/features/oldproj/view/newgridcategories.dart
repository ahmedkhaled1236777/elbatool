import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/features/splash/splash.dart';
import 'package:agman/features/oldproj/view/appbarhome.dart';
import 'package:agman/features/oldproj/view/gridcard.dart';
import 'package:agman/features/oldproj/view/incomeexpense.dart';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class newgridcategories extends StatefulWidget {
  List<Map> grid = [
    {
      "name": "العملاء",
      "image": "assets/images/division.png",
      "screen": LogoAnimationScreen()
    },
    {
      "name": "المجموعات",
      "image": "assets/images/manager.png",
      "screen": LogoAnimationScreen()
    },
    {
      "name": "الباقات",
      "image": "assets/images/atm-card.png",
      "screen": LogoAnimationScreen()
    },
  ];
  @override
  State<newgridcategories> createState() => _newgridcategoriesState();
}

class _newgridcategoriesState extends State<newgridcategories> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 65,
            ),
            Appbarhome(),
            SizedBox(
              height: 17,
            ),
            Incomeexpense(),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: AnimationLimiter(
                        child: GridView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.all(0),
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  childAspectRatio: 3 / 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5),
                          children: List.generate(
                              widget.grid.length,
                              (index) => AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 600),
                                  columnCount: 2,
                                  child: SlideAnimation(
                                      delay: Duration(milliseconds: 300),
                                      child: FlipAnimation(
                                          child: gridcard(
                                        name: widget.grid[index]["name"],
                                        image: widget.grid[index]["image"],
                                        screen: widget.grid[index]["screen"],
                                      ))))),
                        ),
                      ))
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class mypath extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double h = size.height;
    double w = size.width;
    final path_0 = Path();
    path_0.lineTo(0, h);
    path_0.quadraticBezierTo(0, h * 0.7, w * 0.15, h * 0.7);
    path_0.lineTo(w * 0.8, h * 0.7);
    path_0.quadraticBezierTo(w, h * 0.7, w, h * 0.5);
    path_0.lineTo(w, h * 0);
    path_0.close();
    // path_0.moveTo(size.width*1.0044365,size.height*0.0020000);
    //path_0.lineTo(size.width*0,size.height*0);
    //path_0.quadraticBezierTo(size.width*0.0013334,size.height*0.2698571,size.width*0.0013334,size.height*0.3591429);
    //path_0.cubicTo(size.width*0.2574874,size.height*-0.0827857,size.width*0.4856246,size.height*0.4962143,size.width*1.0019350,size.height*0.3605714);
    //path_0.quadraticBezierTo(size.width*1.0025604,size.height*0.2709286,size.width*1.0044365,size.height*0.0020000);
    // path_0.close();

    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
