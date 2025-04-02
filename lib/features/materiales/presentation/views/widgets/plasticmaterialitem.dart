import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/error.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:agman/features/materiales/presentation/views/widgets/addmaterialmotion.dart';
import 'package:agman/features/materiales/presentation/views/widgets/datesearch.dart';
import 'package:agman/features/materiales/presentation/views/widgets/materialmotion.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Plasticmaterialitem extends StatefulWidget {
  ScrollController nscrollController = ScrollController();

  final int materialid;
  final String materialname;
  final String type;
  String? materialtype;

  Plasticmaterialitem(
      {super.key,
      required this.materialid,
      required this.materialname,
      this.materialtype,
      required this.type});
  @override
  State<Plasticmaterialitem> createState() => _PlasticmaterialitemState();
}

class _PlasticmaterialitemState extends State<Plasticmaterialitem> {
  final componentheader = [
    "التاريخ",
    "الكميه",
    "الحاله",
    "رقم الاوردر-الاذن",
    "الملاحظات",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<plasticMaterialCubit>(context).firstloadingmotion = false;
    await BlocProvider.of<plasticMaterialCubit>(context).gematerialesmoves(
        materialid: widget.materialid, type: widget.materialtype);
    widget.nscrollController.addListener(() async {
      if (widget.nscrollController.position.pixels ==
          widget.nscrollController.position.maxScrollExtent) {
        await BlocProvider.of<plasticMaterialCubit>(context).gematerialesmoves(
            materialid: widget.materialid, type: widget.materialtype);
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
                              content: Datecomponentsearch(),
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
              title: Text(
                "حركات الخامه ${widget.materialname}",
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
                Expanded(child:
                    BlocBuilder<plasticMaterialCubit, plasticMaterialState>(
                  builder: (context, state) {
                    if (state is GetMaterialsmovesfailure)
                      return errorfailure(
                        errormessage: state.errormessage,
                      );
                    if (state is GetMaterialsmovesLoading)
                      return loadingshimmer();

                    return BlocProvider.of<plasticMaterialCubit>(context)
                            .datamoves
                            .isEmpty
                        ? nodata()
                        : ListView.separated(
                            itemBuilder: (context, i) => InkWell(
                                  onTap: () {},
                                  child: Materialmotion(
                                    textStyle: Styles.gettabletextstyle(
                                        context: context),
                                    ordernumber:
                                        BlocProvider.of<plasticMaterialCubit>(
                                                    context)
                                                .datamoves[i]
                                                .orderNum ??
                                            "",
                                    date: BlocProvider.of<plasticMaterialCubit>(
                                            context)
                                        .datamoves[i]
                                        .date!,
                                    quantity:
                                        BlocProvider.of<plasticMaterialCubit>(
                                                context)
                                            .datamoves[i]
                                            .qty!,
                                    status:
                                        BlocProvider.of<plasticMaterialCubit>(
                                                        context)
                                                    .datamoves[i]
                                                    .type ==
                                                "0"
                                            ? "سحب"
                                            : "اضافه",
                                    notes:
                                        BlocProvider.of<plasticMaterialCubit>(
                                                    context)
                                                .datamoves[i]
                                                .notes ??
                                            "لا يوجد",
                                    delet: IconButton(
                                        onPressed: () {
                                          awsomdialogerror(
                                              context: context,
                                              mywidget: BlocConsumer<
                                                  plasticMaterialCubit,
                                                  plasticMaterialState>(
                                                listener: (context, state) {
                                                  if (state
                                                      is deletematerialmovessuccess) {
                                                    Navigator.pop(context);

                                                    showtoast(
                                                        context: context,
                                                        message: state
                                                            .successmessage,
                                                        toaststate:
                                                            Toaststate.succes);
                                                  }
                                                  if (state
                                                      is deletematerialmovesfailure) {
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
                                                      is deletematerialmovesloading)
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
                                                                      plasticMaterialCubit>(
                                                                  context)
                                                              .deleteMaterialmoves(
                                                                  Materialid: BlocProvider.of<
                                                                              plasticMaterialCubit>(
                                                                          context)
                                                                      .datamoves[
                                                                          i]
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
                            itemCount:
                                BlocProvider.of<plasticMaterialCubit>(context)
                                    .datamoves
                                    .length);
                  },
                )),
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
                          navigateto(
                              context: context,
                              page: Addmaterialmotion(
                                materialid: widget.materialid,
                                materialname: widget.materialname,
                                type: widget.type,
                              ));
                        },
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
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ]);
            })));
  }
}
