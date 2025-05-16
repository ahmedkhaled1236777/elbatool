import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/error.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/features/attendance/presentation/view/holidays/Customtableholidayitem.dart';
import 'package:agman/features/attendance/presentation/view/holidays/addholiday.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Holiday extends StatefulWidget {
  final int employerid;

  const Holiday({super.key, required this.employerid});
  @override
  State<Holiday> createState() => _HolidayState();
}

class _HolidayState extends State<Holiday> {
  final permessionheader = ["التاريخ", "الملاحظات", "حذف"];

  getdata() async {
    await BlocProvider.of<Attendancecuibt>(context).getholiday(
      employerid: widget.employerid,
      year: BlocProvider.of<Attendancecuibt>(context).year!,
      month: BlocProvider.of<Attendancecuibt>(context).month!,
    );
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
          title: const Text(
            "الاجازات",
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
                        flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                      ),
                    )
                    .toList(),
              ),
            ),
            Expanded(
              child: BlocBuilder<Attendancecuibt, Attendancestate>(
                builder: (context, state) {
                  if (state is getholidayloading) return loadingshimmer();
                  if (state is getholidayfailure)
                    return errorfailure(errormessage: state.errormessage);
                  return BlocProvider.of<Attendancecuibt>(
                    context,
                  ).holidays.isEmpty
                      ? nodata()
                      : ListView.separated(
                          itemBuilder: (context, i) => Customtableholidayitem(
                            date: BlocProvider.of<Attendancecuibt>(
                              context,
                            ).holidays[i].date!,
                            notes: BlocProvider.of<Attendancecuibt>(
                              context,
                            ).holidays[i].notes!,
                            delete: IconButton(
                              onPressed: () {
                                awsomdialogerror(
                                  context: context,
                                  mywidget: BlocConsumer<Attendancecuibt,
                                      Attendancestate>(
                                    listener: (context, state) {
                                      if (state is deleteholidaysuccess) {
                                        Navigator.pop(context);

                                        showtoast(
                                          context: context,
                                          message: state.successmessage,
                                          toaststate: Toaststate.succes,
                                        );
                                      }
                                      if (state is deleteholidayfailure) {
                                        Navigator.pop(context);

                                        showtoast(
                                          context: context,
                                          message: state.errormessage,
                                          toaststate: Toaststate.error,
                                        );
                                      }
                                    },
                                    builder: (context, state) {
                                      if (state is deleteholidayloading)
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
                                                .deleteholiday(
                                                    id: BlocProvider.of<
                                                        Attendancecuibt>(
                                              context,
                                            ).holidays[i].id!);
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
                          ).holidays.length,
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
