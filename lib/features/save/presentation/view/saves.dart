import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/error.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/features/save/presentation/view/addtosave.dart';
import 'package:agman/features/save/presentation/view/widgets/alertcontent.dart';
import 'package:agman/features/save/presentation/view/widgets/customtabletimeritem.dart';
import 'package:agman/features/save/presentation/viewmodel/save/save_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class save extends StatefulWidget {
  @override
  State<save> createState() => _saveState();
}

class _saveState extends State<save> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final saveheader = [
    "التاريخ",
    "العمليه",
    "عميل - مورد",
    "المبلغ",
    "الموظف",
    "الملاحظات",
  ];

  getdata() async {
    BlocProvider.of<SaveCubit>(context).date =
        '${DateTime.now().year}-${DateTime.now().month < 10 ? "0${DateTime.now().month}" : DateTime.now().month}-${DateTime.now().day < 10 ? "0${DateTime.now().day}" : DateTime.now().day}';
    await BlocProvider.of<SaveCubit>(context).getsavemotion(
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
            floatingActionButton: FloatingActionButton(
                backgroundColor: appcolors.primarycolor,
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  navigateto(context: context, page: Addsave());
                }),
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
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
                              content: Alertsavecontent(),
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
                "المعاملات الماليه",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: BlocBuilder<SaveCubit, SaveState>(
              builder: (context, state) {
                if (state is getsaveloading) return loading();
                if (state is getsavefailure)
                  return errorfailure(errormessage: state.errormessage);
                return Column(children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        style: TextStyle(
                            fontFamily: "cairo",
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                        "التاريخ : ${BlocProvider.of<SaveCubit>(context).date}",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 100,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text(
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: "cairo",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              "الرصيد الحالي : ${BlocProvider.of<SaveCubit>(context).total ?? 0}",
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                            child: Text(
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: "cairo",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15),
                              "رصيد البحث : ${BlocProvider.of<SaveCubit>(context).totalsearch ?? 0}",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    color: appcolors.maincolor.withOpacity(0.7),
                    child: Row(
                        children: saveheader
                            .map((e) => customheadertable(
                                  textStyle: Styles.getheadertextstyle(
                                      context: context),
                                  title: e,
                                  flex: e == "عميل - مورد" || e == "العمليه"
                                      ? 2
                                      : 3,
                                ))
                            .toList()),
                  ),
                  Expanded(
                      child: RefreshIndicator(
                          onRefresh: () async {},
                          child: ListView.separated(
                              itemBuilder: (context, i) => InkWell(
                                    onTap: () {},
                                    child: Customtablesaveitem(
                                      date: BlocProvider.of<SaveCubit>(context)
                                              .data[i]
                                              .date ??
                                          "",
                                      employer:
                                          BlocProvider.of<SaveCubit>(context)
                                                  .data[i]
                                                  .employer ??
                                              "",
                                      type: BlocProvider.of<SaveCubit>(context)
                                                  .data[i]
                                                  .status ==
                                              0
                                          ? "سحب"
                                          : "ايداع",
                                      clientorcustomer:
                                          BlocProvider.of<SaveCubit>(context)
                                                  .data[i]
                                                  .client ??
                                              "",
                                      amountofmoney:
                                          BlocProvider.of<SaveCubit>(context)
                                                  .data[i]
                                                  .price ??
                                              "",
                                      notes: BlocProvider.of<SaveCubit>(context)
                                              .data[i]
                                              .notes ??
                                          "",
                                      textStyle: Styles.gettabletextstyle(
                                          context: context),
                                    ),
                                  ),
                              separatorBuilder: (context, i) => Divider(
                                    color: Colors.grey,
                                  ),
                              itemCount: BlocProvider.of<SaveCubit>(context)
                                  .data
                                  .length))),
                ]);
              },
            )));
  }
}
