import 'package:agman/features/oldproj/view/menudraer.dart';
import 'package:agman/features/oldproj/view/newgridcategories.dart';

import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class drawer extends StatelessWidget {
  ZoomDrawerController awesomeDrawerBarController = ZoomDrawerController();

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      isRtl: true,
      clipMainScreen: false,
      style: DrawerStyle.style3,
      controller: awesomeDrawerBarController,
      menuBackgroundColor: Colors.white,
      mainScreenTapClose: true,
      openCurve: Curves.bounceInOut,
      menuScreen: menudrawer(),
      mainScreen: newgridcategories(),
      borderRadius: 24.0,
      showShadow: false,
      angle: 0,
      drawerShadowsBackgroundColor: Colors.grey,
      slideWidth: MediaQuery.of(context).size.width * 0.7,
    );
  }
}
