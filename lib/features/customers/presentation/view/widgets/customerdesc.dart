import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/features/customers/presentation/view/widgets/customeritemdesc.dart';
import 'package:agman/features/customers/presentation/view/widgets/customerusageitem.dart';
import 'package:agman/features/customers/presentation/view/widgets/customers/monthsearch.dart';
import 'package:agman/features/customers/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Customerdesc extends StatelessWidget {
  final String quantity;
  final String pieceprice;
  final String total;
  final String date;
  final String type;
  final String desc;
  final String name;
  final String pagename;
  List checks;

  final Widget page;
  final TextStyle textStyle;

  Customerdesc(
      {super.key,
      required this.quantity,
      required this.checks,
      required this.pagename,
      required this.textStyle,
      required this.name,
      required this.page,
      required this.pieceprice,
      required this.total,
      required this.date,
      required this.type,
      required this.desc});
  final customerheader = [
    "التاريخ",
    "النوع",
    "التوضيح",
    "الكميه",
    "سعر الوحده",
    "الاجمالي",
    "تحديد",
    "حذف",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            title: Container(
                              height: 20,
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: appcolors.maincolor,
                                  )),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            backgroundColor: Colors.white,
                            insetPadding: EdgeInsets.all(35),
                            content: Monthsearch(
                              clientid: 1,
                            ));
                      });
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ],
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: Text(
            "العميل احمد",
            style: Styles.appbarstyle,
          ),
        ),
        body: LayoutBuilder(builder: (context, constrains) {
          return Column(children: [
            Container(
              height: 50,
              color: appcolors.maincolor.withOpacity(0.7),
              child: Row(
                  children: customerheader
                      .map((e) => customheadertable(
                            title: e,
                            textStyle:
                                Styles.getheadertextstyle(context: context),
                            flex: e == "تعديل" || e == "حذف" || e == "تحديد"
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
                              onTap: () {
                                showDialog(
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
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(0)),
                                          content: Customeritemdesc());
                                    });
                              },
                              child:
                                  BlocBuilder<CustomersCubit, CustomersState>(
                                builder: (context, state) {
                                  return Customerusageitem(
                                      estimate: Checkbox(
                                          value: checks[i],
                                          onChanged: (val) {
                                            BlocProvider.of<CustomersCubit>(
                                                    context)
                                                .changechecbox(
                                                    pagename: pagename,
                                                    val: val!,
                                                    index: i);
                                          }),
                                      textStyle: Styles.gettabletextstyle(
                                          context: context),
                                      date: "22/4/2024",
                                      pieceprice: pieceprice,
                                      type: type,
                                      desc: desc,
                                      quantity: quantity,
                                      total: total,
                                      delet: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            deleteicon,
                                            color: Colors.red,
                                          )));
                                },
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
                InkWell(
                    onTap: () async {
                      BlocProvider.of<CustomersCubit>(context)
                          .changetype(value: name);
                      BlocProvider.of<CustomersCubit>(context)
                          .changepaymenttype(value: "cash");
                      navigateto(context: context, page: page);
                    },
                    child: Container(
                      height: 45,
                      width: 45,
                      child: Icon(
                        Icons.add,
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
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 7),
              width: double.infinity,
              color: appcolors.dropcolor,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "اجمالي ما له : 4000",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "اجمالي ما عليه : 3001",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
          ]);
        }));
  }
}
