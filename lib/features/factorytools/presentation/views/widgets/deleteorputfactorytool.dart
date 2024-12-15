import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/factorytools/data/models/factorytoolmotionrequest.dart';
import 'package:agman/features/factorytools/presentation/viewmodel/factorytools/factorytools_cubit.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/factorytoolsradio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Deleteorputfactorytool extends StatefulWidget {
  final int factorytoolid;

  const Deleteorputfactorytool({super.key, required this.factorytoolid});
  @override
  State<Deleteorputfactorytool> createState() => _DeleteorputfactorytoolState();
}

class _DeleteorputfactorytoolState extends State<Deleteorputfactorytool> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController quantity = TextEditingController();
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
                "حركة ادوات المصنع",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
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
                              height: 50,
                            ),
                            BlocBuilder<FactorytoolsCubit, FactorytoolsState>(
                              builder: (context, state) {
                                return Factorytoolsradio(
                                    thirdradio: "2",
                                    firstradio: "1",
                                    secondradio: "0",
                                    firstradiotitle: "شراء",
                                    thirdradiotittle: "بيع",
                                    secondradiotitle: "استهلاك");
                              },
                            ),
                            SizedBox(
                              height: 10,
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
                              controller: quantity,
                              hintText: "الكميه",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                                controller: notes,
                                hintText: "الملاحظات",
                                val: "برجاء ادخال الملاحظات",
                                keyboardType: TextInputType.number),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocConsumer<FactorytoolsCubit, FactorytoolsState>(
                              listener: (context, state) {
                                if (state is addtoolmotionfailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addtoolmotionsuccess) {
                                  BlocProvider.of<FactorytoolsCubit>(context)
                                      .getfactorytoolsmotion(
                                          id: widget.factorytoolid);
                                  BlocProvider.of<FactorytoolsCubit>(context)
                                      .getfactorytools();
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();
                                  BlocProvider.of<FactorytoolsCubit>(context)
                                      .changetype(value: "1");
                                  notes.clear();
                                  quantity.clear();
                                  showtoast(
                                      message: "تمت الاضافه بنجاح",
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is addtoolmotionloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل",
                                  onPressed: () async {
                                    BlocProvider.of<FactorytoolsCubit>(context)
                                        .addtoolmotion(
                                            factorytool: Factorytoolmotionrequest(
                                                date: BlocProvider.of<
                                                        DateCubit>(context)
                                                    .date1,
                                                quantity:
                                                    int.parse(quantity.text),
                                                id: widget.factorytoolid,
                                                status: BlocProvider.of<
                                                            FactorytoolsCubit>(
                                                        context)
                                                    .type,
                                                notes: notes.text.isEmpty
                                                    ? "لا يوجد"
                                                    : notes.text));
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
