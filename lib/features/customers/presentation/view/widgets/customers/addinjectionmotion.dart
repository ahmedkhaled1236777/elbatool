import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/features/customers/presentation/view/widgets/mold/radios.dart';
import 'package:agman/features/customers/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addinjectionmotion extends StatefulWidget {
  @override
  State<Addinjectionmotion> createState() => _AddinjectionmotionState();
}

class _AddinjectionmotionState extends State<Addinjectionmotion> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController type = TextEditingController();

  TextEditingController desc = TextEditingController();

  TextEditingController quantity = TextEditingController();
  TextEditingController putcost = TextEditingController();
  TextEditingController pieceprice = TextEditingController();
  TextEditingController totalvalue = TextEditingController();
  TextEditingController payedvalue = TextEditingController();

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
                "اضافة حركة عميل",
                style: Styles.appbarstyle,
              ),
            ),
            body: BlocBuilder<CustomersCubit, CustomersState>(
              builder: (context, state) {
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
                          height: MediaQuery.sizeOf(context).height,
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
                                  height: 7,
                                ),
                                radiostypes(
                                  firstradio: "INJECTION",
                                  secondradio: "PAYMENT",
                                  thirdradio: "mold",
                                  firstradiotitle: "حقن",
                                  secondradiotitle: "دفعه",
                                  thirdradiotittle: "اسطمبه",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                        .type !=
                                    "INJECTION")
                                  customerradios(
                                    firstradio: "cash",
                                    secondradio: "transported",
                                    firstradiotitle: "نقدي",
                                    secondradiotitle: "تحويل",
                                  ),
                                SizedBox(
                                  height: 10,
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
                                if (BlocProvider.of<CustomersCubit>(context)
                                        .paymenttype ==
                                    "transported")
                                  Column(
                                    children: [
                                      Container(
                                        color: Color(0xff535C91),
                                        child: Center(
                                          child: DropdownSearch<String>(
                                            dropdownButtonProps:
                                                DropdownButtonProps(
                                                    color: Colors.white),
                                            popupProps: PopupProps.menu(
                                                showSelectedItems: true,
                                                showSearchBox: true,
                                                searchFieldProps:
                                                    TextFieldProps()),
                                            selectedItem: "اختر المحفظه",
                                            items: [],
                                            onChanged: (value) {},
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
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff535C91)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 10),
                                const SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                  controller: desc,
                                  hintText: "التوضيح",
                                  val: "برجاء ادخال اسم التوضيح",
                                ),
                                SizedBox(height: 10),
                                if (BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "INJECTION" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "mold")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: quantity,
                                    hintText: "الكميه",
                                    val: "برجاء ادخال الكميه",
                                  ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "INJECTION" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "mold")
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "INJECTION" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "mold")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: pieceprice,
                                    hintText: "سعر الوحده",
                                    val: "برجاء ادخال سعر الوحده",
                                  ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "INJECTION" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "mold")
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                        .type ==
                                    "PAYMENT")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: payedvalue,
                                    hintText: "المبلغ المدفوع",
                                    val: "برجاء ادخال المبلغ المدفوع",
                                  ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                        .paymenttype ==
                                    "transported")
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                        .paymenttype ==
                                    "transported")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: putcost,
                                    hintText: "رسوم الايداع",
                                    val: "برجاء ادخال رسوم الايداع المدفوع",
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                custommaterialbutton(
                                  button_name: "تسجيل عميل",
                                  onPressed: () async {},
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
