import 'package:agman/core/colors/colors.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class radios extends StatelessWidget {
  final int firstradio;
  final int secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  radios(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var accessoriesbloc = BlocProvider.of<plasticaccessoriesCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: accessoriesbloc.type,
              onChanged: (val) {
                accessoriesbloc.changetype(value: val!);
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
              groupValue: accessoriesbloc.type,
              onChanged: (val) {
                accessoriesbloc.changetype(value: val!);
              }),
          Text(secondradiotitle),
        ],
      ),
    );
  }
}
