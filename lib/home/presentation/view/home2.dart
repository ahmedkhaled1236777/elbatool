import 'package:agman/features/auth/login/presentation/view/login.dart';
import 'package:agman/home/presentation/view/widgets/gridelement.dart';
import 'package:flutter/material.dart';

class home2 extends StatelessWidget {
  List homegrid = [
    {
      "name": "الحقن",
      "image": "assets/images/prod-removebg-preview.png",
      "page": Login()
    },
    {
      "name": "اوردرات الحقن",
      "image": "assets/images/prod-removebg-preview.png",
      "page": Login()
    },
    {
      "name": "الاسطمبات",
      "image": "assets/images/molds-removebg-preview.png",
      "page": Login()
    },
    {
      "name": "تصنيع الاسطمبات",
      "image": "assets/images/molds-removebg-preview.png",
      "page": Login()
    },
    {
      "name": "الموظفين",
      "image": "assets/images/division.png",
      "page": Login()
    },
    {
      "name": "المستخدمين",
      "image": "assets/images/division.png",
      "page": Login()
    },
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
      "image": "assets/images/material-removebg-preview.png",
      "page": Login()
    },
    {
      "name": "مخزن المكونات",
      "image": "assets/images/material-removebg-preview.png",
      "page": Login()
    },
    {
      "name": "مخزن ادوات المصنع",
      "image": "assets/images/material-removebg-preview.png",
      "page": Login()
    },
    {
      "name": "الاعدادات",
      "image": "assets/images/material-removebg-preview.png",
      "page": Login()
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      text: e["name"],
                      image: e["image"],
                      onTap: () {},
                    ))
                .toList(),
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
