import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/injection/data/models/productionmodel.dart';
import 'package:agman/features/injection/presentation/viewmodel/cubit/injection_cubit.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:agman/features/orders/presentation/viewmodel/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

class addreport extends StatefulWidget {
  @override
  State<addreport> createState() => _addreportState();
}

class _addreportState extends State<addreport> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController workername = TextEditingController();

  TextEditingController machinenumber = TextEditingController();

  TextEditingController workhours = TextEditingController();

  TextEditingController counterstart = TextEditingController();

  TextEditingController counterend = TextEditingController();

  TextEditingController realprodcountity = TextEditingController();

  TextEditingController shift = TextEditingController();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  String? x;
  getdata() {
    BlocProvider.of<InjectionCubit>(context)
        .gertmoldsandorders(context: context);
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
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "اضافة تقرير",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: BlocBuilder<InjectionCubit, InjectionState>(
              builder: (context, state) {
                print("gggggggggggggggggggggggggggggggg");
                print(state);

                if (state is getmoldandordersfailure) return SizedBox();
                if (state is getmoldandordersloading) return loading();
                return Container(
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
                                  MediaQuery.sizeOf(context).width < 600
                                      ? 0
                                      : 15)),
                          width: MediaQuery.sizeOf(context).width > 650
                              ? MediaQuery.sizeOf(context).width * 0.4
                              : double.infinity,
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 9),
                              child: SingleChildScrollView(
                                  child: Column(children: [
                                const SizedBox(
                                  height: 50,
                                ),
                                BlocBuilder<DateCubit, DateState>(
                                  builder: (context, state) {
                                    return choosedate(
                                      date: BlocProvider.of<DateCubit>(context)
                                          .date1,
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
                                Container(
                                  color: Color(0xff535C91),
                                  child: Center(
                                    child:
                                        BlocBuilder<OrdersCubit, OrdersState>(
                                      builder: (context, state) {
                                        return DropdownSearch<String>(
                                          dropdownButtonProps:
                                              DropdownButtonProps(
                                                  color: Colors.white),
                                          popupProps: PopupProps.menu(
                                              showSelectedItems: true,
                                              showSearchBox: true,
                                              searchFieldProps:
                                                  TextFieldProps()),
                                          selectedItem:
                                              BlocProvider.of<OrdersCubit>(
                                                      context)
                                                  .ordername,
                                          items: BlocProvider.of<OrdersCubit>(
                                                  context)
                                              .orders,
                                          onChanged: (value) {
                                            BlocProvider.of<OrdersCubit>(
                                                    context)
                                                .changeorder(value!);
                                          },
                                          dropdownDecoratorProps:
                                              DropDownDecoratorProps(
                                                  baseStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "cairo"),
                                                  textAlign: TextAlign.center,
                                                  dropdownSearchDecoration:
                                                      InputDecoration(
                                                    enabled: true,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff535C91)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff535C91)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  )),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                  controller: workername,
                                  hintText: "اسم العامل",
                                  val: "برجاء ادخال اسم العامل",
                                ),
                                SizedBox(height: 10),
                                const SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                  keyboardType: TextInputType.number,
                                  controller: shift,
                                  hintText: "رقم الورديه",
                                  val: "برجاء ادخال رقم الورديه",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                  controller: machinenumber,
                                  hintText: "رقم الماكينه",
                                  val: "برجاء ادخال رقم الماكينه",
                                  keyboardType: TextInputType.number,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                    controller: workhours,
                                    hintText: "عدد ساعات التشغيل",
                                    val: "برجاء ادخال عدد ساعات التشغيل",
                                    keyboardType: TextInputType.number),
                                const SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                    controller: counterstart,
                                    hintText: "بداية العداد",
                                    val: "برجاء ادخال بداية العداد",
                                    keyboardType: TextInputType.number),
                                const SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                    controller: counterend,
                                    hintText: "نهاية العداد",
                                    val: "برجاء ادخال نهاية العداد",
                                    keyboardType: TextInputType.number),
                                const SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                    controller: realprodcountity,
                                    hintText: "كمية الانتاج الفعلي",
                                    val: "برجاء ادخال كمية الانتاج الفعلي",
                                    keyboardType: TextInputType.number),
                                const SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                    controller: notes, hintText: "الملاحظات"),
                                const SizedBox(
                                  height: 20,
                                ),
                                BlocConsumer<InjectionCubit, InjectionState>(
                                  listener: (context, state) {
                                    if (state is addinjectionfailure) {
                                      showtoast(
                                          message: state.errormessage,
                                          toaststate: Toaststate.error,
                                          context: context);
                                    }
                                    if (state is addinjectionsuccess) {
                                      workername.clear();
                                      workhours.clear();
                                      counterend.clear();
                                      counterstart.clear();
                                      shift.clear();
                                      realprodcountity.clear();
                                      machinenumber.clear();
                                      BlocProvider.of<OrdersCubit>(context)
                                          .resetorder();
                                      showtoast(
                                          message: state.successmessage,
                                          toaststate: Toaststate.succes,
                                          context: context);
                                    }
                                    // TODO: implement listener
                                  },
                                  builder: (context, state) {
                                    if (state is addinjectionloading)
                                      return loading();
                                    return custommaterialbutton(
                                      button_name: "تسجيل التقرير",
                                      onPressed: () async {
                                        if (formkey.currentState!.validate()) {
                                          num expectedprod = ((double.parse(workhours.text) *
                                                      60 *
                                                      60 *
                                                      int.parse(BlocProvider.of<MoldCubit>(context)
                                                          .moldid[BlocProvider.of<OrdersCubit>(context).ordermold[BlocProvider.of<OrdersCubit>(context).ordername]]![
                                                              "numberofpieces"]
                                                          .toString())) /
                                                  num.parse(BlocProvider.of<MoldCubit>(context)
                                                      .moldid[BlocProvider.of<OrdersCubit>(context).ordermold[
                                                          BlocProvider.of<OrdersCubit>(context)
                                                              .ordername]]!["cycletime"]
                                                      .toString()))
                                              .round();
                                          num scrapcountity = (((int.parse(
                                                          counterend.text) -
                                                      int.parse(
                                                          counterstart.text))) *
                                                  int.parse(BlocProvider.of<MoldCubit>(context)
                                                      .moldid[BlocProvider.of<OrdersCubit>(context)
                                                              .ordermold[
                                                          BlocProvider.of<OrdersCubit>(
                                                                  context)
                                                              .ordername]]!["numberofpieces"]
                                                      .toString())) -
                                              int.parse(realprodcountity.text).round();

                                          num proddivision = expectedprod -
                                              ((double.parse(counterend.text) -
                                                          double.parse(
                                                              counterstart
                                                                  .text)) *
                                                      double.parse(BlocProvider.of<MoldCubit>(context)
                                                          .moldid[
                                                              BlocProvider.of<OrdersCubit>(context)
                                                                      .ordermold[
                                                                  BlocProvider.of<OrdersCubit>(context)
                                                                      .ordername]]![
                                                              "numberofpieces"]
                                                          .toString()))
                                                  .round();

                                          num machinestop = (double.parse(
                                                      proddivision.toString()) *
                                                  double.parse(BlocProvider.of<
                                                          MoldCubit>(context)
                                                      .moldid[BlocProvider.of<OrdersCubit>(context)
                                                              .ordermold[
                                                          BlocProvider.of<OrdersCubit>(context)
                                                              .ordername]]!["cycletime"]
                                                      .toString())) /
                                              (60 * double.parse(BlocProvider.of<MoldCubit>(context).moldid[BlocProvider.of<OrdersCubit>(context).ordermold[BlocProvider.of<OrdersCubit>(context).ordername]]!["numberofpieces"].toString())).round();
                                          {
                                            BlocProvider.of<InjectionCubit>(context).addoroduction(
                                                production: productionmodel(
                                                    date:
                                                        BlocProvider.of<DateCubit>(context)
                                                            .date1,
                                                    ordernuber: BlocProvider.of<OrdersCubit>(context)
                                                            .orderid[
                                                        BlocProvider.of<OrdersCubit>(context)
                                                            .ordername]!["id"],
                                                    workername: workername.text,
                                                    color: BlocProvider.of<OrdersCubit>(context)
                                                            .orderid[
                                                        BlocProvider.of<OrdersCubit>(context)
                                                            .ordername]!["color"],
                                                    machinenumber: int.parse(machinenumber.text),
                                                    shift: int.parse(shift.text),
                                                    prodname: BlocProvider.of<OrdersCubit>(context).orderid[BlocProvider.of<OrdersCubit>(context).ordername]!["mold"],
                                                    cycletime: num.parse(BlocProvider.of<MoldCubit>(context).moldid[BlocProvider.of<OrdersCubit>(context).ordermold[BlocProvider.of<OrdersCubit>(context).ordername]]!["cycletime"].toString()),
                                                    numberofpieces: int.parse(BlocProvider.of<MoldCubit>(context).moldid[BlocProvider.of<OrdersCubit>(context).ordermold[BlocProvider.of<OrdersCubit>(context).ordername]]!["numberofpieces"].toString()),
                                                    workhours: num.parse(workhours.text),
                                                    counterstart: int.parse(counterstart.text),
                                                    counterend: int.parse(counterend.text),
                                                    realprodcountity: int.parse(realprodcountity.text),
                                                    expectedprod: expectedprod,
                                                    scrapcountity: scrapcountity,
                                                    proddivision: proddivision,
                                                    machinestop: int.parse(machinestop.ceil().toString()),
                                                    notes: notes.text));
                                          }
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
                );
              },
            )));
  }
}
