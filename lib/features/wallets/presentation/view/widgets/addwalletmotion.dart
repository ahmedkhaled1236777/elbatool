import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/wallets/data/model/walletmotionmodel.dart';
import 'package:agman/features/wallets/presentation/view/widgets/widgets/radioswallet.dart';
import 'package:agman/features/wallets/presentation/viewmodel/wallet/wallet_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addwalletmotion extends StatefulWidget {
  final int walletid;

  const Addwalletmotion({super.key, required this.walletid});
  @override
  State<Addwalletmotion> createState() => _AddwalletmotionState();
}

class _AddwalletmotionState extends State<Addwalletmotion> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController amountofmoney = TextEditingController();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

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
                "اضافة حركة للمحفظه",
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
                            BlocBuilder<WalletCubit, walletState>(
                              builder: (context, state) {
                                return radioswalletsmotions(
                                  firstradio: 0,
                                  secondradio: 1,
                                  firstradiotitle: "سحب",
                                  secondradiotitle: "ايداع",
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              keyboardType: TextInputType.number,
                              controller: amountofmoney,
                              hintText: "المبلغ",
                              val: "برجاء ادخال المبلغ",
                            ),
                            SizedBox(height: 10),
                            custommytextform(
                              controller: notes,
                              hintText: "الملاحظات",
                              val: "برجاء ادخال الملاحظات",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<WalletCubit, walletState>(
                              listener: (context, state) async {
                                if (state is addwalletmotionfailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addwalletmotionsuccess) {
                                  amountofmoney.clear();
                                  notes.clear();
                                  await BlocProvider.of<WalletCubit>(context)
                                      .getwalletsmotion(
                                          walletid: widget.walletid);
                                  await BlocProvider.of<WalletCubit>(context)
                                      .getwallets();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is addwalletmotionloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      BlocProvider.of<WalletCubit>(context)
                                          .addwalletmotion(
                                              wallet: Walletmotionmodelrequest(
                                                  date: BlocProvider.of<
                                                          DateCubit>(context)
                                                      .date1,
                                                  status: BlocProvider.of<
                                                          WalletCubit>(context)
                                                      .wallettype,
                                                  notes: notes.text,
                                                  money: amountofmoney.text,
                                                  walletid: widget.walletid));
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
