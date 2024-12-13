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
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/presentation/view/Addindusterialcost.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/presentation/view/industerialcostitem.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/presentation/viewmodel/cubit/industerialcostcuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/presentation/viewmodel/cubit/industerialcoststste.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Industerialcost extends StatefulWidget {
  final int stampid;

  const Industerialcost({super.key, required this.stampid});
  @override
  State<Industerialcost> createState() => _IndusterialcostState();
}

class _IndusterialcostState extends State<Industerialcost> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final moldsheader = [
    "التاريخ",
    "اسم الاسطمبه",
    "عدد/nالساعات",
    "التكلفه",
    "الملاحظات",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<IndusterialcostCubit>(context)
        .getindusterialcost(stampid: widget.stampid);
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
            floatingActionButton: FloatingActionButton(
                backgroundColor: appcolors.primarycolor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  navigateto(
                      context: context,
                      page: Addindusterialcost(
                        stampid: widget.stampid,
                      ));
                }),
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
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "تكلفة التصنيع",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: appcolors.maincolor.withOpacity(0.7),
                child: Row(
                    children: moldsheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "تعديل" ||
                                      e == "حذف" ||
                                      e == "عدد/nالساعات"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                child: RefreshIndicator(
                    onRefresh: () async {},
                    child: BlocBuilder<IndusterialcostCubit,
                        myIndusterialcostState>(
                      builder: (context, state) {
                        if (state is getmyIndusterialcostloading)
                          return loadingshimmer();
                        else if (state is getmyIndusterialcostfailure)
                          return SizedBox();
                        else {
                          return BlocProvider.of<IndusterialcostCubit>(context)
                                  .data
                                  .isEmpty
                              ? nodata()
                              : ListView.separated(
                                  itemBuilder: (context, i) => InkWell(
                                        onTap: () {},
                                        child: Industerialcostitem(
                                            machinename:
                                                BlocProvider.of<IndusterialcostCubit>(context)
                                                        .data[i]
                                                        .machineName ??
                                                    "",
                                            notes:
                                                BlocProvider.of<IndusterialcostCubit>(context)
                                                    .data[i]
                                                    .notes!,
                                            textStyle: Styles.gettabletextstyle(
                                                context: context),
                                            edit: IconButton(
                                                onPressed: () {},
                                                icon: Icon(editeicon)),
                                            numberofhours:
                                                BlocProvider.of<IndusterialcostCubit>(context)
                                                    .data[i]
                                                    .numberHours!
                                                    .toString(),
                                            cost:
                                                BlocProvider.of<IndusterialcostCubit>(context)
                                                    .data[i]
                                                    .totalPrice!,
                                            date: BlocProvider.of<
                                                    IndusterialcostCubit>(context)
                                                .data[i]
                                                .date!,
                                            delete: IconButton(
                                                onPressed: () {
                                                  awsomdialogerror(
                                                      context: context,
                                                      mywidget: BlocConsumer<
                                                          IndusterialcostCubit,
                                                          myIndusterialcostState>(
                                                        listener:
                                                            (context, state) {
                                                          if (state
                                                              is deletemyIndusterialcostsuccess) {
                                                            BlocProvider.of<
                                                                        Costcuibt>(
                                                                    context)
                                                                .getmoldmanufacture();
                                                            Navigator.pop(
                                                                context);

                                                            showtoast(
                                                                message: state
                                                                    .successmessage,
                                                                toaststate:
                                                                    Toaststate
                                                                        .succes,
                                                                context:
                                                                    context);
                                                          }
                                                          if (state
                                                              is deletemyIndusterialcostfailure) {
                                                            Navigator.pop(
                                                                context);

                                                            showtoast(
                                                                message: state
                                                                    .failuremessage,
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
                                                              is deletemyIndusterialcostloading)
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
                                                                      await BlocProvider.of<IndusterialcostCubit>(
                                                                              context)
                                                                          .deleteIndusterialcost(
                                                                        id: BlocProvider.of<IndusterialcostCubit>(context)
                                                                            .data[i]
                                                                            .id!,
                                                                      );
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
                                      BlocProvider.of<IndusterialcostCubit>(
                                              context)
                                          .data
                                          .length);
                        }
                      },
                    )),
              )
            ])));
  }
}
