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
import 'package:agman/features/accessories/presentation/views/addaccessories.dart';
import 'package:agman/features/accessories/presentation/views/widgets/alertcontent.dart';
import 'package:agman/features/accessories/presentation/views/widgets/customtableaccessorieitem.dart';
import 'package:agman/features/accessories/presentation/views/widgets/editdialog.dart';
import 'package:agman/features/accessories/presentation/views/widgets/widgets/plasticaccessorieitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class accessories extends StatefulWidget {
  ScrollController scrollController = ScrollController();

  @override
  State<accessories> createState() => _accessoriesState();
}

class _accessoriesState extends State<accessories> {
  final accessoriesheader = [
    "اسم الاكسسوار",
    "الكميه",
    "سعر البيع",
    "سعر الشراء",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<plasticaccessoriesCubit>(context).getaccessories();
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
                    onPressed: () async {
                      BlocProvider.of<plasticaccessoriesCubit>(context)
                          .firstloading = false;
                      BlocProvider.of<plasticaccessoriesCubit>(context)
                          .queryparms = null;
                      await BlocProvider.of<plasticaccessoriesCubit>(context)
                          .getaccessories();
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
                              content: Alertaccessoriescontent(),
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
                "مخزن الاكسسوارات",
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
                        child: BlocBuilder<plasticaccessoriesCubit,
                            plasticaccessoriesState>(builder: (context, state) {
                          if (state is getaccessoriesloading)
                            return loadingshimmer();
                          if (state is getaccessoriesfailure)
                            return SizedBox();
                          else {
                            if (BlocProvider.of<plasticaccessoriesCubit>(
                                    context)
                                .data
                                .isEmpty) return nodata();

                            return ListView.separated(
                                controller: widget.scrollController,
                                itemBuilder: (context, i) => InkWell(
                                      onTap: () {
                                        navigateto(
                                            context: context,
                                            page: Plasticaccessorieitem(
                                              accessorieid: BlocProvider.of<
                                                          plasticaccessoriesCubit>(
                                                      context)
                                                  .data[i]
                                                  .id!,
                                            ));
                                      },
                                      child: Customtableaccessoriesitem(
                                          sell: BlocProvider.of<
                                                      plasticaccessoriesCubit>(
                                                  context)
                                              .data[i]
                                              .sellPrice
                                              .toString(),
                                          buy: BlocProvider.of<
                                                      plasticaccessoriesCubit>(
                                                  context)
                                              .data[i]
                                              .buyPrice
                                              .toString(),
                                          textStyle: Styles.gettabletextstyle(
                                              context: context),
                                          accessoriesname: BlocProvider.of<
                                                      plasticaccessoriesCubit>(
                                                  context)
                                              .data[i]
                                              .name
                                              .toString(),
                                          quantity: BlocProvider.of<
                                                      plasticaccessoriesCubit>(
                                                  context)
                                              .data[i]
                                              .qty
                                              .toString(),
                                          delet: IconButton(
                                              onPressed: () {
                                                awsomdialogerror(
                                                    context: context,
                                                    mywidget: BlocConsumer<
                                                        plasticaccessoriesCubit,
                                                        plasticaccessoriesState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is deleteaccessoriesuccess) {
                                                          Navigator.pop(
                                                              context);

                                                          showtoast(
                                                              context: context,
                                                              message: state
                                                                  .successmessage,
                                                              toaststate:
                                                                  Toaststate
                                                                      .succes);
                                                        }
                                                        if (state
                                                            is deleteaccessoriefailure) {
                                                          Navigator.pop(
                                                              context);

                                                          showtoast(
                                                              context: context,
                                                              message: state
                                                                  .errormessage,
                                                              toaststate:
                                                                  Toaststate
                                                                      .error);
                                                        }
                                                      },
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is deleteaccessorieloading)
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
                                                                await BlocProvider.of<
                                                                            plasticaccessoriesCubit>(
                                                                        context)
                                                                    .deleteaccessorie(
                                                                        accessorieid: BlocProvider.of<plasticaccessoriesCubit>(context)
                                                                            .data[i]
                                                                            .id!);
                                                              },
                                                              child: const Text(
                                                                "تاكيد",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              )),
                                                        );
                                                      },
                                                    ),
                                                    tittle:
                                                        "هل تريد حذف  ${BlocProvider.of<plasticaccessoriesCubit>(context).data[i].name}");
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
                                                        shape:
                                                            RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            0)),
                                                        title: Container(
                                                          height: 20,
                                                          alignment:
                                                              Alignment.topLeft,
                                                          child: IconButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
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
                                                        content: Editaccessoriesdialog(
                                                            accessoriesname:
                                                                TextEditingController(
                                                                    text: BlocProvider.of<plasticaccessoriesCubit>(context)
                                                                        .data[i]
                                                                        .name!),
                                                            quantity: TextEditingController(
                                                                text: BlocProvider.of<plasticaccessoriesCubit>(context)
                                                                    .data[i]
                                                                    .qty
                                                                    .toString()!),
                                                            sellmoney: TextEditingController(
                                                                text: BlocProvider.of<plasticaccessoriesCubit>(context)
                                                                    .data[i]
                                                                    .sellPrice!),
                                                            buymoney: TextEditingController(
                                                                text: BlocProvider.of<plasticaccessoriesCubit>(
                                                                        context)
                                                                    .data[i]
                                                                    .buyPrice!),
                                                            accessorieid:
                                                                BlocProvider.of<plasticaccessoriesCubit>(
                                                                        context)
                                                                    .data[i]
                                                                    .id!),
                                                      );
                                                    });
                                              },
                                              icon: Icon(editeicon))),
                                    ),
                                separatorBuilder: (context, i) => Divider(
                                      color: Colors.grey,
                                    ),
                                itemCount:
                                    BlocProvider.of<plasticaccessoriesCubit>(
                                            context)
                                        .data
                                        .length);
                          }
                        }))),
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
                          navigateto(context: context, page: addaccessories());
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
