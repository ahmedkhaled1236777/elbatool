import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/accessories/data/model/accessoriemodelrequest.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class addaccessories extends StatefulWidget {
  @override
  State<addaccessories> createState() => _addaccessoriesState();
}

class _addaccessoriesState extends State<addaccessories> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController accessoriesname = TextEditingController();
  TextEditingController quantity = TextEditingController();
  TextEditingController buymoney = TextEditingController();
  TextEditingController sellmoney = TextEditingController();

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
                "اضافة اكسسوار",
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
                            custommytextform(
                              controller: accessoriesname,
                              hintText: "اسم الاكسسوار",
                              val: "برجاء ادخال اسم الاكسسوار",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              controller: quantity,
                              hintText: "الكميه",
                              val: "برجاء ادخال الكميه",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                                controller: buymoney,
                                hintText: "سعر الشراء",
                                val: "برجاء ادخال سعر الشراء",
                                keyboardType: TextInputType.number),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                                controller: sellmoney,
                                hintText: "ٍسعر البيع",
                                val: "برجاء ادخال سعر البيع",
                                keyboardType: TextInputType.number),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocConsumer<plasticaccessoriesCubit,
                                plasticaccessoriesState>(
                              listener: (context, state) {
                                if (state is addaccessoriefailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addaccessoriesuccess) {
                                  quantity.clear();
                                  accessoriesname.clear();
                                  sellmoney.clear();
                                  buymoney.clear();
                                  BlocProvider.of<plasticaccessoriesCubit>(
                                          context)
                                      .getaccessories();

                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is addaccessorieloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل اكسسوار",
                                  onPressed: () async {
                                    if (formkey.currentState!.validate())
                                      BlocProvider.of<plasticaccessoriesCubit>(
                                              context)
                                          .addaccessorie(
                                              accessorie:
                                                  Accessoriemodelrequest(
                                                      name:
                                                          accessoriesname.text,
                                                      quantity: int.parse(
                                                          quantity.text),
                                                      sellprice: double.parse(
                                                          sellmoney.text),
                                                      buyprice: double.parse(
                                                          buymoney.text)));
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
