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
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:agman/features/molds/presentation/views/widgets/addmold.dart';
import 'package:agman/features/molds/presentation/views/widgets/alertcontent.dart';
import 'package:agman/features/molds/presentation/views/widgets/customtabletimeritem.dart';
import 'package:agman/features/molds/presentation/views/widgets/editdialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class molds extends StatefulWidget {
  @override
  State<molds> createState() => _moldsState();
}

class _moldsState extends State<molds> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final moldsheader = [
    "اسم الاسطمبه",
    "زمن الدوره",
    "وزن المنتج",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    await BlocProvider.of<MoldCubit>(context).getmolds();
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
                  navigateto(context: context, page: Addmold());
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      BlocProvider.of<MoldCubit>(context).resetdata();
                    },
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
                              content: Alertmoldcontent(),
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
                "الاسطمبات",
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
                              flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: RefreshIndicator(
                onRefresh: () async {},
                child: BlocConsumer<MoldCubit, MoldState>(
                    listener: (context, state) {
                  if (state is GetMoldFailure)
                    showtoast(
                        message: state.errormessage,
                        toaststate: Toaststate.error,
                        context: context);
                }, builder: (context, state) {
                  if (state is GetMoldLoading) return loadingshimmer();
                  if (state is GetMoldFailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<MoldCubit>(context).molds.isEmpty)
                      return nodata();
                    else {
                      return ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {},
                                child: Customtablemolditem(
                                    textStyle: Styles.gettabletextstyle(
                                        context: context),
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
                                                          Navigator.of(context)
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
                                                  backgroundColor: Colors.white,
                                                  insetPadding:
                                                      EdgeInsets.all(35),
                                                  content: editmolddialog(
                                                      id: BlocProvider.of<
                                                                  MoldCubit>(
                                                              context)
                                                          .molds[i]
                                                          .id!,
                                                      moldname: TextEditingController(
                                                          text: BlocProvider.of<
                                                                      MoldCubit>(
                                                                  context)
                                                              .molds[i]
                                                              .name),
                                                      cycletime:
                                                          TextEditingController(
                                                        text: BlocProvider.of<
                                                                    MoldCubit>(
                                                                context)
                                                            .molds[i]
                                                            .periodTime
                                                            .toString(),
                                                      ),
                                                      weight:
                                                          TextEditingController(
                                                        text: BlocProvider.of<
                                                                    MoldCubit>(
                                                                context)
                                                            .molds[i]
                                                            .weight
                                                            .toString(),
                                                      )),
                                                );
                                              });
                                        },
                                        icon: Icon(editeicon)),
                                    mold: BlocProvider.of<MoldCubit>(context)
                                        .molds[i]
                                        .name!,
                                    time: BlocProvider.of<MoldCubit>(context)
                                        .molds[i]
                                        .periodTime!
                                        .toDouble(),
                                    weight: BlocProvider.of<MoldCubit>(context)
                                        .molds[i]
                                        .weight
                                        .toString(),
                                    delete: IconButton(
                                        onPressed: () {
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<MoldCubit,
                                                  MoldState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is DeletemoldSuccess) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        message: state
                                                            .successmessage,
                                                        toaststate:
                                                            Toaststate.succes,
                                                        context: context);
                                                  }
                                                  if (state
                                                      is DeletemoldsFailure) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        message:
                                                            state.errormessage,
                                                        toaststate:
                                                            Toaststate.error,
                                                        context: context);
                                                  }
                                                },
                                                builder: (context, state) {
                                                  if (state
                                                      is DeletemoldsLoading)
                                                    return deleteloading();
                                                  return SizedBox(
                                                    height: 50,
                                                    width: 100,
                                                    child: ElevatedButton(
                                                        style:
                                                            const ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStatePropertyAll(
                                                                  Color
                                                                      .fromARGB(
                                                                          255,
                                                                          37,
                                                                          163,
                                                                          42)),
                                                        ),
                                                        onPressed: () async {
                                                          await BlocProvider.of<
                                                                      MoldCubit>(
                                                                  context)
                                                              .deletemold(
                                                                  moldid: BlocProvider.of<
                                                                              MoldCubit>(
                                                                          context)
                                                                      .molds[i]
                                                                      .id!);
                                                        },
                                                        child: const Text(
                                                          "تاكيد",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              fontFamily:
                                                                  "cairo",
                                                              color:
                                                                  Colors.white),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )),
                                                  );
                                                },
                                              ),
                                              tittle: "هل تريد الحذف ؟");
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
                              BlocProvider.of<MoldCubit>(context).molds.length);
                    }
                  }
                }),
              )),
            ])));
  }
}
