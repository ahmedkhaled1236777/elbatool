import 'package:agman/core/colors/colors.dart';
import 'package:agman/features/factorytools/presentation/viewmodel/factorytools/factorytools_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Factorytoolsradio extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String thirdradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotittle;
  Factorytoolsradio(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.thirdradio,
      required this.firstradiotitle,
      required this.thirdradiotittle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var factorytoolsbloc = BlocProvider.of<FactorytoolsCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: factorytoolsbloc.type,
              onChanged: (val) {
                factorytoolsbloc.changetype(value: val!);
              }),
          Text(firstradiotitle),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: factorytoolsbloc.type,
              onChanged: (val) {
                factorytoolsbloc.changetype(value: val!);
              }),
          Text(secondradiotitle),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: thirdradio,
              groupValue: factorytoolsbloc.type,
              onChanged: (val) {
                factorytoolsbloc.changetype(value: val!);
              }),
          Text(thirdradiotittle),
        ],
      ),
    );
  }
}
