import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/data/model/intialcostmodelrequest.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/view/customgridimages.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/view/pickedimage.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/viewmodel/cubit/intialcost_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/coststates.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addfirstcost extends StatelessWidget {
  final int stampid;
  TextEditingController type = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController notes = TextEditingController(text: "لا يوجد");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Addfirstcost({super.key, required this.stampid});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: const Text(
            "اضافة تكلفه اوليه",
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
                        child: Form(
                            key: formkey,
                            child:
                                BlocBuilder<IntialcostCubit, IntialcostState>(
                                    builder: (context, state) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  BlocBuilder<DateCubit, DateState>(
                                    builder: (context, state) {
                                      return choosedate(
                                        date:
                                            BlocProvider.of<DateCubit>(context)
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
                                  custommytextform(
                                    val: "برجاء ادخال نوع التكلفه",
                                    controller: type,
                                    hintText: "نوع التكلفه",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    val: "برجاء ادخال السعر",
                                    controller: cost,
                                    hintText: "السعر",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  custommytextform(
                                    val: "برجاء ادخال الملاحظات",
                                    controller: notes,
                                    hintText: "الملاحظات",
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  pickedimage(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (BlocProvider.of<IntialcostCubit>(context)
                                          .image !=
                                      null)
                                    customgridimages(),
                                  if (BlocProvider.of<IntialcostCubit>(context)
                                          .image !=
                                      null)
                                    const SizedBox(
                                      height: 10,
                                    ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  BlocConsumer<IntialcostCubit,
                                      IntialcostState>(
                                    listener: (context, state) {
                                      if (state is addintialcostfailure) {
                                        showtoast(
                                            message: state.errormessage,
                                            toaststate: Toaststate.error,
                                            context: context);
                                      }

                                      if (state is addintialcostsuccess) {
                                        cost.clear();
                                        type.clear();
                                        BlocProvider.of<DateCubit>(context)
                                            .cleardates();
                                        notes.clear();
                                        BlocProvider.of<IntialcostCubit>(
                                                context)
                                            .resetimage();
                                        BlocProvider.of<IntialcostCubit>(
                                                context)
                                            .getfirstcosts(stampid: stampid);
                                        BlocProvider.of<Costcuibt>(context)
                                            .getmoldmanufacture();
                                        showtoast(
                                            message: state.successmessage,
                                            toaststate: Toaststate.succes,
                                            context: context);
                                      }
                                      // TODO: implement listener
                                    },
                                    builder: (context, state) {
                                      if (state is addintialcostloading)
                                        return loading();
                                      return custommaterialbutton(
                                        button_name: "تسجيل",
                                        onPressed: () async {
                                          BlocProvider.of<IntialcostCubit>(context).addintialcost(
                                              intialcost: Intialcostmodelrequest(
                                                  image: BlocProvider.of<IntialcostCubit>(context)
                                                              .image !=
                                                          null
                                                      ? await MultipartFile.fromFile(
                                                          BlocProvider.of<IntialcostCubit>(context)
                                                              .image!
                                                              .path,
                                                          filename:
                                                              BlocProvider.of<IntialcostCubit>(
                                                                      context)
                                                                  .image!
                                                                  .path
                                                                  .split("/")
                                                                  .last)
                                                      : null,
                                                  cost: cost.text,
                                                  notes: notes.text.isEmpty
                                                      ? "لا يوجد"
                                                      : notes.text,
                                                  date:
                                                      BlocProvider.of<DateCubit>(context).date1,
                                                  stampid: stampid,
                                                  type: type.text));
                                        },
                                      );
                                    },
                                  ),
                                  SizedBox(
                                    height: 50,
                                  )
                                ],
                              );
                            })))),
              ),
            )));
  }
}
