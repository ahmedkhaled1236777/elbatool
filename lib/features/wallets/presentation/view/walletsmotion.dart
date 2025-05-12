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
import 'package:agman/features/wallets/presentation/view/widgets/addwalletmotion.dart';
import 'package:agman/features/wallets/presentation/view/widgets/widgets/customtabletimeritem.dart';
import 'package:agman/features/wallets/presentation/viewmodel/wallet/wallet_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class walletsmotions extends StatefulWidget {
  final int walletid;
  final String walletname;
  ScrollController controller = ScrollController();
  walletsmotions({super.key, required this.walletid, required this.walletname});
  @override
  State<walletsmotions> createState() => _walletsmotionsState();
}

class _walletsmotionsState extends State<walletsmotions> {
  final walletsmotionsheader = [
    "التاريخ",
    "العمليه",
    "عميل - مورد",
    "المبلغ",
    "المستخدم",
    "الملاحظات",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<WalletCubit>(context).firstloadingmotion = false;
    BlocProvider.of<WalletCubit>(context)
        .getwalletsmotion(walletid: widget.walletid);
    widget.controller.addListener(() async {
      if (widget.controller.position.pixels ==
          widget.controller.position.maxScrollExtent) {
        await BlocProvider.of<WalletCubit>(context)
            .getmorewalletmotion(walletid: widget.walletid);
      }
    });
  }

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
                  navigateto(
                      context: context,
                      page: Addwalletmotion(
                        walletid: widget.walletid,
                      ));
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "حركات محفظة ${widget.walletname}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: appcolors.maincolor.withOpacity(0.7),
                child: Row(
                    children: walletsmotionsheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "عميل - مورد" ||
                                      e == "العمليه" ||
                                      e == "حذف"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(child: BlocBuilder<WalletCubit, walletState>(
                builder: (context, state) {
                  if (state is getwalletmotionloading) return loadingshimmer();
                  if (state is getwalletmotionfailure)
                    return errorfailure(
                      errormessage: state.errormessage,
                    );
                  return BlocProvider.of<WalletCubit>(context)
                          .datamotions
                          .isEmpty
                      ? nodata()
                      : ListView.separated(
                          controller: widget.controller,
                          itemBuilder: (context, i) => i >=
                                  BlocProvider.of<WalletCubit>(context)
                                      .datamotions
                                      .length
                              ? loading()
                              : Customtablewalletmotionitem(
                                  delete: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<WalletCubit,
                                                walletState>(
                                              listener: (context, state) {
                                                if (state
                                                    is deletewalletmotionsuccess) {
                                                  Navigator.pop(context);
                                                  BlocProvider.of<WalletCubit>(
                                                          context)
                                                      .getwallets();
                                                  showtoast(
                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes,
                                                      context: context);
                                                }
                                                if (state
                                                    is deletewalletmotionfailure) {
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
                                                    is deletewalletmotionloading)
                                                  return deleteloading();
                                                return SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color.fromARGB(
                                                                    255,
                                                                    37,
                                                                    163,
                                                                    42)),
                                                      ),
                                                      onPressed: () async {
                                                        await BlocProvider.of<
                                                                    WalletCubit>(
                                                                context)
                                                            .deletewalletmotion(
                                                          walletmotionid:
                                                              BlocProvider.of<
                                                                          WalletCubit>(
                                                                      context)
                                                                  .datamotions[
                                                                      i]
                                                                  .id!,
                                                        );
                                                      },
                                                      child: const Text(
                                                        "تاكيد",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: "cairo",
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
                                      )),
                                  date: BlocProvider.of<WalletCubit>(context)
                                      .datamotions[i]
                                      .date!,
                                  employer:
                                      BlocProvider.of<WalletCubit>(context)
                                              .datamotions[i]
                                              .employerName ??
                                          "",
                                  type: BlocProvider.of<WalletCubit>(context)
                                              .datamotions[i]
                                              .status ==
                                          0
                                      ? "سحب"
                                      : "ايداع",
                                  clientorcustomer:
                                      BlocProvider.of<WalletCubit>(context)
                                              .datamotions[i]
                                              .clientName ??
                                          "",
                                  amountofmoney: gettext(
                                      value:
                                          BlocProvider.of<WalletCubit>(context)
                                              .datamotions[i]
                                              .money!),
                                  notes: BlocProvider.of<WalletCubit>(context)
                                          .datamotions[i]
                                          .notes ??
                                      "",
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<WalletCubit>(context)
                                      .motionloading ==
                                  true
                              ? BlocProvider.of<WalletCubit>(context)
                                      .datamotions
                                      .length +
                                  1
                              : BlocProvider.of<WalletCubit>(context)
                                  .datamotions
                                  .length);
                },
              )),
            ])));
  }
}
