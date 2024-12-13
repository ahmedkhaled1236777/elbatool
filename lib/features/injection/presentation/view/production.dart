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
import 'package:agman/features/injection/data/models/productionmodel.dart';
import 'package:agman/features/injection/presentation/view/addproduction.dart';
import 'package:agman/features/injection/presentation/view/widgets/alertcontent.dart';
import 'package:agman/features/injection/presentation/view/widgets/customtableproductionitem.dart';
import 'package:agman/features/injection/presentation/view/widgets/productionitem.dart';
import 'package:agman/features/injection/presentation/viewmodel/cubit/injection_cubit.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../molds/presentation/views/molds.dart';

class production extends StatefulWidget {
  @override
  State<production> createState() => _productionState();
}

class _productionState extends State<production> {
  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final productionheader = [
    "رقم الماكينه",
    "اسم العامل",
    "اسم المنتج",
    "كمية الانتاج",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<InjectionCubit>(context).getinjections(
        date:
            '${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day}');
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
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Container(
                                height: 20,
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(
                                      Icons.close,
                                      color: appcolors.maincolor,
                                    )),
                              ),
                              contentPadding: EdgeInsets.all(10),
                              backgroundColor: Colors.white,
                              insetPadding: EdgeInsets.all(35),
                              content: Alertcontent(),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "التقرير اليومي",
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
                      children: productionheader
                          .map((e) => customheadertable(
                                textStyle:
                                    Styles.getheadertextstyle(context: context),
                                title: e,
                                flex: e == "حذف" || e == "عدد\nساعات التشغيل"
                                    ? 2
                                    : 3,
                              ))
                          .toList()),
                ),
                Expanded(
                    child: RefreshIndicator(
                        onRefresh: () async {},
                        child: BlocBuilder<InjectionCubit, InjectionState>(
                          builder: (context, state) {
                            if (state is getinjectionsloading)
                              return loadingshimmer();
                            else if (state is getinjectiongfailure)
                              return SizedBox();
                            else {
                              if (BlocProvider.of<InjectionCubit>(context)
                                  .productions
                                  .isEmpty) return nodata();
                              return ListView.separated(
                                  itemBuilder: (context, i) => InkWell(
                                        onTap: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Container(
                                                    height: 20,
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: Icon(
                                                          Icons.close,
                                                          color: appcolors
                                                              .maincolor,
                                                        )),
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  content: Productionitem(
                                                    productions: productionmodel(
                                                        ordernuber: int.parse(
                                                            BlocProvider.of<InjectionCubit>(context)
                                                                .productions[i]
                                                                .ordernumber!),
                                                        color: BlocProvider.of<InjectionCubit>(context)
                                                            .productions[i]
                                                            .color,
                                                        date: BlocProvider.of<InjectionCubit>(context)
                                                            .productions[i]
                                                            .date,
                                                        workername:
                                                            BlocProvider.of<InjectionCubit>(context)
                                                                .productions[i]
                                                                .workername,
                                                        machinenumber:
                                                            BlocProvider.of<InjectionCubit>(context)
                                                                .productions[i]
                                                                .machinenumber,
                                                        shift: BlocProvider.of<InjectionCubit>(context)
                                                            .productions[i]
                                                            .shift,
                                                        prodname: BlocProvider.of<InjectionCubit>(context)
                                                            .productions[i]
                                                            .prodname,
                                                        stampname: BlocProvider.of<InjectionCubit>(context)
                                                            .productions[i]
                                                            .stampname!,
                                                        cycletime: BlocProvider.of<InjectionCubit>(context)
                                                            .productions[i]
                                                            .cycletime,
                                                        numberofpieces: BlocProvider.of<InjectionCubit>(context).productions[i].numberofpieces,
                                                        workhours: BlocProvider.of<InjectionCubit>(context).productions[i].workhours,
                                                        counterstart: BlocProvider.of<InjectionCubit>(context).productions[i].counterstart,
                                                        counterend: BlocProvider.of<InjectionCubit>(context).productions[i].counterend,
                                                        realprodcountity: BlocProvider.of<InjectionCubit>(context).productions[i].realprodcountity,
                                                        expectedprod: BlocProvider.of<InjectionCubit>(context).productions[i].expectedprod,
                                                        scrapcountity: BlocProvider.of<InjectionCubit>(context).productions[i].scrapcountity,
                                                        proddivision: BlocProvider.of<InjectionCubit>(context).productions[i].proddivision,
                                                        machinestop: BlocProvider.of<InjectionCubit>(context).productions[i].machinestop,
                                                        notes: BlocProvider.of<InjectionCubit>(context).productions[i].notes),
                                                  ),
                                                );
                                              });
                                        },
                                        child: customtableproductionsitem(
                                            textStyle: Styles.gettabletextstyle(
                                                context: context),
                                            worker:
                                                BlocProvider.of<InjectionCubit>(
                                                        context)
                                                    .productions[i]
                                                    .workername,
                                            machinenumber:
                                                BlocProvider.of<InjectionCubit>(
                                                        context)
                                                    .productions[i]
                                                    .machinenumber
                                                    .toString(),
                                            productname:
                                                BlocProvider.of<InjectionCubit>(
                                                        context)
                                                    .productions[i]
                                                    .stampname
                                                    .toString(),
                                            productquantity:
                                                BlocProvider.of<InjectionCubit>(
                                                        context)
                                                    .productions[i]
                                                    .realprodcountity
                                                    .toString(),
                                            delet: IconButton(
                                                onPressed: () {
                                                  awsomdialogerror(
                                                      context: context,
                                                      mywidget: BlocConsumer<
                                                          InjectionCubit,
                                                          InjectionState>(
                                                        listener:
                                                            (context, state) {
                                                          if (state
                                                              is deleteinjectionsuccess) {
                                                            Navigator.pop(
                                                                context);

                                                            showtoast(
                                                                message: state
                                                                    .successmesssage,
                                                                toaststate:
                                                                    Toaststate
                                                                        .succes,
                                                                context:
                                                                    context);
                                                          }
                                                          if (state
                                                              is deleteinjectionfailure) {
                                                            Navigator.pop(
                                                                context);

                                                            showtoast(
                                                                message: state
                                                                    .errormessage,
                                                                toaststate:
                                                                    Toaststate
                                                                        .error,
                                                                context:
                                                                    context);
                                                          }
                                                        },
                                                        builder:
                                                            (context, state) {
                                                          if (state
                                                              is deleteinjectionloading)
                                                            return deleteloading();
                                                          return SizedBox(
                                                            height: 50,
                                                            width: 100,
                                                            child:
                                                                ElevatedButton(
                                                                    style:
                                                                        const ButtonStyle(
                                                                      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(
                                                                          255,
                                                                          37,
                                                                          163,
                                                                          42)),
                                                                    ),
                                                                    onPressed:
                                                                        () async {
                                                                      await BlocProvider.of<InjectionCubit>(context).deletereport(
                                                                          reportid: BlocProvider.of<InjectionCubit>(context)
                                                                              .productions[i]
                                                                              .id!);
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "تاكيد",
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              12,
                                                                          fontFamily:
                                                                              "cairo",
                                                                          color:
                                                                              Colors.white),
                                                                      textAlign:
                                                                          TextAlign
                                                                              .center,
                                                                    )),
                                                          );
                                                        },
                                                      ),
                                                      tittle:
                                                          "هل تريد الحذف ؟");
                                                },
                                                icon: Icon(
                                                  deleteicon,
                                                  color: Colors.red,
                                                ))),
                                      ),
                                  separatorBuilder: (context, i) => Divider(
                                        color: Colors.grey,
                                      ),
                                  itemCount:
                                      BlocProvider.of<InjectionCubit>(context)
                                          .productions
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
                        onTap: () {
                          navigateto(context: context, page: molds());
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        )),
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
                          navigateto(context: context, page: addreport());
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
