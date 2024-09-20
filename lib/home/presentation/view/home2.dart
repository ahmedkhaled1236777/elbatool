import 'package:agman/core/common/navigation.dart';
import 'package:agman/features/auth/login/presentation/view/login.dart';
import 'package:agman/features/injection/presentation/view/production.dart';
import 'package:agman/home/presentation/view/widgets/gridelement.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class home2 extends StatelessWidget {
  List homegrid = [
    {
      "name": "الحقن",
      "image": "assets/images/prod-removebg-preview.png",
      "page": production()
    },
    {
      "name": "اوردرات الحقن",
      "image": "assets/images/manifest.png",
      "page": Login()
    },
    {
      "name": "الاسطمبات",
      "image": "assets/images/molds-removebg-preview.png",
      "page": Login()
    },
    {
      "name": "تصنيع الاسطمبات",
      "image": "assets/images/tooling.png",
      "page": Login()
    },
    {
      "name": "الموظفين",
      "image": "assets/images/division.png",
      "page": Login()
    },
    {"name": "المستخدمين", "image": "assets/images/team.png", "page": Login()},
    {
      "name": "العملاء",
      "image": "assets/images/public-service.png",
      "page": Login()
    },
    {"name": "الموردين", "image": "assets/images/manager.png", "page": Login()},
    {
      "name": "الخزينه",
      "image": "assets/images/safe-deposit.png",
      "page": Login()
    },
    {
      "name": "مخزن الخامات",
      "image": "assets/images/material-removebg-preview.png",
      "page": Login()
    },
    {
      "name": "مخزن الاكسسوارات",
      "image": "assets/images/image_0901.png",
      "page": Login()
    },
    {
      "name": "مخزن المكونات",
      "image": "assets/images/plastic-houhold.png",
      "page": Login()
    },
    {
      "name": "مخزن ادوات المصنع",
      "image": "assets/images/wa.png",
      "page": Login()
    },
    {
      "name": "الحركه اليوميه",
      "image": "assets/images/report.png",
      "page": Login()
    },
    {
      "name": "الاعدادات",
      "image": "assets/images/settings.png",
      "page": Login()
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Material(
                    // Replace this child with your own
                    elevation: 8.0,
                    shape: CircleBorder(),
                    child: AvatarGlow(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        radius: MediaQuery.sizeOf(context).width > 450
                            ? 25.0
                            : 24.sp,
                        backgroundImage:
                            AssetImage("assets/images/division.png"),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      "احمد علام",
                      style: const TextStyle(
                        fontFamily: "cairo",
                        fontSize: 18,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  badges.Badge(
                    onTap: () {},
                    position: badges.BadgePosition.topStart(top: -10),
                    badgeStyle: const badges.BadgeStyle(),
                    badgeContent: const Text(
                      '3',
                      style: TextStyle(color: Colors.white),
                    ),
                    child: Icon(
                      size: MediaQuery.sizeOf(context).width > 450 ? 32 : 30.sp,
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: GridView.count(
                  childAspectRatio: 1 / 0.8,
                  crossAxisCount: MediaQuery.sizeOf(context).width > 950
                      ? 6
                      : MediaQuery.sizeOf(context).width > 650
                          ? 4
                          : MediaQuery.sizeOf(context).width > 500
                              ? 3
                              : 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: homegrid
                      .map((e) => Gridelement(
                            true_false:
                                e["name"] == "الاسطمبات" || e["name"] == "الحقن"
                                    ? "assets/images/cross.png"
                                    : "assets/images/newone.png",
                            text: e["name"],
                            image: e["image"],
                            onTap: () {
                              navigateto(context: context, page: e["page"]);
                            },
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  "assets/images/ac.jpg",
                ))),
      ),
    );
  }
}
