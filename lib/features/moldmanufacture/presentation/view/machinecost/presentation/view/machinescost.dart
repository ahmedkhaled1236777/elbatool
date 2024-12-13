import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/view/addmachine.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/view/customtablemachinecostitem.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/view/emachinedialod.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/viewmodel/cubit/induxterialcost_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Machinescost extends StatefulWidget {
  @override
  State<Machinescost> createState() => _MachinescostState();
}

class _MachinescostState extends State<Machinescost> {
  final machinecostheader = [
    "اسم الماكينه",
    "سعر الساعه",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<InduxterialcostCubit>(context).getmachines();
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
              actions: [],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "الماكينات",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: LayoutBuilder(builder: (context, constrains) {
              return Column(children: [
                Container(
                  height: 50,
                  color: appcolors.maincolor.withOpacity(0.7),
                  child: Row(
                      children: machinecostheader
                          .map((e) => customheadertable(
                                textStyle:
                                    Styles.getheadertextstyle(context: context),
                                title: e,
                                flex: e == "حذف" || e == "تعديل" ? 2 : 3,
                              ))
                          .toList()),
                ),
                Expanded(
                    child: RefreshIndicator(
                        onRefresh: () async {},
                        child: BlocBuilder<InduxterialcostCubit,
                            InduxterialcostState>(
                          builder: (context, state) {
                            if (state is getmachinesloading)
                              return loadingshimmer();
                            else if (state is getmachinesfailure)
                              return SizedBox();
                            else {
                              if (BlocProvider.of<InduxterialcostCubit>(context)
                                  .machines
                                  .isEmpty) return nodata();
                              return ListView.separated(
                                  itemBuilder: (context, i) =>
                                      Customtablemachinecostitem(
                                        textStyle: Styles.gettabletextstyle(
                                            context: context),
                                        machinecostname: BlocProvider.of<
                                                InduxterialcostCubit>(context)
                                            .machines[i]
                                            .name!,
                                        cost: BlocProvider.of<
                                                InduxterialcostCubit>(context)
                                            .machines[i]
                                            .pricePerHour!,
                                        delet: IconButton(
                                            onPressed: () {
                                              awsomdialogerror(
                                                  context: context,
                                                  mywidget: BlocConsumer<
                                                      InduxterialcostCubit,
                                                      InduxterialcostState>(
                                                    listener: (context, state) {
                                                      if (state
                                                          is deletemachinesuccess) {
                                                        Navigator.pop(context);

                                                        showtoast(
                                                            message: state
                                                                .successmessage,
                                                            toaststate:
                                                                Toaststate
                                                                    .succes,
                                                            context: context);
                                                      }
                                                      if (state
                                                          is deletemachinefailure) {
                                                        Navigator.pop(context);

                                                        showtoast(
                                                            message: state
                                                                .errormessage,
                                                            toaststate:
                                                                Toaststate
                                                                    .error,
                                                            context: context);
                                                      }
                                                    },
                                                    builder: (context, state) {
                                                      if (state
                                                          is deletemachineloading)
                                                        return deleteloading();
                                                      return SizedBox(
                                                        height: 50,
                                                        width: 100,
                                                        child: ElevatedButton(
                                                            style:
                                                                const ButtonStyle(
                                                              backgroundColor:
                                                                  MaterialStatePropertyAll(
                                                                      Color.fromARGB(
                                                                          255,
                                                                          37,
                                                                          163,
                                                                          42)),
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await BlocProvider
                                                                      .of<InduxterialcostCubit>(
                                                                          context)
                                                                  .deletemachine(
                                                                machineid: BlocProvider.of<
                                                                            InduxterialcostCubit>(
                                                                        context)
                                                                    .machines[i]
                                                                    .id!,
                                                              );
                                                            },
                                                            child: const Text(
                                                              "تاكيد",
                                                              style: TextStyle(
                                                                  fontSize: 12,
                                                                  fontFamily:
                                                                      "cairo",
                                                                  color: Colors
                                                                      .white),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )),
                                                      );
                                                    },
                                                  ),
                                                  tittle: "هل تريد الحذف ؟");
                                            },
                                            icon: Icon(
                                              color: Colors.red,
                                              deleteicon,
                                            )),
                                        edit: IconButton(
                                            onPressed: () {
                                              showDialog(
                                                  barrierDismissible: false,
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Container(
                                                        height: 20,
                                                        alignment:
                                                            Alignment.topLeft,
                                                        child: IconButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            icon: Icon(
                                                              Icons.close,
                                                              color: appcolors
                                                                  .maincolor,
                                                            )),
                                                      ),
                                                      contentPadding:
                                                          EdgeInsets.all(10),
                                                      backgroundColor:
                                                          Colors.white,
                                                      insetPadding:
                                                          EdgeInsets.all(35),
                                                      content:
                                                          Editmachinecostdialog(
                                                        id: BlocProvider.of<
                                                                    InduxterialcostCubit>(
                                                                context)
                                                            .machines[i]
                                                            .id!,
                                                        notes: TextEditingController(
                                                            text: BlocProvider
                                                                    .of<InduxterialcostCubit>(
                                                                        context)
                                                                .machines[i]
                                                                .notes),
                                                        machinename: TextEditingController(
                                                            text: BlocProvider
                                                                    .of<InduxterialcostCubit>(
                                                                        context)
                                                                .machines[i]
                                                                .name),
                                                        machinecost: TextEditingController(
                                                            text: BlocProvider
                                                                    .of<InduxterialcostCubit>(
                                                                        context)
                                                                .machines[i]
                                                                .pricePerHour),
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              editeicon,
                                            )),
                                      ),
                                  separatorBuilder: (context, i) => Divider(
                                        color: Colors.grey,
                                      ),
                                  itemCount:
                                      BlocProvider.of<InduxterialcostCubit>(
                                              context)
                                          .machines
                                          .length);
                            }
                          },
                        ))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () async {},
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () {
                          navigateto(context: context, page: Addmachine());
                        },
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ]);
            })));
  }
}
