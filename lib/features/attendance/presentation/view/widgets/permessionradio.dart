import 'package:agman/core/colors/colors.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class permessionradio extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  permessionradio(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.primarycolor,
              value: firstradio,
              groupValue:
                  BlocProvider.of<Attendancecuibt>(context).permessionstatus,
              onChanged: (val) {
                BlocProvider.of<Attendancecuibt>(context)
                    .changepermessiontype(val!);
              }),
          Text(
            firstradiotitle,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.primarycolor,
              value: secondradio,
              groupValue:
                  BlocProvider.of<Attendancecuibt>(context).permessionstatus,
              onChanged: (val) {
                BlocProvider.of<Attendancecuibt>(context)
                    .changepermessiontype(val!);
              }),
          Text(
            secondradiotitle,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
