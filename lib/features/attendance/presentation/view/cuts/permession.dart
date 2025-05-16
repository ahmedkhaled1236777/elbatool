import 'dart:io';

import 'package:agman/core/common/navigation.dart';
import 'package:agman/features/attendance/presentation/view/cuts/Customtablepermessionitem.dart';
import 'package:agman/features/attendance/presentation/view/cuts/addpermession.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/error.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';

class permession extends StatefulWidget {
  final String month;
  final String year;
  final int employerid;
  final String employename;

  const permession(
      {super.key,
      required this.month,
      required this.year,
      required this.employename,
      required this.employerid});
  @override
  State<permession> createState() => _permessionState();
}

class _permessionState extends State<permession> {
  final permessionheader = [
    "اليوم",
    "الحاله",
    "عدد الساعات",
    "الملاحظات",
    "حذف"
  ];

  getdata() async {
    await BlocProvider.of<Attendancecuibt>(context).getpermessions(
        employerid: widget.employerid, month: widget.month, year: widget.year);
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
          leading: BackButton(color: Colors.white),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: Text(
            "الغياب والخصومات \n لشهر ${widget.month} - ${widget.year}",
            style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 50,
              color: appcolors.maincolor.withOpacity(0.7),
              child: Row(
                children: permessionheader
                    .map(
                      (e) => customheadertable(
                        textStyle: Styles.getheadertextstyle(context: context),
                        title: e,
                        flex: e == "الحاله" || e == "حذف" ? 2 : 3,
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: BlocBuilder<Attendancecuibt, Attendancestate>(
                builder: (context, state) {
                  if (state is getpermessionloading) return loadingshimmer();
                  if (state is getpermessionfailure)
                    return errorfailure(errormessage: state.errormessage);
                  return BlocProvider.of<Attendancecuibt>(context)
                          .permessions
                          .isEmpty
                      ? nodata()
                      : ListView.separated(
                          itemBuilder: (context, i) =>
                              Customtablepermessionitem(
                            status: BlocProvider.of<Attendancecuibt>(
                                      context,
                                    ).permessions[i].status ==
                                    0
                                ? "خصم"
                                : "غياب",
                            date: BlocProvider.of<Attendancecuibt>(
                              context,
                            ).permessions[i].date!.toString(),
                            hours: BlocProvider.of<Attendancecuibt>(
                              context,
                            ).permessions[i].numberOfHours!.toString(),
                            notes: BlocProvider.of<Attendancecuibt>(
                              context,
                            ).permessions[i].notes!,
                            delete: IconButton(
                              onPressed: () {
                                awsomdialogerror(
                                  context: context,
                                  mywidget: BlocConsumer<Attendancecuibt,
                                      Attendancestate>(
                                    listener: (context, state) {
                                      if (state is deletepermessionsuccess) {
                                        Navigator.pop(context);

                                        showtoast(
                                          message: state.successmessage,
                                          toaststate: Toaststate.succes,
                                          context: context,
                                        );
                                      }
                                      if (state is deletepermessionfailure) {
                                        Navigator.pop(context);

                                        showtoast(
                                          message: state.errormessage,
                                          toaststate: Toaststate.error,
                                          context: context,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is deletepermessionloading)
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
                                                42,
                                              ),
                                            ),
                                          ),
                                          onPressed: () async {
                                            await BlocProvider.of<
                                                    Attendancecuibt>(context)
                                                .deletepermession(
                                                    id: BlocProvider.of<
                                                                Attendancecuibt>(
                                                            context)
                                                        .permessions[i]
                                                        .id!);
                                          },
                                          child: const Text(
                                            "تاكيد",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "cairo",
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  tittle: "هل تريد الحذف ؟",
                                );
                              },
                              icon: Icon(deleteicon, color: Colors.red),
                            ),
                          ),
                          separatorBuilder: (context, i) =>
                              Divider(color: Colors.grey),
                          itemCount: BlocProvider.of<Attendancecuibt>(
                            context,
                          ).permessions.length,
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
