import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dateaccessoriesearch extends StatelessWidget {
  final int accessorieid;

  const Dateaccessoriesearch({super.key, required this.accessorieid});
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
                            SizedBox(
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
                            const SizedBox(
                              height: 20,
                            ),
                            custommaterialbutton(
                                button_name: "بحث",
                                onPressed: () async {
                                  if (BlocProvider.of<DateCubit>(context)
                                              .date3 ==
                                          "التاريخ من" ||
                                      BlocProvider.of<DateCubit>(context)
                                              .date4 ==
                                          "التاريخ الي") {
                                    showdialogerror(
                                        error: "لابد اختيار التاريخ من والي",
                                        context: context);
                                  } else {
                                    await BlocProvider.of<
                                            plasticaccessoriesCubit>(context)
                                        .getaccessoriesmotion(
                                            accessorieid: accessorieid,
                                            datefrom:
                                                BlocProvider.of<DateCubit>(
                                                        context)
                                                    .date3,
                                            dateto: BlocProvider.of<DateCubit>(
                                                    context)
                                                .date4);
                                    Navigator.pop(context);
                                  }
                                })
                          ]))))
            ])));
  }
}
