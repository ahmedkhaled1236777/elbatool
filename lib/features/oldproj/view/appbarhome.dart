import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/texts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mat_month_picker_dialog/mat_month_picker_dialog.dart';

class Appbarhome extends StatefulWidget {
  @override
  State<Appbarhome> createState() => _AppbarhomeState();
}

class _AppbarhomeState extends State<Appbarhome> {
  int? month;

  int? year;

  String valx = "يناير";

  List<String> texts = [
    "اليوم",
    "الاسبوع",
    "الشهر",
    "السنه",
  ];

  Map<int, String> months = {
    1: "يناير",
    2: "فبراير",
    3: "مارس",
    4: "ابريل",
    5: "مايو",
    6: "يونيو",
    7: "يوليو",
    8: "اغسطس",
    9: "سبتمبر",
    10: "اكتوبر",
    11: "نوفمبر",
    12: "ديسمبر",
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: appcolors.maincolor,
            radius: 36,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 28.5,
              child: Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: cashhelper.getdata(key: "image") == null
                        ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbmB8QjPQMaiVi3yB0IckvPI1yiaYQLaAQ4g&usqp=CAU"
                        : cashhelper.getdata(key: "image"),
                    errorWidget: (context, url, Widget) {
                      return Icon(
                        Icons.person,
                        color: Colors.white,
                      );
                    },
                    placeholder: (context, url) {
                      return CircularProgressIndicator();
                    },
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {},
            child: Container(
              padding: EdgeInsets.all(5),
              height: 50,
              width: 125,
              decoration: BoxDecoration(
                color: appcolors.lightblue,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: appcolors.maincolor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        month == null
                            ? "${months[DateTime.now().month]} ${DateTime.now().year}"
                            : "${months[month!]} ${year}",
                        style: TextStyle(
                            color: Colors.black54,
                            fontFamily: apptexts.appfonfamily),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.notifications,
                color: appcolors.maincolor,
              ))
        ],
      ),
    );
  }
}
