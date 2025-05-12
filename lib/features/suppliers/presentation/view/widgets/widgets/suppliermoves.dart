import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/error.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/core/common/widgets/thousand.dart';

import 'package:agman/features/suppliers/presentation/view/widgets/addSUPPLIERmotion.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/widgets/monthsearch.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/widgets/supplierusageitem.dart';
import 'package:agman/features/suppliers/presentation/viewmodel/suppliers/suppliers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class supplierdesc extends StatefulWidget {
  final int supplierid;
  ScrollController scrollController = ScrollController();

  supplierdesc({super.key, required this.supplierid});
  @override
  State<supplierdesc> createState() => _supplierdescState();
}

class _supplierdescState extends State<supplierdesc> {
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
    BlocProvider.of<SupplierssCubit>(context).firstloading = false;
    await BlocProvider.of<SupplierssCubit>(context)
        .getsuppliermovesmoves(queryparmes: {"supplier_id": widget.supplierid});
    widget.scrollController.addListener(() async {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        await BlocProvider.of<SupplierssCubit>(context).getamoresuppliermoves(
            queryparmes: {"supplier_id": widget.supplierid});
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
                            content: Monthsearchsupplier(
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
            "المورد احمد",
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
                            flex: e == "تحديد" || e == "حذف" ? 2 : 3,
                          ))
                      .toList()),
            ),
            Expanded(child: BlocBuilder<SupplierssCubit, SupplierssState>(
              builder: (context, state) {
                if (state is getSuppliersmovesloading) return loadingshimmer();
                if (state is getSuppliersmovesfailure)
                  return errorfailure(errormessage: state.errormessage);
                return BlocProvider.of<SupplierssCubit>(context).mymoves.isEmpty
                    ? nodata()
                    : ListView.separated(
                        itemBuilder: (context, i) => i >=
                                BlocProvider.of<SupplierssCubit>(context)
                                    .mymoves
                                    .length
                            ? loading()
                            : InkWell(
                                onTap: () {},
                                child: supplierusageitem(
                                    check: Checkbox(
                                        value: BlocProvider.of<SupplierssCubit>(context)
                                            .checks[i],
                                        onChanged: (val) {
                                          BlocProvider.of<SupplierssCubit>(
                                                  context)
                                              .changecheckbox(val!, i);
                                        }),
                                    textStyle: Styles.gettabletextstyle(
                                        context: context),
                                    date: BlocProvider.of<SupplierssCubit>(context)
                                            .mymoves[i]
                                            .date ??
                                        "",
                                    pieceprice:
                                        BlocProvider.of<SupplierssCubit>(context)
                                                .mymoves[i]
                                                .price
                                                .toString() ??
                                            "",
                                    type: BlocProvider.of<SupplierssCubit>(context)
                                                .mymoves[i]
                                                .type ==
                                            "material"
                                        ? "توريد خامات"
                                        : BlocProvider.of<SupplierssCubit>(context)
                                                    .mymoves[i]
                                                    .type ==
                                                "accessories"
                                            ? "توريد اكسسوارات"
                                            : BlocProvider.of<SupplierssCubit>(context).mymoves[i].type == "factorytools"
                                                ? "توريد ادوات مصنع"
                                                : BlocProvider.of<SupplierssCubit>(context).mymoves[i].type == "back"
                                                    ? "مرتجع"
                                                    : BlocProvider.of<SupplierssCubit>(context).mymoves[i].type == "naqdi"
                                                        ? "نقدى"
                                                        : "تحويل",
                                    desc: BlocProvider.of<SupplierssCubit>(context).mymoves[i].notes ?? "",
                                    quantity: BlocProvider.of<SupplierssCubit>(context).mymoves[i].type == "naqdi" || BlocProvider.of<SupplierssCubit>(context).mymoves[i].type == "ta7weel" ? "" : BlocProvider.of<SupplierssCubit>(context).mymoves[i].qty!.toString(),
                                    total: gettext(value: BlocProvider.of<SupplierssCubit>(context).mymoves[i].type == "naqdi" || BlocProvider.of<SupplierssCubit>(context).mymoves[i].type == "ta7weel" ? BlocProvider.of<SupplierssCubit>(context).mymoves[i].price!.toString() : (BlocProvider.of<SupplierssCubit>(context).mymoves[i].qty! * BlocProvider.of<SupplierssCubit>(context).mymoves[i].price!).toStringAsFixed(1)),
                                    delet: IconButton(
                                        onPressed: () {
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<
                                                  SupplierssCubit,
                                                  SupplierssState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is deletesuppliermovesuccess) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        message: state
                                                            .successmessage,
                                                        toaststate:
                                                            Toaststate.succes,
                                                        context: context);
                                                  }
                                                  if (state
                                                      is deletesuppliermovefailure) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        message:
                                                            state.errormessage,
                                                        toaststate:
                                                            Toaststate.error,
                                                        context: context);
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state
                                                      is deleteSuppliermoveloading)
                                                    return deleteloading();
                                                  return SizedBox(
                                                    height: 50,
                                                    width: 100,
                                                    child: ElevatedButton(
                                                        style:
                                                            const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          37,
                                                                          163,
                                                                          42)),
                                                        ),
                                                        onPressed: () async {
                                                          await BlocProvider.of<
                                                                      SupplierssCubit>(
                                                                  context)
                                                              .deletesuppliermove(
                                                            moveid: BlocProvider
                                                                    .of<SupplierssCubit>(
                                                                        context)
                                                                .mymoves[i]
                                                                .id!,
                                                          );
                                                        },
                                                        child: const Text(
                                                          "تاكيد",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  "cairo",
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                  );
                                                },
                                              ),
                                              tittle: "هل تريد الحذف ؟");
                                        },
                                        icon: Icon(
                                          deleteicon,
                                          color: Colors.red,
                                        )))),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<SupplierssCubit>(context).loading == true ? BlocProvider.of<SupplierssCubit>(context).mymoves.length + 1 : BlocProvider.of<SupplierssCubit>(context).mymoves.length);
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
                      navigateto(
                          context: context,
                          page: AddSuppliersmotion(
                            supplierid: widget.supplierid,
                          ));
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
            BlocBuilder<SupplierssCubit, SupplierssState>(
              builder: (context, state) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  width: double.infinity,
                  color: appcolors.dropcolor,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "اجمالي ما له : ${BlocProvider.of<SupplierssCubit>(context).totaldaen}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "اجمالي ما عليه : ${BlocProvider.of<SupplierssCubit>(context).totalmaden}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ]);
        }));
  }
}
