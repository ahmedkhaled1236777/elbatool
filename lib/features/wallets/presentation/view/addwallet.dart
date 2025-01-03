import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/wallets/data/model/walletmodelrequest.dart';
import 'package:agman/features/wallets/presentation/viewmodel/wallet/wallet_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addwallet extends StatefulWidget {
  @override
  State<Addwallet> createState() => _AddwalletState();
}

class _AddwalletState extends State<Addwallet> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController wallwtname = TextEditingController();
  TextEditingController moneyinwallet = TextEditingController();

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
                "اضافة محفظه",
                style: Styles.appbarstyle,
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/inj.png",
                      ))),
              child: Center(
                child: Form(
                    key: formkey,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height,
                      margin: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.sizeOf(context).width < 600 ? 0 : 15)),
                      width: MediaQuery.sizeOf(context).width > 650
                          ? MediaQuery.sizeOf(context).width * 0.4
                          : double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 9),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            const SizedBox(
                              height: 25,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date1,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate(context);
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              keyboardType: TextInputType.number,
                              controller: wallwtname,
                              hintText: "اسم المحفظه",
                              val: "برجاء ادخال اسم المحفظه",
                            ),
                            SizedBox(height: 10),
                            custommytextform(
                              controller: moneyinwallet,
                              hintText: "المبلغ بداخل المحفظه",
                              val: "برجاء ادخال المبلغ الموجود بالمحفظه",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<WalletCubit, walletState>(
                              listener: (context, state) {
                                if (state is addwalletfailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addwalletsuccess) {
                                  wallwtname.clear();
                                  moneyinwallet.clear();
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();

                                  BlocProvider.of<WalletCubit>(context)
                                      .getwallets();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is addwalletloading) return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل محفظه",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      await BlocProvider.of<
                                              WalletCubit>(context)
                                          .addwallet(
                                              wallet: Walletmodelrequest(
                                                  name: wallwtname.text,
                                                  date: BlocProvider.of<
                                                          DateCubit>(context)
                                                      .date1,
                                                  money: moneyinwallet.text));
                                    }
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ]))),
                    )),
              ),
            )));
  }
}
