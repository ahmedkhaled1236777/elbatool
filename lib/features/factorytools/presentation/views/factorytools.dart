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
import 'package:agman/features/factorytools/presentation/viewmodel/factorytools/factorytools_cubit.dart';
import 'package:agman/features/factorytools/presentation/views/addfactorytools.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/alertcontent.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/customtablefactorytoolitem.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/editdialog.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/factorytoolitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Factorytools extends StatefulWidget {
  @override
  State<Factorytools> createState() => _FactorytoolsState();
}

class _FactorytoolsState extends State<Factorytools> {
  final accessoriesheader = [
    "اسم الاداه",
    "اجمالي الشراء",
    "اجمالي الاستهلاك",
    "اجمالي البيع",
    "الكميه",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<FactorytoolsCubit>(context).getfactorytools();
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
                              content: alertfactorytoolcontent(),
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
                "مخزن ادوات المصنع",
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
                      children: accessoriesheader
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
                    child: RefreshIndicator(
                        onRefresh: () async {},
                        child:
                            BlocBuilder<FactorytoolsCubit, FactorytoolsState>(
                          builder: (context, state) {
                            if (state is gettoolloading)
                              return loadingshimmer();
                            if (state is gettoolfailure) return SizedBox();
                            return BlocProvider.of<FactorytoolsCubit>(context)
                                    .data
                                    .isEmpty
                                ? nodata()
                                : ListView.separated(
                                    itemBuilder: (context, i) => InkWell(
                                          onTap: () {
                                            navigateto(
                                                context: context,
                                                page: Factorytoolitem(
                                                  id: BlocProvider.of<
                                                              FactorytoolsCubit>(
                                                          context)
                                                      .data[i]
                                                      .id!,
                                                ));
                                          },
                                          child: Customtablefactorytoolitem(
                                            totalbuy: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .data[i]
                                                .buyQty
                                                .toString(),
                                            totalconsume: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .data[i]
                                                .dilapidatedQty
                                                .toString(),
                                            totalsell: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .data[i]
                                                .salesQty
                                                .toString(),
                                            textStyle: Styles.gettabletextstyle(
                                                context: context),
                                            factorytoolname: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .data[i]
                                                .name!,
                                            quantity: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .data[i]
                                                .qty!,
                                            delet: IconButton(
                                                onPressed: () {
                                                  awsomdialogerror(
                                                      context: context,
                                                      mywidget: BlocConsumer<
                                                          FactorytoolsCubit,
                                                          FactorytoolsState>(
                                                        listener:
                                                            (context, state) {
                                                          if (state
                                                              is deletetoolsuccess) {
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
                                                              is deletetoolfailure) {
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
                                                              is deletetoolloading)
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
                                                                      await BlocProvider.of<FactorytoolsCubit>(
                                                                              context)
                                                                          .deletetool(
                                                                        factorytoolid: BlocProvider.of<FactorytoolsCubit>(context)
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
                                                            alignment: Alignment
                                                                .topLeft,
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
                                                              EdgeInsets.all(
                                                                  10),
                                                          backgroundColor:
                                                              Colors.white,
                                                          insetPadding:
                                                              EdgeInsets.all(
                                                                  35),
                                                          content:
                                                              Editfactorytooldialog(
                                                                  id: BlocProvider.of<
                                                                              FactorytoolsCubit>(
                                                                          context)
                                                                      .data[i]
                                                                      .id!,
                                                                  factorytoolname: TextEditingController(
                                                                      text: BlocProvider.of<FactorytoolsCubit>(
                                                                              context)
                                                                          .data[
                                                                              i]
                                                                          .name!),
                                                                  factorytoolquantity:
                                                                      TextEditingController(
                                                                    text: BlocProvider.of<FactorytoolsCubit>(
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
                                        BlocProvider.of<FactorytoolsCubit>(
                                                context)
                                            .data
                                            .length);
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
                          navigateto(context: context, page: Addfactorytools());
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
