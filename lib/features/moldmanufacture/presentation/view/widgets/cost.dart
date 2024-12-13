import 'dart:collection';

import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/features/moldmanufacture/presentation/view/accessoriescost/presentation/view/accessoriescost.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/view/firstcost.dart';
import 'package:agman/features/moldmanufacture/presentation/view/industerialcost/presentation/view/industerialcost.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/view/machinescost.dart';
import 'package:agman/features/moldmanufacture/presentation/view/widgets/costgridelement.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/coststates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cost extends StatelessWidget {
  final int stampid;
  final String intialcost;
  final String accessoriescost;
  final String manufacturecost;
  List<Map> costgrid = [
    {"desc": "تكلفه اوليه", "color": "0xff2f6d80"},
    {"desc": "تكلفه اكسسوارات", "color": "0xff6aa4b0"},
    {"desc": "تكلفه تصنيع", "color": "0xfffc3c80"},
    {"desc": "الاجمالي", "color": "0xff821d30"},
  ];

  Cost(
      {super.key,
      required this.intialcost,
      required this.stampid,
      required this.accessoriescost,
      required this.manufacturecost});
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
          "تكلفة الاسطمبه",
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
                .map((e) => BlocBuilder<Costcuibt, Coststates>(
                      builder: (context, state) {
                        return Costgridelement(
                          color: int.parse(e["color"]),
                          desc: e["desc"],
                          cost: e["desc"] == "تكلفه اوليه"
                              ? BlocProvider.of<Costcuibt>(context)
                                  .intialcost[stampid]!
                              : e["desc"] == "تكلفه اكسسوارات"
                                  ? BlocProvider.of<Costcuibt>(context)
                                      .accessories[stampid]!
                                  : e["desc"] == "تكلفه تصنيع"
                                      ? BlocProvider.of<Costcuibt>(context)
                                          .manufacture[stampid]!
                                      : (double.parse(
                                                  BlocProvider.of<Costcuibt>(context)
                                                      .intialcost[stampid]!) +
                                              double.parse(
                                                  BlocProvider.of<Costcuibt>(
                                                          context)
                                                      .accessories[stampid]!) +
                                              double.parse(
                                                  BlocProvider.of<Costcuibt>(
                                                          context)
                                                      .manufacture[stampid]!))
                                          .toString(),
                          onTap: () {
                            navigateto(
                                context: context,
                                page: e["desc"] == "تكلفه اوليه"
                                    ? Firstcost(stampid: stampid)
                                    : e["desc"] == "تكلفه اكسسوارات"
                                        ? accessoriecost(
                                            stampid: stampid,
                                          )
                                        : Industerialcost(
                                            stampid: stampid,
                                          ));
                          },
                        );
                      },
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
