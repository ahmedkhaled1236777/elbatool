import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/navigation.dart';

import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/factorytoolssearch.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class alertfactorytoolcontent extends StatelessWidget {
  TextEditingController material = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width > 950
                      ? MediaQuery.sizeOf(context).width * 0.25
                      : MediaQuery.sizeOf(context).width * 1,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Text('بحث بواسطة',
                                style: TextStyle(
                                    color: appcolors.maincolor,
                                    fontFamily: "cairo",
                                    fontSize: 12.5),
                                textAlign: TextAlign.right),
                            const SizedBox(
                              height: 15,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date3,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate3(context);
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date4,
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate4(context);
                                  },
                                );
                              },
                            ),
                            custommytextform(
                              controller: material,
                              hintText: "اسم الاداه",
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            custommaterialbutton(
                                button_name: "بحث",
                                onPressed: () async {
                                  if ((BlocProvider.of<DateCubit>(context)
                                                  .date3 ==
                                              "التاريخ من" &&
                                          BlocProvider.of<DateCubit>(context)
                                                  .date4 !=
                                              "التاريخ الي") ||
                                      (BlocProvider.of<DateCubit>(context)
                                                  .date3 !=
                                              "التاريخ من" &&
                                          BlocProvider.of<DateCubit>(context)
                                                  .date4 ==
                                              "التاريخ الي")) {
                                    showdialogerror(
                                        error:
                                            "برجاء تحديد التاريخ من والتاريخ الي",
                                        context: context);
                                  } else {
                                    navigateto(
                                        context: context,
                                        page: Factorytoolssearch(
                                            startdate:
                                                BlocProvider.of<DateCubit>(
                                                        context)
                                                    .date3,
                                            enddate: BlocProvider.of<DateCubit>(
                                                    context)
                                                .date4));
                                  }
                                })
                          ]))))
            ])));
  }
}
