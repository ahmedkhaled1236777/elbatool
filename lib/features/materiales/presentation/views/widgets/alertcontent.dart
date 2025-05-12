import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alertmaterialcontent extends StatelessWidget {
  TextEditingController material = TextEditingController();
  final String status;

  Alertmaterialcontent({super.key, required this.status});

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
                            custommytextform(
                              controller: material,
                              hintText: "اسم الخامه",
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(
                              height: 10,
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
                            BlocConsumer<plasticMaterialCubit,
                                plasticMaterialState>(
                              listener: (context, state) {
                                if (state is GetMaterialsFailure) {
                                  showdialogerror(
                                      error: state.errormessage,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is GetMaterialsLoading)
                                  return loading();
                                return custommaterialbutton(
                                    button_name: "بحث",
                                    onPressed: () async {
                                      BlocProvider.of<plasticMaterialCubit>(
                                              context)
                                          .queryparms = {
                                        "name": material.text,
                                        "type": status,
                                        if (BlocProvider.of<DateCubit>(context)
                                                .date3 !=
                                            "التاريخ من")
                                          "date_from":
                                              BlocProvider.of<DateCubit>(
                                                      context)
                                                  .date3,
                                        if (BlocProvider.of<DateCubit>(context)
                                                .date4 !=
                                            "التاريخ الي")
                                          "date_to": BlocProvider.of<DateCubit>(
                                                  context)
                                              .date4
                                      };
                                      await BlocProvider.of<
                                              plasticMaterialCubit>(context)
                                          .getMaterials(
                                        page: 1,
                                      );
                                      Navigator.pop(context);
                                    });
                              },
                            )
                          ]))))
            ])));
  }
}
