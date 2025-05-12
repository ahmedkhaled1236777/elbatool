import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/view/widgets/costgridelement.dart';
import 'package:agman/features/workers/presentation/views/widgets/workersmoves.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Attendancemoves extends StatelessWidget {
  final String workername;
  List<Map> costgrid = [
    {
      "desc": "ساعات العمل",
      "color": "0xff2f6d80",
    },
    {"desc": "ايام الغياب", "color": "0xff6aa4b0"},
    {"desc": "ايام الاجازه", "color": "0xfffc3c80"},
    {"desc": "السلف", "color": "0xff821d80"},
    {"desc": "الخصومات", "color": "0xff821d10"},
    {"desc": "ساعات الاضافي", "color": "0xff821d20"},
    {"desc": "ساعات الاذن", "color": "0xff821d50"},
  ];

  Attendancemoves({super.key, required this.workername});
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
                      cost: "4",
                      onTap: () {
                        navigateto(
                            context: context,
                            page: Workersmoves(
                              year:
                                  "${BlocProvider.of<Attendancecuibt>(context).year}",
                              workername: workername,
                              month:
                                  "${BlocProvider.of<Attendancecuibt>(context).month}",
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
