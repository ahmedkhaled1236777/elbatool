import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/features/save/presentation/view/addtosave.dart';
import 'package:agman/features/save/presentation/view/widgets/customtabletimeritem.dart';
import 'package:flutter/material.dart';

class save extends StatefulWidget {
  @override
  State<save> createState() => _saveState();
}

class _saveState extends State<save> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final saveheader = [
    "التاريخ",
    "العمليه",
    "عميل - مورد",
    "المبلغ",
    "الموظف",
    "الملاحظات",
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
            floatingActionButton: FloatingActionButton(
                backgroundColor: appcolors.primarycolor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  navigateto(context: context, page: Addsave());
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      /*  showDialog(
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
                              content: Alertmoldcontent(),
                            );
                          });*/
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "المعاملات الماليه",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                width: double.infinity,
                child: Center(
                  child: Text(
                    style: TextStyle(
                        fontFamily: "cairo",
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                    "الاجمالي : 50000",
                  ),
                ),
              ),
              Container(
                height: 50,
                color: appcolors.maincolor.withOpacity(0.7),
                child: Row(
                    children: saveheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex:
                                  e == "عميل - مورد" || e == "العمليه" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {},
                                child: Customtablesaveitem(
                                  date: "22/7/2024",
                                  employer: "عماد",
                                  type: "ايداع",
                                  clientorcustomer: "محمد علي",
                                  amountofmoney: "2000",
                                  notes: "تحميل عدد خامات",
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                ),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: 5))),
            ])));
  }
}
