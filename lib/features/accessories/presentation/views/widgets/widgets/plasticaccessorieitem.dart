import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:agman/features/accessories/presentation/views/widgets/widgets/accessoriemotion.dart';
import 'package:agman/features/accessories/presentation/views/widgets/widgets/datesearch.dart';
import 'package:agman/features/accessories/presentation/views/widgets/widgets/deleteorput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Plasticaccessorieitem extends StatefulWidget {
  ScrollController nscrollController = ScrollController();
  final int accessorieid;

  Plasticaccessorieitem({super.key, required this.accessorieid});

  @override
  State<Plasticaccessorieitem> createState() => _PlasticaccessorieitemState();
}

class _PlasticaccessorieitemState extends State<Plasticaccessorieitem> {
  final componentheader = [
    "التاريخ",
    "الكميه",
    "الحاله",
    "اسم الاسطمبه",
    "الملاحظات",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<plasticaccessoriesCubit>(context).firstloadingmotion =
        false;
    BlocProvider.of<plasticaccessoriesCubit>(context)
        .getaccessoriesmotion(accessorieid: widget.accessorieid);
    widget.nscrollController.addListener(() async {
      if (widget.nscrollController.position.pixels ==
          widget.nscrollController.position.maxScrollExtent) {
        await BlocProvider.of<plasticaccessoriesCubit>(context)
            .getmoreaccessoriesmotion(accessorieid: widget.accessorieid);
      }
    });
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
                              content: Dateaccessoriesearch(),
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
                "حركات الاكسسوار",
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
                      children: componentheader
                          .map((e) => customheadertable(
                                textStyle:
                                    Styles.getheadertextstyle(context: context),
                                title: e,
                                flex:
                                    e == "حذف" || e == "تعديل" || e == "الحاله"
                                        ? 2
                                        : 3,
                              ))
                          .toList()),
                ),
                Expanded(child: BlocBuilder<plasticaccessoriesCubit,
                    plasticaccessoriesState>(builder: (context, state) {
                  if (state is getaccessoriesmotionloading)
                    return loadingshimmer();
                  if (state is getaccessoriesmotionfailure)
                    return SizedBox();
                  else {
                    if (BlocProvider.of<plasticaccessoriesCubit>(context)
                        .alldata
                        .isEmpty) return nodata();

                    return ListView.separated(
                        controller: widget.nscrollController,
                        itemBuilder: (context, i) => i >=
                                BlocProvider.of<plasticaccessoriesCubit>(
                                        context)
                                    .alldata
                                    .length
                            ? loading()
                            : InkWell(
                                onTap: () {},
                                child: Accessoriemotion(
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  moldname:
                                      BlocProvider.of<plasticaccessoriesCubit>(
                                                      context)
                                                  .alldata[i]
                                                  .stamp_name ==
                                              null
                                          ? "لا يوجد"
                                          : BlocProvider.of<
                                                      plasticaccessoriesCubit>(
                                                  context)
                                              .alldata[i]
                                              .stamp_name!,
                                  date:
                                      BlocProvider.of<plasticaccessoriesCubit>(
                                              context)
                                          .alldata[i]
                                          .date!,
                                  quantity:
                                      BlocProvider.of<plasticaccessoriesCubit>(
                                              context)
                                          .alldata[i]
                                          .qty!
                                          .toString(),
                                  status:
                                      BlocProvider.of<plasticaccessoriesCubit>(
                                                      context)
                                                  .alldata[i]
                                                  .type ==
                                              0
                                          ? "اضافه"
                                          : "سحب",
                                  notes:
                                      BlocProvider.of<plasticaccessoriesCubit>(
                                                      context)
                                                  .alldata[i]
                                                  .notes ==
                                              null
                                          ? "لا يوجد"
                                          : BlocProvider.of<
                                                      plasticaccessoriesCubit>(
                                                  context)
                                              .alldata[i]
                                              .notes!,
                                  delet: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<
                                                plasticaccessoriesCubit,
                                                plasticaccessoriesState>(
                                              listener: (context, state) {
                                                if (state
                                                    is deleteaccessorienovesuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      context: context,
                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes);
                                                }
                                                if (state
                                                    is deleteaccessoriemovefailure) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      context: context,
                                                      message:
                                                          state.errormessage,
                                                      toaststate:
                                                          Toaststate.error);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is deleteaccessoriemoveloading)
                                                  return deleteloading();
                                                return SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color.fromARGB(
                                                                    255,
                                                                    37,
                                                                    163,
                                                                    42)),
                                                      ),
                                                      onPressed: () async {
                                                        await BlocProvider.of<
                                                                    plasticaccessoriesCubit>(
                                                                context)
                                                            .deleteaccessoriemove(
                                                                moveid: BlocProvider.of<
                                                                            plasticaccessoriesCubit>(
                                                                        context)
                                                                    .alldata[i]
                                                                    .id!);
                                                      },
                                                      child: const Text(
                                                        "تاكيد",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                );
                                              },
                                            ),
                                            tittle: "هل تريد حذف الحركه");
                                      },
                                      icon: Icon(
                                        color: Colors.red,
                                        deleteicon,
                                      )),
                                ),
                              ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<plasticaccessoriesCubit>(
                                        context)
                                    .motionloading ==
                                true
                            ? BlocProvider.of<plasticaccessoriesCubit>(context)
                                    .alldata
                                    .length +
                                1
                            : BlocProvider.of<plasticaccessoriesCubit>(context)
                                .alldata
                                .length);
                  }
                })),
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
                          navigateto(
                              context: context,
                              page: Deleteorput(
                                accessoreeid: widget.accessorieid,
                              ));
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
