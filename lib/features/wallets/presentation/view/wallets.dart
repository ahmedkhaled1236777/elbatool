import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/core/common/widgets/thousand.dart';
import 'package:agman/features/wallets/presentation/view/addwallet.dart';
import 'package:agman/features/wallets/presentation/view/walletsmotion.dart';
import 'package:agman/features/wallets/presentation/view/widgets/customtabletimeritem.dart';
import 'package:agman/features/wallets/presentation/viewmodel/wallet/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common/widgets/error.dart';

class wallets extends StatefulWidget {
  @override
  State<wallets> createState() => _walletsState();
}

class _walletsState extends State<wallets> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final walletsheader = [
    "تاريخ انشاء المحفظه",
    "اسم المحفظه",
    "المبلغ",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<WalletCubit>(context).getwallets();
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
                  navigateto(context: context, page: Addwallet());
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
                "المحافظ الالكترونيه",
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
                    children: walletsheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(child: BlocBuilder<WalletCubit, walletState>(
                builder: (context, state) {
                  if (state is getwalletloading) return loadingshimmer();
                  if (state is getwalletfailure)
                    return errorfailure(
                      errormessage: state.errormessage,
                    );

                  return BlocProvider.of<WalletCubit>(context).data.isEmpty
                      ? nodata()
                      : ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {
                                  navigateto(
                                      context: context,
                                      page: walletsmotions(
                                        walletname:
                                            BlocProvider.of<WalletCubit>(
                                                    context)
                                                .data[i]
                                                .name!,
                                        walletid: BlocProvider.of<WalletCubit>(
                                                context)
                                            .data[i]
                                            .id!,
                                      ));
                                },
                                child: Customtablewalletitem(
                                  delete: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<WalletCubit,
                                                walletState>(
                                              listener: (context, state) {
                                                if (state
                                                    is deletewalletsuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes,
                                                      context: context);
                                                }
                                                if (state
                                                    is deletewalletfailure) {
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
                                                    is deletewalletloading)
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
                                                            .deletewallet(
                                                          walletid: BlocProvider
                                                                  .of<WalletCubit>(
                                                                      context)
                                                              .data[i]
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
                                  salary: BlocProvider.of<WalletCubit>(context)
                                              .data[i]
                                              .money ==
                                          null
                                      ? ""
                                      : gettext(
                                          value: BlocProvider.of<WalletCubit>(
                                                  context)
                                              .data[i]
                                              .money!),
                                  date: BlocProvider.of<WalletCubit>(context)
                                          .data[i]
                                          .date ??
                                      "",
                                  walletname:
                                      BlocProvider.of<WalletCubit>(context)
                                              .data[i]
                                              .name ??
                                          "",
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                ),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<WalletCubit>(context)
                              .data
                              .length);
                },
              )),
            ])));
  }
}
