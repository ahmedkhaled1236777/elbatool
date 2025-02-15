import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/save/data/model/savemodelrequest.dart';
import 'package:agman/features/save/presentation/view/widgets/radiossave.dart';
import 'package:agman/features/save/presentation/viewmodel/save/save_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addsave extends StatefulWidget {
  @override
  State<Addsave> createState() => _AddsaveState();
}

class _AddsaveState extends State<Addsave> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController amountofmoney = TextEditingController();

  TextEditingController notes = TextEditingController();

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
                "اضافة حركة للخزينه",
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
                            BlocBuilder<SaveCubit, SaveState>(
                              builder: (context, state) {
                                return radiossave(
                                  firstradio: "0",
                                  secondradio: "1",
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
                            BlocConsumer<SaveCubit, SaveState>(
                              listener: (context, state) {
                                if (state is addsavefailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addsavesuccess) {
                                  amountofmoney.clear();
                                  notes.clear();
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();
                                  BlocProvider.of<SaveCubit>(context)
                                      .changesavetype("0");
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is addsaveloading) return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل",
                                  onPressed: () async {
                                    BlocProvider.of<SaveCubit>(context)
                                        .addsavemotion(
                                            saverequest: Savemodelrequest(
                                                date:
                                                    BlocProvider.of<DateCubit>(
                                                            context)
                                                        .date1,
                                                status:
                                                    BlocProvider.of<SaveCubit>(
                                                            context)
                                                        .savetype,
                                                money: amountofmoney.text,
                                                notes: notes.text));
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
