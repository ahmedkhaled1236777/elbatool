import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/customtablegarditem.dart';
import 'package:flutter/material.dart';

class toolsgard extends StatefulWidget {
  @override
  State<toolsgard> createState() => _toolsgardState();
}

class _toolsgardState extends State<toolsgard> {
  final toolsheader = [
    "اسم الاداه",
    "كمية الشراء",
    "كمية الاستهلاك",
  ];

  getdata() async {}

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "جرد ادوات المصنع",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: LayoutBuilder(builder: (context, constrains) {
              return Column(children: [
                Container(
                  height: 50,
                  color: appcolors.maincolor.withOpacity(0.7),
                  child: Row(
                      children: toolsheader
                          .map((e) => customheadertable(
                                textStyle:
                                    Styles.getheadertextstyle(context: context),
                                title: e,
                                flex: e == "حذف" ||
                                        e == "تعديل" ||
                                        e == "عدد\nساعات التشغيل"
                                    ? 2
                                    : 3,
                              ))
                          .toList()),
                ),
                Expanded(
                    child: RefreshIndicator(
                        onRefresh: () async {},
                        child: ListView.separated(
                            itemBuilder: (context, i) => Customtablegarditem(
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  toolname: 'بنز 5 مملي',
                                  totalbuy: "10",
                                  totalconsume: "26",
                                ),
                            separatorBuilder: (context, i) => Divider(
                                  color: Colors.grey,
                                ),
                            itemCount: 5))),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                )
              ]);
            })));
  }
}
