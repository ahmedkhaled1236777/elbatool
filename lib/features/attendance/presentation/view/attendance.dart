import 'dart:io';

import 'package:agman/features/attendance/presentation/view/cuts/addpermession.dart';
import 'package:agman/features/attendance/presentation/view/holidays/addholiday.dart';
import 'package:agman/features/attendance/presentation/view/money/addmoney.dart';
import 'package:agman/features/attendance/presentation/view/widgets/attendancemoves.dart';
import 'package:agman/features/workers/presentation/views/addworker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/error.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:flutter/material.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/features/attendance/presentation/view/widgets/alertswarch.dart';
import 'package:agman/features/attendance/presentation/view/widgets/attendancepdf.dart';
import 'package:agman/features/attendance/presentation/view/widgets/customtableattendanceitem.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';
import 'package:agman/features/workers/presentation/views/widgets/workersmoves.dart';

class attendance extends StatefulWidget {
  @override
  State<attendance> createState() => _attendanceState();
}

class _attendanceState extends State<attendance> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  final attendanceheader = [
    "اسم\nالموظف",
    "ايام\nالحضور",
    "ايام\nالاجازه",
    "ايام\nالغياب",
    "الراتب",
    "عرض",
  ];

  getdata() async {
    BlocProvider.of<Attendancecuibt>(context).month =
        DateTime.now().month.toString();
    BlocProvider.of<Attendancecuibt>(context).year =
        DateTime.now().year.toString();

    await BlocProvider.of<Attendancecuibt>(context).getaattendance(queryparma: {
      "month": BlocProvider.of<Attendancecuibt>(context).month,
      "year": BlocProvider.of<Attendancecuibt>(context).year
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
                    onPressed: () async {
                      BlocProvider.of<Attendancecuibt>(context).month =
                          DateTime.now().month.toString();
                      BlocProvider.of<Attendancecuibt>(context).year =
                          DateTime.now().year.toString();
                      await BlocProvider.of<Attendancecuibt>(context)
                          .getaattendance(queryparma: {
                        "month":
                            BlocProvider.of<Attendancecuibt>(context).month,
                        "year": BlocProvider.of<Attendancecuibt>(context).year
                      });
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,

                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0)),
                              title: Container(
                                alignment: Alignment.topLeft,
                                child: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<DateCubit>(context)
                                          .cleardates();

                                      Navigator.of(context).pop();
                                    },
                                    icon: Icon(Icons.close)),
                              ),
                              content: diagramsearch());
                        },
                      );
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: BlocBuilder<Attendancecuibt, Attendancestate>(
                builder: (context, state) {
                  return Text(
                    "حضور وانصراف الموظفين \nلشهر ${BlocProvider.of<Attendancecuibt>(context).month}-${BlocProvider.of<Attendancecuibt>(context).year}",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "cairo",
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  );
                },
              ),
            ),
            floatingActionButton: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 15),
                  FloatingActionButton(
                    heroTag: "1",
                    backgroundColor: appcolors.primarycolor,
                    child: Text(
                      "pdf",
                      style:
                          TextStyle(fontFamily: "cairo", color: Colors.white),
                    ),
                    onPressed: () async {
                      final img =
                          await rootBundle.load('assets/images/logo.jpeg');
                      final imageBytes = img.buffer.asUint8List();
                      File file = await Attendancepdf.generatepdf(
                          context: context,
                          imageBytes: imageBytes,
                          date:
                              "${BlocProvider.of<Attendancecuibt>(context).month}-${BlocProvider.of<Attendancecuibt>(context).year}",
                          categories: BlocProvider.of<Attendancecuibt>(context)
                              .attendances);
                      Attendancepdf.openfile(file);
                    },
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton(
                    heroTag: "2",
                    backgroundColor: appcolors.primarycolor,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        " الغياب\nوالخصم ",
                        style:
                            TextStyle(fontFamily: "cairo", color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      navigateto(context: context, page: Addpermession());
                    },
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton(
                    heroTag: "4",
                    backgroundColor: appcolors.primarycolor,
                    child: FittedBox(
                      child: Text(
                        " الاجازات ",
                        style:
                            TextStyle(fontFamily: "cairo", color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      navigateto(context: context, page: Addholiday());
                    },
                  ),
                  SizedBox(width: 10),
                  FloatingActionButton(
                    heroTag: "5",
                    backgroundColor: appcolors.primarycolor,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Text(
                        " السلف \nوالحوافز ",
                        style:
                            TextStyle(fontFamily: "cairo", color: Colors.white),
                      ),
                    ),
                    onPressed: () async {
                      navigateto(context: context, page: Addmoney());
                    },
                  ),
                ],
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: appcolors.maincolor.withOpacity(0.7),
                child: Row(
                    children: attendanceheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "ايام\nالحضور" ||
                                      e == "ساعات\nالاضافى" ||
                                      e == "ايام\nالغياب" ||
                                      e == "ايام\nالاجازه" ||
                                      e == "عرض" ||
                                      e == "ساعات\nالاذن"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(child: BlocBuilder<Attendancecuibt, Attendancestate>(
                builder: (context, state) {
                  if (state is attendanceloading) return loadingshimmer();
                  if (state is attendancefailure)
                    return errorfailure(errormessage: state.errormessage);
                  return BlocProvider.of<Attendancecuibt>(context)
                          .attendances
                          .isEmpty
                      ? nodata()
                      : ListView.separated(
                          itemBuilder: (context, i) => InkWell(
                                onTap: () {
                                  navigateto(
                                      context: context,
                                      page: Attendancemoves(
                                        data: BlocProvider.of<Attendancecuibt>(
                                                context)
                                            .attendances[i],
                                        employerid:
                                            BlocProvider.of<Attendancecuibt>(
                                                    context)
                                                .attendances[i]
                                                .id!
                                                .toInt(),
                                        workername:
                                            BlocProvider.of<Attendancecuibt>(
                                                    context)
                                                .attendances[i]
                                                .name!,
                                      ));
                                },
                                child: Customtableattendanceitem(
                                    pdf: IconButton(
                                        onPressed: () async {
                                          final img = await rootBundle
                                              .load('assets/images/logo.jpeg');
                                          final imageBytes =
                                              img.buffer.asUint8List();
                                          File file =
                                              await Attendancepdf.generatepdf(
                                                  context: context,
                                                  imageBytes: imageBytes,
                                                  date:
                                                      "${BlocProvider.of<Attendancecuibt>(context).month}-${BlocProvider.of<Attendancecuibt>(context).year}",
                                                  categories: [
                                                BlocProvider.of<
                                                            Attendancecuibt>(
                                                        context)
                                                    .attendances[i]
                                              ]);
                                          Attendancepdf.openfile(file);
                                        },
                                        icon: Icon(
                                          color: appcolors.primarycolor,
                                          Icons.picture_as_pdf,
                                        )),
                                    employeename: BlocProvider.of<Attendancecuibt>(context).attendances[i].name == null
                                        ? ""
                                        : BlocProvider.of<Attendancecuibt>(context)
                                            .attendances[i]
                                            .name
                                            .toString(),
                                    attendancedays: BlocProvider.of<Attendancecuibt>(context)
                                                .attendances[i]
                                                .totalAttendance ==
                                            null
                                        ? ""
                                        : BlocProvider.of<Attendancecuibt>(context)
                                            .attendances[i]
                                            .totalAttendance
                                            .toString(),
                                    weekenddays: BlocProvider.of<Attendancecuibt>(context).attendances[i].totalVacation == null
                                        ? ""
                                        : BlocProvider.of<Attendancecuibt>(context)
                                            .attendances[i]
                                            .totalVacation
                                            .toString(),
                                    notattendacedays: BlocProvider.of<Attendancecuibt>(context).attendances[i].totalAbsence == null
                                        ? ""
                                        : BlocProvider.of<Attendancecuibt>(context)
                                            .attendances[i]
                                            .totalAbsence
                                            .toString(),
                                    salary: BlocProvider.of<Attendancecuibt>(context).getsalary(
                                        BlocProvider.of<Attendancecuibt>(context).attendances[i],
                                        int.parse(BlocProvider.of<Attendancecuibt>(context).year!),
                                        int.parse(BlocProvider.of<Attendancecuibt>(context).month!)),
                                    textStyle: Styles.gettabletextstyle(context: context)),
                              ),
                          separatorBuilder: (context, i) => Divider(
                                color: Colors.grey,
                              ),
                          itemCount: BlocProvider.of<Attendancecuibt>(context)
                              .attendances
                              .length);
                },
              )),
              SizedBox(
                height: 70,
              )
            ])));
  }
}
