import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:agman/features/orders/data/models/ordermodelrequest.dart';
import 'package:agman/features/orders/presentation/viewmodel/cubit/orders_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addorder extends StatefulWidget {
  @override
  State<Addorder> createState() => _AddorderState();
}

class _AddorderState extends State<Addorder> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController quantity = TextEditingController();
  TextEditingController colorper = TextEditingController();

  TextEditingController purematerial = TextEditingController(text: "0");

  TextEditingController break_crusher_quantity =
      TextEditingController(text: "0");

  TextEditingController broken_awl_quantity = TextEditingController(text: "0");

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
                "اضافة اوردر",
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
                              height: 50,
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
                            Container(
                              color: Color(0xff535C91),
                              child: Center(
                                child: DropdownSearch<String>(
                                  dropdownButtonProps:
                                      DropdownButtonProps(color: Colors.white),
                                  popupProps: PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps()),
                                  selectedItem:
                                      BlocProvider.of<MoldCubit>(context)
                                          .moldname,
                                  items: BlocProvider.of<MoldCubit>(context)
                                      .mymold,
                                  onChanged: (value) {
                                    BlocProvider.of<MoldCubit>(context)
                                        .changemold(value!);
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
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Color(0xff535C91),
                              child: Center(
                                child: DropdownSearch<String>(
                                  dropdownButtonProps:
                                      DropdownButtonProps(color: Colors.white),
                                  popupProps: PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps()),
                                  selectedItem:
                                      BlocProvider.of<plasticMaterialCubit>(
                                              context)
                                          .materialname,
                                  items: BlocProvider.of<plasticMaterialCubit>(
                                          context)
                                      .materialsnames,
                                  onChanged: (value) {
                                    BlocProvider.of<plasticMaterialCubit>(
                                            context)
                                        .changematerialtype(value: value!);
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
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: custommytextform(
                                        val: "ادخل الكمبه",
                                        controller: purematerial,
                                        hintText: "البيور"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: custommytextform(
                                        val: "ادخل الكمبه",
                                        controller: break_crusher_quantity,
                                        hintText: "كسر الكساره"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  SizedBox(
                                    width: 100,
                                    child: custommytextform(
                                        val: "ادخل الكمبه",
                                        controller: broken_awl_quantity,
                                        hintText: "كسر المخرز"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: Color(0xff535C91),
                              child: Center(
                                child: DropdownSearch<String>(
                                  dropdownButtonProps:
                                      DropdownButtonProps(color: Colors.white),
                                  popupProps: PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps()),
                                  selectedItem:
                                      BlocProvider.of<plasticMaterialCubit>(
                                              context)
                                          .colorname,
                                  items: BlocProvider.of<plasticMaterialCubit>(
                                          context)
                                      .colorsnames,
                                  onChanged: (value) {
                                    BlocProvider.of<plasticMaterialCubit>(
                                            context)
                                        .changecolorname(value!);
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
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              controller: colorper,
                              hintText: "كمية الماستر باتش",
                              val: "برجاء ادخال كمية الماستر باتش ",
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              controller: quantity,
                              hintText: "كمية الاوردر",
                              val: "برجاء ادخال كمية الاوردر ",
                            ),
                            SizedBox(height: 10),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocConsumer<OrdersCubit, OrdersState>(
                              listener: (context, state) {
                                if (state is AddOrdersSuccess) {
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();
                                  quantity.clear();
                                  colorper.clear();

                                  purematerial.clear();
                                  break_crusher_quantity.clear();
                                  broken_awl_quantity.clear();
                                  BlocProvider.of<plasticMaterialCubit>(context)
                                      .resetdata();
                                  BlocProvider.of<OrdersCubit>(context)
                                      .getorders();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                                if (state is AddOrdersFailure) {
                                  showtoast(
                                      message: state.errorrmessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is AddOrdersLoading) return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل التقرير",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate()) {
                                      print(
                                          "pppppppppppppppppppppppppppppppppppppp");
                                      print(BlocProvider.of<
                                                  plasticMaterialCubit>(context)
                                              .colorid[
                                          BlocProvider.of<plasticMaterialCubit>(
                                                  context)
                                              .colorname]);
                                      print(BlocProvider.of<MoldCubit>(context)
                                              .moldid[
                                          BlocProvider.of<MoldCubit>(context)
                                              .moldname]);
                                      print(
                                          BlocProvider.of<plasticMaterialCubit>(
                                                  context)
                                              .materialid);
                                      print(BlocProvider.of<
                                                  plasticMaterialCubit>(context)
                                              .materialid[
                                          BlocProvider.of<plasticMaterialCubit>(
                                                  context)
                                              .materialname]);
                                      BlocProvider.of<OrdersCubit>(context).addorder(
                                          order: Ordermodelrequest(
                                              date: BlocProvider.of<DateCubit>(context)
                                                  .date1,
                                              orderquantity: quantity.text,
                                              color: BlocProvider.of<plasticMaterialCubit>(context)
                                                      .colorid[
                                                  BlocProvider.of<plasticMaterialCubit>(context)
                                                      .colorname]!,
                                              colorquantity: colorper.text,
                                              stampid: BlocProvider.of<MoldCubit>(context).moldid[
                                                  BlocProvider.of<MoldCubit>(context)
                                                      .moldname]!["id"],
                                              materialid:
                                                  BlocProvider.of<plasticMaterialCubit>(context)
                                                      .materialid[BlocProvider.of<plasticMaterialCubit>(context).materialname]!,
                                              quantituy1: purematerial.text,
                                              quantituy2: break_crusher_quantity.text,
                                              quantituy3: broken_awl_quantity.text));
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
