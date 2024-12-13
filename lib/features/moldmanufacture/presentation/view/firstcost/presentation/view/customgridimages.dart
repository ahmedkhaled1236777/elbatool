import 'dart:io';

import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/viewmodel/cubit/intialcost_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/coststates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

// ignore: camel_case_types
class customgridimages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Costcuibt, Coststates>(builder: (context, state) {
      return Container(
        height: 100,
        width: 100,
        child: Stack(children: [
          Image.file(
            File(BlocProvider.of<IntialcostCubit>(context).image!.path),
            fit: BoxFit.cover,
          ),
          IconButton(
              onPressed: () {
                BlocProvider.of<IntialcostCubit>(context).resetimage();
              },
              icon: Icon(Icons.cancel))
        ]),
      );
    });
  }
}
