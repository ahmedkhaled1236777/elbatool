import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/core/common/widgets/time.dart';
import 'package:agman/features/attendance/data/models/attendancemodelrequest.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';
import 'package:agman/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Editfingerprint extends StatelessWidget {
  final String date;
  final String year;
  final String month;
  final String status;
  final String employername;

  Editfingerprint(
      {required this.date,
      required this.status,
      required this.employername,
      required this.month,
      required this.year});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "تعديل بصمة ${status} ليوم ${date}",
                style: TextStyle(
                    fontSize: 12.5,
                    color: appcolors.maincolor,
                    fontFamily: "cairo"),
                textAlign: TextAlign.right,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              "وقت ${status}",
              style: TextStyle(color: appcolors.maincolor, fontFamily: "cairo"),
            ),
            SizedBox(
              height: 10,
            ),
            Time(
              inittime: DateTime.now(),
              onChange: (date) {
                BlocProvider.of<DateCubit>(context).changetimefrom(date);
              },
            ),
            SizedBox(
              height: 20,
            ),
            BlocConsumer<Attendancecuibt, Attendancestate>(
              listener: (context, state) async {
                if (state is editattendancefailure) {
                  showdialogerror(error: state.errormessage, context: context);
                }
                if (state is editattendencesuccess) {
                  await BlocProvider.of<WorkersCubit>(context).getworkersmoves(
                      workerid: employername, month: month, year: year);
                  showtoast(
                      message: state.successmessage,
                      toaststate: Toaststate.succes,
                      context: context);
                  Navigator.pop(context);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is editattendanceloading) return loading();
                return custommaterialbutton(
                    button_name: "تعديل البيانات",
                    onPressed: () async {
                      print(BlocProvider.of<DateCubit>(context).timefrom);
                      if (BlocProvider.of<DateCubit>(context).timefrom ==
                          "وقت البصمه") {
                        showdialogerror(
                            error: "برجاء اختيار وقت البصمه", context: context);
                      } else
                        BlocProvider.of<Attendancecuibt>(context).editattendance(
                            attendance: Attendancemodelrequest(
                                employername: employername,
                                status: status == "الانصراف" ? "1" : "0",
                                date: date,
                                time:
                                    "${BlocProvider.of<DateCubit>(context).timefrom}:00"));
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}
