import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/widgets/thousand.dart';
import 'package:agman/features/attendance/presentation/view/cuts/permession.dart';
import 'package:agman/features/attendance/presentation/view/holidays/holiday.dart';
import 'package:agman/features/attendance/presentation/view/money/money.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/view/widgets/costgridelement.dart';
import 'package:agman/features/workers/data/models/workermodel/datum.dart';
import 'package:agman/features/workers/presentation/views/widgets/workersmoves.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Attendancemoves extends StatelessWidget {
  final String workername;
  final int employerid;
  final Datum data;
  List<Map> costgrid = [
    {
      "desc": "ايام الحضور",
      "color": "0xff2f6d80",
    },
    {"desc": "ايام الاجازه", "color": "0xfffc3c80"},
    {"desc": "السلف - الحوافز", "color": "0xff821d80"},
    {"desc": "الغيابات - الخصومات", "color": "0xff821d40"},
    {"desc": "ساعات الاضافى", "color": "0xff821d54"},
  ];

  Attendancemoves(
      {super.key,
      required this.workername,
      required this.employerid,
      required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        actions: [],
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "حركات الموظف",
          style: TextStyle(
              color: Colors.white,
              fontFamily: "cairo",
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.count(
            childAspectRatio: 1 / 0.8,
            crossAxisCount: MediaQuery.sizeOf(context).width > 950
                ? 6
                : MediaQuery.sizeOf(context).width > 650
                    ? 4
                    : MediaQuery.sizeOf(context).width > 500
                        ? 3
                        : 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: costgrid
                .map((e) => Costgridelement(
                      color: int.parse(e["color"]),
                      desc: e["desc"],
                      cost: e["desc"] == "ايام الحضور"
                          ? "${data.totalAttendance!} يوم"
                          : e["desc"] == "ايام الاجازه"
                              ? "${data.totalVacation} يوم"
                              : e["desc"] == "السلف - الحوافز"
                                  ? "${gettext(value: data.totalCredit.toString())} ج- ${gettext(value: data.totalDebit.toString())} ج"
                                  : e["desc"] == "الغيابات - الخصومات"
                                      ? "${gettext(value: data.totalExtraTime.toString())} ساعه - ${gettext(value: data.totalPermissions.toString())} ساعه"
                                      : "5 ساعه",
                      onTap: () {
                        navigateto(
                            context: context,
                            page: e["desc"] == "ايام الحضور"
                                ? Workersmoves(
                                    year:
                                        "${BlocProvider.of<Attendancecuibt>(context).year}",
                                    workername: workername,
                                    month:
                                        "${BlocProvider.of<Attendancecuibt>(context).month}",
                                  )
                                : e["desc"] == "ايام الاجازه"
                                    ? Holiday(employerid: employerid)
                                    : e["desc"] == "السلف - الحوافز"
                                        ? money(
                                            employerid: employerid,
                                            month: BlocProvider.of<
                                                    Attendancecuibt>(context)
                                                .month!,
                                            year: BlocProvider.of<
                                                    Attendancecuibt>(context)
                                                .year!,
                                          )
                                        : permession(
                                            employename: "",
                                            employerid: employerid,
                                            month: BlocProvider.of<
                                                    Attendancecuibt>(context)
                                                .month!,
                                            year: BlocProvider.of<
                                                    Attendancecuibt>(context)
                                                .year!,
                                          ));
                      },
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
