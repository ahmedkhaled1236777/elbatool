import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/accessories/data/model/deleteputmodelrequest.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:agman/features/accessories/presentation/views/widgets/widgets/radios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Deleteorput extends StatefulWidget {
  final int accessoreeid;

  const Deleteorput({super.key, required this.accessoreeid});
  @override
  State<Deleteorput> createState() => _DeleteorputState();
}

class _DeleteorputState extends State<Deleteorput> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController quantity = TextEditingController();
  TextEditingController sellprice = TextEditingController();
  TextEditingController buyprice = TextEditingController();
  TextEditingController notes = TextEditingController(text: "لا يوجد");
  TextEditingController stampname = TextEditingController(text: "لا يوجد");

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
                "سحب او اضافة اكسسوار",
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
                            BlocBuilder<plasticaccessoriesCubit,
                                plasticaccessoriesState>(
                              builder: (context, state) {
                                return radios(
                                    sell: 2,
                                    firstradio: 0,
                                    secondradio: 1,
                                    firstradiotitle: "سحب",
                                    selltittle: "بيع",
                                    secondradiotitle: "شراء");
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
                              controller: stampname,
                              hintText: "اسم الاسطمبه اذا وجد",
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
                            BlocBuilder<plasticaccessoriesCubit,
                                plasticaccessoriesState>(
                              builder: (context, state) {
                                return BlocProvider.of<plasticaccessoriesCubit>(
                                                context)
                                            .type ==
                                        1
                                    ? Column(
                                        children: [
                                          custommytextform(
                                            controller: sellprice,
                                            hintText: "سعر البيع",
                                            val: "برجاء ادخال سعر البيع",
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          custommytextform(
                                            controller: buyprice,
                                            hintText: "سعر الشراء",
                                            val: "برجاء ادخال سعر الشراء",
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                    : SizedBox();
                              },
                            ),
                            custommytextform(
                                controller: notes,
                                hintText: "الملاحظات",
                                val: "برجاء ادخال الملاحظات",
                                keyboardType: TextInputType.number),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocConsumer<plasticaccessoriesCubit,
                                plasticaccessoriesState>(
                              listener: (context, state) {
                                if (state is addordeletefailure) {
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                }
                                if (state is addordeletesuccess) {
                                  BlocProvider.of<plasticaccessoriesCubit>(
                                          context)
                                      .getaccessoriesmotion(
                                          accessorieid: widget.accessoreeid);
                                  BlocProvider.of<plasticaccessoriesCubit>(
                                          context)
                                      .getaccessories();
                                  BlocProvider.of<DateCubit>(context)
                                      .cleardates();
                                  BlocProvider.of<plasticaccessoriesCubit>(
                                          context)
                                      .changetype(value: 1);
                                  notes.clear();
                                  quantity.clear();
                                  stampname.clear();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                                // TODO: implement listener
                              },
                              builder: (context, state) {
                                if (state is addordeleteloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "سحب او اضافه",
                                  onPressed: () async {
                                    BlocProvider.of<plasticaccessoriesCubit>(
                                            context)
                                        .putordeleteaccessorie(
                                            accessorie: Deleteputmodelrequest(
                                                id: widget.accessoreeid,
                                                stampname: stampname.text,
                                                sellprice:
                                                    sellprice.text.isEmpty
                                                        ? "0"
                                                        : sellprice.text,
                                                buyprice: buyprice.text.isEmpty
                                                    ? "0"
                                                    : buyprice.text,
                                                quantity:
                                                    int.parse(quantity.text),
                                                notes: notes.text,
                                                date:
                                                    BlocProvider.of<DateCubit>(
                                                            context)
                                                        .date1,
                                                type: BlocProvider.of<
                                                            plasticaccessoriesCubit>(
                                                        context)
                                                    .type
                                                    .toString()));
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
