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
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:agman/features/materiales/presentation/views/addmaterial.dart';
import 'package:agman/features/materiales/presentation/views/widgets/customtablematerialitem.dart';
import 'package:agman/features/materiales/presentation/views/widgets/editdialog.dart';
import 'package:agman/features/materiales/presentation/views/widgets/plasticmaterialitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class plasticMaterial extends StatefulWidget {
  final String status;

  const plasticMaterial({super.key, required this.status});
  @override
  State<plasticMaterial> createState() => _plasticMaterialState();
}

class _plasticMaterialState extends State<plasticMaterial> {
  final materialheader = [
    "اسم الخامه",
    "الكميه قبل الجرد",
    "الكميه بعد الجرد",
    "الكميه الحاليه",
    "تعديل",
    "حذف",
  ];
  getdata() async {
    BlocProvider.of<plasticMaterialCubit>(context).queryparms = {
      "type": widget.status
    };
    BlocProvider.of<plasticMaterialCubit>(context).getMaterials(page: 1);
  }

  int index = 0;
  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: LayoutBuilder(builder: (context, constrains) {
          return Column(children: [
            Container(
              height: 50,
              color: appcolors.maincolor.withOpacity(0.7),
              child: Row(
                  children: materialheader
                      .map((e) => customheadertable(
                            textStyle:
                                Styles.getheadertextstyle(context: context),
                            title: e,
                            flex: e == "حذف" ||
                                    e == "تعديل" ||
                                    e == "عدد\nساعات التشغيل"
                                ? 2
                                : 3,
                          ))
                      .toList()),
            ),
            Expanded(
                child: BlocConsumer<plasticMaterialCubit, plasticMaterialState>(
              listener: (context, state) {
                if (state is GetMaterialsFailure)
                  showtoast(
                      context: context,
                      message: state.errormessage,
                      toaststate: Toaststate.error);
              },
              builder: (context, state) {
                if (state is GetMaterialsLoading) return loadingshimmer();
                if (state is GetMaterialsFailure)
                  return SizedBox();
                else {
                  if (BlocProvider.of<plasticMaterialCubit>(context)
                      .data
                      .isEmpty)
                    return nodata();
                  else
                    return ListView.separated(
                        itemBuilder: (context, i) => InkWell(
                              onTap: () {
                                navigateto(
                                    context: context,
                                    page: Plasticmaterialitem(
                                      materialtype:
                                          BlocProvider.of<plasticMaterialCubit>(
                                                      context)
                                                  .data[i]
                                                  .materialType ??
                                              "",
                                      materialid:
                                          BlocProvider.of<plasticMaterialCubit>(
                                                  context)
                                              .data[i]
                                              .id!,
                                      materialname:
                                          "${BlocProvider.of<plasticMaterialCubit>(context).data[i].name ?? ""} ${BlocProvider.of<plasticMaterialCubit>(context).data[i].materialType == "pure" ? "بيور" : BlocProvider.of<plasticMaterialCubit>(context).data[i].materialType == "kasr_elkasara" ? "كسر كساره" : BlocProvider.of<plasticMaterialCubit>(context).data[i].materialType == "el_mkhraz" ? "مخرز" : ""}",
                                      type:
                                          BlocProvider.of<plasticMaterialCubit>(
                                                      context)
                                                  .data[i]
                                                  .type ??
                                              "",
                                    ));
                              },
                              child: Customtablematerialitem(
                                datefrom: BlocProvider.of<plasticMaterialCubit>(
                                        context)
                                    .data[i]
                                    .dateFrom
                                    .toString(),
                                dateto: BlocProvider.of<plasticMaterialCubit>(
                                        context)
                                    .data[i]
                                    .dateTo
                                    .toString(),
                                textStyle:
                                    Styles.gettabletextstyle(context: context),
                                materialname:
                                    "${BlocProvider.of<plasticMaterialCubit>(context).data[i].name ?? ""} ${BlocProvider.of<plasticMaterialCubit>(context).data[i].materialType == "pure" ? "بيور" : BlocProvider.of<plasticMaterialCubit>(context).data[i].materialType == "kasr_elkasara" ? "كسر كساره" : BlocProvider.of<plasticMaterialCubit>(context).data[i].materialType == "el_mkhraz" ? "مخرز" : ""}",
                                quantity: BlocProvider.of<plasticMaterialCubit>(
                                            context)
                                        .data[i]
                                        .qty ??
                                    "".toString(),
                                delet: IconButton(
                                    onPressed: () {
                                      awsomdialogerror(
                                          context: context,
                                          mywidget: BlocConsumer<
                                              plasticMaterialCubit,
                                              plasticMaterialState>(
                                            listener: (context, state) {
                                              if (state
                                                  is DeleteMaterialSuccess) {
                                                Navigator.pop(context);

                                                showtoast(
                                                    message:
                                                        state.successmessage,
                                                    toaststate:
                                                        Toaststate.succes,
                                                    context: context);
                                              }
                                              if (state
                                                  is DeleteMaterialsFailure) {
                                                Navigator.pop(context);

                                                showtoast(
                                                    message: state.errormessage,
                                                    toaststate:
                                                        Toaststate.error,
                                                    context: context);
                                              }
                                            },
                                            builder: (context, state) {
                                              if (state
                                                  is DeleteMaterialsLoading)
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
                                                                  plasticMaterialCubit>(
                                                              context)
                                                          .deleteMaterial(
                                                              Materialid: BlocProvider
                                                                      .of<plasticMaterialCubit>(
                                                                          context)
                                                                  .data[i]
                                                                  .id!,
                                                              type: BlocProvider
                                                                      .of<plasticMaterialCubit>(
                                                                          context)
                                                                  .data[i]
                                                                  .materialType);
                                                    },
                                                    child: const Text(
                                                      "تاكيد",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily: "cairo",
                                                          color: Colors.white),
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
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color:
                                                          appcolors.maincolor,
                                                    )),
                                              ),
                                              contentPadding:
                                                  EdgeInsets.all(10),
                                              backgroundColor: Colors.white,
                                              insetPadding: EdgeInsets.all(35),
                                              content: Editmaterialdialog(
                                                  id: BlocProvider.of<
                                                              plasticMaterialCubit>(
                                                          context)
                                                      .data[i]
                                                      .id!,
                                                  type: BlocProvider.of<
                                                                  plasticMaterialCubit>(
                                                              context)
                                                          .data[i]
                                                          .materialType ??
                                                      "pure",
                                                  materialquantity:
                                                      TextEditingController(
                                                    text: BlocProvider.of<
                                                                plasticMaterialCubit>(
                                                            context)
                                                        .data[i]
                                                        .qty
                                                        .toString(),
                                                  )),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      editeicon,
                                    )),
                              ),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount:
                            BlocProvider.of<plasticMaterialCubit>(context)
                                .data
                                .length);
                }
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
                      navigateto(context: context, page: addmaterial());
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
        }));
  }
}
