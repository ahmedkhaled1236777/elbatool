import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/features/materiales/presentation/views/widgets/addmaterialmotion.dart';
import 'package:agman/features/materiales/presentation/views/widgets/datesearch.dart';
import 'package:agman/features/materiales/presentation/views/widgets/materialmotion.dart';
import 'package:flutter/material.dart';

class Plasticmaterialitem extends StatefulWidget {
  final int materialid;
  final String materialname;
  final String type;

  const Plasticmaterialitem(
      {super.key,
      required this.materialid,
      required this.materialname,
      required this.type});
  @override
  State<Plasticmaterialitem> createState() => _PlasticmaterialitemState();
}

class _PlasticmaterialitemState extends State<Plasticmaterialitem> {
  final componentheader = [
    "التاريخ",
    "الكميه",
    "الحاله",
    "رقم الاوردر-الاذن",
    "الملاحظات",
    "حذف",
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
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Container(
                                height: 20,
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: appcolors.maincolor,
                                    )),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.all(35),
                              content: Datecomponentsearch(),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "حركات الخامه",
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
                      children: componentheader
                          .map((e) => customheadertable(
                                textStyle:
                                    Styles.getheadertextstyle(context: context),
                                title: e,
                                flex:
                                    e == "حذف" || e == "تعديل" || e == "الحاله"
                                        ? 2
                                        : 3,
                              ))
                          .toList()),
                ),
                Expanded(
                    child: RefreshIndicator(
                        onRefresh: () async {},
                        child: ListView.separated(
                            itemBuilder: (context, i) => InkWell(
                                  onTap: () {},
                                  child: Materialmotion(
                                    textStyle: Styles.gettabletextstyle(
                                        context: context),
                                    ordernumber: '25255',
                                    date: '22/7/2024',
                                    quantity: "225",
                                    status: "سحب",
                                    notes: "لا يوجد",
                                    delet: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          color: Colors.red,
                                          deleteicon,
                                        )),
                                  ),
                                ),
                            separatorBuilder: (context, i) => Divider(
                                  color: Colors.grey,
                                ),
                            itemCount: 5))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        onTap: () {
                          navigateto(
                              context: context,
                              page: Addmaterialmotion(
                                materialid: widget.materialid,
                                materialname: widget.materialname,
                                type: widget.type,
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () async {},
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ]);
            })));
  }
}
