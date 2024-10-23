import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Alertmoldcontent extends StatelessWidget {
  TextEditingController mold = TextEditingController();

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
                              val: "برجاء ادخال اسم الاسطمبه",
                              controller: mold,
                              hintText: "اسم الاسطمبه",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            custommaterialbutton(
                                button_name: "بحث",
                                onPressed: () async {
                                  Navigator.pop(context);
                                  BlocProvider.of<MoldCubit>(context)
                                      .searchformold(name: mold.text);
                                })
                          ]))))
            ])));
  }
}
