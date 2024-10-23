import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/features/suppliers/presentation/view/addsupplier.dart';
import 'package:agman/features/suppliers/presentation/view/supplieritem.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/addSUPPLIERmotion.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/widgets/alertcontent.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/widgets/SUPPLIERdesc.dart';
import 'package:agman/features/suppliers/presentation/viewmodel/suppliers/suppliers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Suppliers extends StatelessWidget {
  final supplierheader = [
    "اسم المورد",
    "رقم الهاتف",
    "الجهه",
    "تعديل",
    "حذف",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
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
                          content: Alertsuppliercontent(),
                        );
                      });
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ],
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: const Text(
            "الموردين",
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
                  children: supplierheader
                      .map((e) => customheadertable(
                            textStyle:
                                Styles.getheadertextstyle(context: context),
                            title: e,
                            flex: e == "تعديل" || e == "حذف" || e == "الجهه"
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
                                BlocProvider.of<SupplierssCubit>(context)
                                    .changetype(value: "INJECTION");
                                BlocProvider.of<SupplierssCubit>(context)
                                    .changepaymenttype(value: "cash");
                                navigateto(
                                    context: context,
                                    page: supplierdesc(
                                      textStyle: Styles.gettabletextstyle(
                                          context: context),
                                      name: "SUPPLY",
                                      page: AddSuppliersmotion(),
                                      date: "22/7/2024",
                                      desc: "خامه",
                                      quantity: "20",
                                      pieceprice: "200",
                                      total: "4000",
                                      type: "توريد",
                                    ));
                              },
                              child: customtablsupplieritem(
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  name: 'احمد',
                                  phone: "011503987412",
                                  place: "مصنع السلام",
                                  edit: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        editeicon,
                                      )),
                                  delet: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        deleteicon,
                                        color: Colors.red,
                                      ))),
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
                      BlocProvider.of<SupplierssCubit>(context)
                          .changetype(value: "SUPPLY");
                      BlocProvider.of<SupplierssCubit>(context)
                          .changepaymenttype(value: "cash");
                      navigateto(context: context, page: addsupplier());
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
            )
          ]);
        }));
  }
}
