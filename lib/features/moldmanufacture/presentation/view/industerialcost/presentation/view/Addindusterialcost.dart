import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/view/customgridimages.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/view/pickedimage.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/viewmodel/cubit/intialcost_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/data/model/industerialcostrequest.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/presentation/viewmodel/cubit/industerialcostcuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/presentation/viewmodel/cubit/industerialcoststste.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/viewmodel/cubit/induxterialcost_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addindusterialcost extends StatelessWidget {
  final int stampid;
  TextEditingController numberofhours = TextEditingController();
  TextEditingController notes = TextEditingController(text: "لا يوجد");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Addindusterialcost({super.key, required this.stampid});
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
            "اضافة تكلفه تصنيع",
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
                            child: BlocBuilder<IndusterialcostCubit,
                                    myIndusterialcostState>(
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
                                            searchFieldProps: TextFieldProps()),
                                        selectedItem: BlocProvider.of<
                                                InduxterialcostCubit>(context)
                                            .machinename,
                                        items: BlocProvider.of<
                                                InduxterialcostCubit>(context)
                                            .machinesnames,
                                        onChanged: (value) {
                                          BlocProvider.of<InduxterialcostCubit>(
                                                  context)
                                              .changemachine(value!);
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
                                                        color:
                                                            Color(0xff535C91)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  border: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color:
                                                            Color(0xff535C91)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                )),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  custommytextform(
                                    val: "برجاء ادخال عدد الساعات",
                                    controller: numberofhours,
                                    hintText: "عدد الساعات",
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
                                  BlocConsumer<IndusterialcostCubit,
                                      myIndusterialcostState>(
                                    listener: (context, state) {
                                      if (state
                                          is addmyIndusterialcostfailure) {
                                        showtoast(
                                            message: state.errormessage,
                                            toaststate: Toaststate.error,
                                            context: context);
                                      }

                                      if (state
                                          is addmyIndusterialcostsuccess) {
                                        notes.clear();
                                        numberofhours.clear();
                                        BlocProvider.of<DateCubit>(context)
                                            .cleardates();
                                        notes.clear();

                                        BlocProvider.of<InduxterialcostCubit>(
                                                context)
                                            .resetmachine();
                                        BlocProvider.of<IndusterialcostCubit>(
                                                context)
                                            .getindusterialcost(
                                                stampid: stampid);
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
                                      if (state is addmyIndusterialcostloading)
                                        return loading();
                                      return custommaterialbutton(
                                        button_name: "تسجيل",
                                        onPressed: () async {
                                          BlocProvider.of<IndusterialcostCubit>(
                                                  context)
                                              .addIndusterialcost(
                                                  Industerialcost:
                                                      Industerialcostrequest(
                                            machineid: BlocProvider.of<
                                                        InduxterialcostCubit>(
                                                    context)
                                                .machineid[BlocProvider.of<
                                                        InduxterialcostCubit>(
                                                    context)
                                                .machinename]!,
                                            numberofhours: numberofhours.text,
                                            notes: notes.text.isEmpty
                                                ? "لا يوجد"
                                                : notes.text,
                                            date: BlocProvider.of<DateCubit>(
                                                    context)
                                                .date1,
                                            stampid: stampid,
                                          ));
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
