import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/features/save/presentation/viewmodel/save/save_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alertsavecontent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SizedBox(
            width: MediaQuery.sizeOf(context).width > 950
                ? MediaQuery.sizeOf(context).width * 0.25
                : MediaQuery.sizeOf(context).width * 1,
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(children: [
                      const SizedBox(
                        height: 25,
                      ),
                      BlocBuilder<DateCubit, DateState>(
                        builder: (context, state) {
                          return choosedate(
                            date: BlocProvider.of<DateCubit>(context).date1,
                            onPressed: () {
                              BlocProvider.of<DateCubit>(context)
                                  .changedate(context);
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      custommaterialbutton(
                          button_name: "بحث",
                          onPressed: () async {
                            Navigator.pop(context);
                            BlocProvider.of<SaveCubit>(context).date =
                                BlocProvider.of<DateCubit>(context).date1;
                            BlocProvider.of<SaveCubit>(context).getsavemotion(
                                date:
                                    BlocProvider.of<DateCubit>(context).date1);
                          })
                    ])))));
  }
}
