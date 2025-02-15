import 'package:agman/core/colors/colors.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class radiosmaterialtype extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  radiosmaterialtype(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var materialbloc = BlocProvider.of<plasticMaterialCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: materialbloc.type,
              onChanged: (val) {
                materialbloc.changetype(value: val!);
              }),
          Text(firstradiotitle),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: materialbloc.type,
              onChanged: (val) {
                materialbloc.changetype(value: val!);
              }),
          Text(secondradiotitle),
        ],
      ),
    );
  }
}

class materialradios extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  materialradios(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var materialbloc = BlocProvider.of<plasticMaterialCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: materialbloc.materialtype,
              onChanged: (val) {
                materialbloc.changematerialtype(value: val!);
              }),
          Text(firstradiotitle),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: materialbloc.materialtype,
              onChanged: (val) {
                materialbloc.changematerialtype(value: val!);
              }),
          Text(secondradiotitle),
        ],
      ),
    );
  }
}
