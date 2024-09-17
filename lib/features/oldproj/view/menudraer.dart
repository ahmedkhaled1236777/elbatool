import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class menudrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolors.yellow,
      body: Stack(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(80),
                    child: SizedBox(
                      height: 70,
                      width: 70,
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
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    cashhelper.getdata(key: "user_name") ?? "مستخدم",
                    style: TextStyle(
                        color: Colors.white, fontFamily: apptexts.appfonfamily),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: appcolors.primarycolor,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 11,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: appcolors.primarycolor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: (() {}),
                          child: Text(
                            "تغيير كلمة المرور",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: apptexts.appfonfamily),
                          )),
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: appcolors.expensecolor,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: appcolors.primarycolor,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 11,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: appcolors.primarycolor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "التواصل",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: apptexts.appfonfamily),
                      ),
                      Spacer(),
                      InkWell(
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              "assets/images/wa.png",
                            ),
                            backgroundColor: Colors.blue.withOpacity(1),
                          ),
                          onTap: (() async {
                            var whatsappUrl =
                                "whatsapp://send?phone=${"+201552770367"}";
                            var url = Uri.parse(whatsappUrl);
                            try {
                              launchUrl(url);
                            } catch (e) {
                              //To handle error and display error message
                            }
                          })),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                          child: CircleAvatar(
                            radius: 17,
                            backgroundImage: AssetImage(
                              "assets/images/fa.png",
                            ),
                            backgroundColor: Colors.white.withOpacity(1),
                          ),
                          onTap: (() async {
                            var url = Uri(scheme: 'tel', path: "+201552770367");
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          })),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundColor: appcolors.primarycolor,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 11,
                          child: CircleAvatar(
                            radius: 6,
                            backgroundColor: appcolors.primarycolor,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                          onTap: (() async {}),
                          child: Text("تسجيل الخروج",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: apptexts.appfonfamily,
                              ))),
                      Spacer(),
                      IconButton(
                          onPressed: () async {},
                          icon: Icon(
                            Icons.logout,
                            color: appcolors.expensecolor,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            )
          ]),
          Positioned(
            child: CircleAvatar(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                        onPressed: () {
                          ZoomDrawer.of(context)!.close();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: appcolors.primarycolor,
                          size: 30,
                        )),
                  )),
              radius: 50,
              backgroundColor: Colors.white,
            ),
            right: -50,
            top: 50,
          )
        ],
      ),
    );
  }
}
