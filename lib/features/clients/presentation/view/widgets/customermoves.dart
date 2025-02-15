import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/error.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/features/clients/presentation/view/widgets/customers/addinjectionmotion.dart';
import 'package:agman/features/clients/presentation/view/widgets/customers/monthsearch.dart';
import 'package:agman/features/clients/presentation/view/widgets/customerusageitem.dart';
import 'package:agman/features/clients/presentation/viewmodel/customers/customers_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Customermoves extends StatefulWidget {
  final int clientid;
  final String clientname;
  ScrollController scrollController = ScrollController();

  Customermoves({super.key, required this.clientid, required this.clientname});

  @override
  State<Customermoves> createState() => _CustomermovesState();
}

class _CustomermovesState extends State<Customermoves> {
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
  getdata() async {
    BlocProvider.of<CustomersCubit>(context).firstloading = false;
    await BlocProvider.of<CustomersCubit>(context)
        .getclientmoves(client_id: widget.clientid);
    widget.scrollController.addListener(() async {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        await BlocProvider.of<CustomersCubit>(context)
            .getamoreclientmoves(client_id: widget.clientid);
      }
    });
  }

  @override
  void initState() {
    getdata();
  }

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
            widget.clientname,
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
            Expanded(child: BlocBuilder<CustomersCubit, CustomersState>(
              builder: (context, state) {
                print("///////////////////////////////////////////////");
                print(BlocProvider.of<CustomersCubit>(context).mymoves.length);
                if (state is getclientmovesloading) return loadingshimmer();
                if (state is getclientmovesfailure)
                  return errorfailure(errormessage: state.errormessage);
                return BlocProvider.of<CustomersCubit>(context).mymoves.isEmpty
                    ? nodata()
                    : ListView.separated(
                        itemBuilder: (context, i) => i >=
                                BlocProvider.of<CustomersCubit>(context)
                                    .mymoves
                                    .length
                            ? loading()
                            : InkWell(
                                onTap: () {},
                                child: Customerusageitem(
                                    estimate: Checkbox(
                                        value: BlocProvider.of<CustomersCubit>(context)
                                            .checks[i],
                                        onChanged: (val) {
                                          BlocProvider.of<CustomersCubit>(
                                                  context)
                                              .changecheckbox(val!, i);
                                        }),
                                    textStyle: Styles.gettabletextstyle(
                                        context: context),
                                    date: BlocProvider.of<CustomersCubit>(context)
                                            .mymoves[i]
                                            .date ??
                                        "",
                                    pieceprice: BlocProvider.of<CustomersCubit>(context)
                                                    .mymoves[i]
                                                    .type ==
                                                "naqdi" ||
                                            BlocProvider.of<CustomersCubit>(context)
                                                    .mymoves[i]
                                                    .type ==
                                                "ta7weel"
                                        ? ""
                                        : BlocProvider.of<CustomersCubit>(context).mymoves[i].priceUnit ?? "",
                                    type: BlocProvider.of<CustomersCubit>(context).mymoves[i].type == "naqdi"
                                        ? "نقدي"
                                        : BlocProvider.of<CustomersCubit>(context).mymoves[i].type == "ta7weel"
                                            ? "تحويل"
                                            : BlocProvider.of<CustomersCubit>(context).mymoves[i].type == "syana"
                                                ? "صيانه"
                                                : BlocProvider.of<CustomersCubit>(context).mymoves[i].type == "7aan"
                                                    ? "حقن"
                                                    : "اسطمبات",
                                    desc: BlocProvider.of<CustomersCubit>(context).mymoves[i].notes ?? "",
                                    quantity: BlocProvider.of<CustomersCubit>(context).mymoves[i].type == "naqdi" || BlocProvider.of<CustomersCubit>(context).mymoves[i].type == "ta7weel" ? "" : BlocProvider.of<CustomersCubit>(context).mymoves[i].qty!,
                                    total: BlocProvider.of<CustomersCubit>(context).mymoves[i].type == "naqdi" || BlocProvider.of<CustomersCubit>(context).mymoves[i].type == "ta7weel" ? BlocProvider.of<CustomersCubit>(context).mymoves[i].priceUnit! : (double.parse(BlocProvider.of<CustomersCubit>(context).mymoves[i].qty!) * double.parse(BlocProvider.of<CustomersCubit>(context).mymoves[i].priceUnit!)).toStringAsFixed(1),
                                    delet: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          deleteicon,
                                          color: Colors.red,
                                        )))),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<CustomersCubit>(context).loading == true ? BlocProvider.of<CustomersCubit>(context).mymoves.length + 1 : BlocProvider.of<CustomersCubit>(context).mymoves.length);
              },
            )),
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
                          .changetype(value: "MANUFACTURE");
                      BlocProvider.of<CustomersCubit>(context)
                          .changepaymenttype(value: "cash");
                      navigateto(context: context, page: Addinjectionmotion());
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
          ]);
        }));
  }
}
