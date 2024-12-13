import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/features/moldmanufacture/presentation/view/addmoldmanufacture.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/view/machinescost.dart';
import 'package:agman/features/moldmanufacture/presentation/view/widgets/cost.dart';
import 'package:agman/features/moldmanufacture/presentation/view/widgets/customtablemoldmanufacture.dart';
import 'package:agman/features/moldmanufacture/presentation/view/widgets/editstamp.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/coststates.dart';
import 'package:agman/features/molds/presentation/views/widgets/alertcontent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class moldmanufacture extends StatefulWidget {
  ScrollController scrollController = ScrollController();

  @override
  State<moldmanufacture> createState() => _moldmanufactureState();
}

class _moldmanufactureState extends State<moldmanufacture> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final moldsheader = [
    "التاريخ",
    "اسم الاسطمبه",
    "اسم العميل",
    "الملاحظات",
    "تعديل",
    "حذف",
  ];

  getdata() async {
    BlocProvider.of<Costcuibt>(context).firstloading = false;
    BlocProvider.of<Costcuibt>(context).queryparms = null;
    BlocProvider.of<Costcuibt>(context).getmoldmanufacture();
    widget.scrollController.addListener(() async {
      if (widget.scrollController.position.pixels ==
          widget.scrollController.position.maxScrollExtent) {
        await BlocProvider.of<Costcuibt>(context).getmoremoldsmanufacture();
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
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 5,
                ),
                FloatingActionButton(
                    heroTag: "ll",
                    backgroundColor: appcolors.primarycolor,
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      navigateto(context: context, page: Addmoldmanufacture());
                    }),
                SizedBox(
                  width: 5,
                ),
                FloatingActionButton(
                    heroTag: "h",
                    backgroundColor: appcolors.primarycolor,
                    child: Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      navigateto(context: context, page: Machinescost());
                    }),
              ],
            ),
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
                "تصنيع الاسطمبات",
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
              Expanded(child:
                  BlocBuilder<Costcuibt, Coststates>(builder: (context, state) {
                if (state is getmoldsmanufactureloading)
                  return loadingshimmer();
                if (state is getmoldsmanufacturefailure)
                  return SizedBox();
                else {
                  if (BlocProvider.of<Costcuibt>(context).data.isEmpty)
                    return nodata();

                  return ListView.separated(
                      controller: widget.scrollController,
                      itemBuilder: (context, i) => i >=
                              BlocProvider.of<Costcuibt>(context).data.length
                          ? loading()
                          : InkWell(
                              onTap: () {
                                navigateto(
                                    context: context,
                                    page: Cost(
                                      stampid:
                                          BlocProvider.of<Costcuibt>(context)
                                              .data[i]
                                              .id!,
                                      intialcost: BlocProvider.of<Costcuibt>(
                                                      context)
                                                  .data[i]
                                                  .initialCost ==
                                              null
                                          ? "0"
                                          : BlocProvider.of<Costcuibt>(context)
                                              .data[i]
                                              .initialCost
                                              .toString(),
                                      accessoriescost:
                                          BlocProvider.of<Costcuibt>(context)
                                                      .data[i]
                                                      .accessoryInitial ==
                                                  null
                                              ? "0"
                                              : BlocProvider.of<Costcuibt>(
                                                      context)
                                                  .data[i]
                                                  .accessoryInitial
                                                  .toString(),
                                      manufacturecost:
                                          BlocProvider.of<Costcuibt>(context)
                                                      .data[i]
                                                      .industrialCost ==
                                                  null
                                              ? "0"
                                              : BlocProvider.of<Costcuibt>(
                                                      context)
                                                  .data[i]
                                                  .industrialCost
                                                  .toString(),
                                    ));
                              },
                              child: Customtablemoldmanufacutreitem(
                                  notes: BlocProvider.of<Costcuibt>(context)
                                      .data[i]
                                      .notes!,
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  edit: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0)),
                                                title: Container(
                                                  height: 20,
                                                  alignment: Alignment.topLeft,
                                                  child: IconButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    DateCubit>(
                                                                context)
                                                            .date1 = BlocProvider
                                                                .of<Costcuibt>(
                                                                    context)
                                                            .data[i]
                                                            .date!;
                                                        Navigator.pop(context);
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
                                                insetPadding:
                                                    EdgeInsets.all(35),
                                                content: Editstamp(
                                                    name: TextEditingController(
                                                        text: BlocProvider.of<Costcuibt>(context)
                                                            .data[i]
                                                            .name!),
                                                    clientname:
                                                        TextEditingController(
                                                            text: BlocProvider
                                                                    .of<Costcuibt>(
                                                                        context)
                                                                .data[i]
                                                                .clientName),
                                                    notes: TextEditingController(
                                                        text:
                                                            BlocProvider.of<Costcuibt>(context)
                                                                .data[i]
                                                                .notes!),
                                                    stampid: BlocProvider.of<
                                                            Costcuibt>(context)
                                                        .data[i]
                                                        .id!),
                                              );
                                            });
                                      },
                                      icon: Icon(editeicon)),
                                  moldname: BlocProvider.of<Costcuibt>(context)
                                      .data[i]
                                      .name!,
                                  date: BlocProvider.of<Costcuibt>(context)
                                      .data[i]
                                      .date!,
                                  clientname:
                                      BlocProvider.of<Costcuibt>(context)
                                          .data[i]
                                          .clientName!,
                                  delete: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<Costcuibt,
                                                Coststates>(
                                              listener: (context, state) {
                                                if (state
                                                    is deletemoldmanufacturesuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      context: context,
                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes);
                                                }
                                                if (state
                                                    is deletemoldmanufacturefailure) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      context: context,
                                                      message:
                                                          state.errrormessage,
                                                      toaststate:
                                                          Toaststate.error);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is deletemoldmanufactureloading)
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
                                                                    Costcuibt>(
                                                                context)
                                                            .deletemoldmanufacture(
                                                                stampid: BlocProvider.of<
                                                                            Costcuibt>(
                                                                        context)
                                                                    .data[i]
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
                                            tittle:
                                                "هل تريد حذف  ${BlocProvider.of<Costcuibt>(context).data[i].name}");
                                      },
                                      icon: Icon(
                                        deleteicon,
                                        color: Colors.red,
                                      ))),
                            ),
                      separatorBuilder: (context, i) => Divider(
                            color: Colors.grey,
                          ),
                      itemCount: BlocProvider.of<Costcuibt>(context).loading ==
                              true
                          ? BlocProvider.of<Costcuibt>(context).data.length + 1
                          : BlocProvider.of<Costcuibt>(context).data.length);
                }
              }))
            ])));
  }
}
