import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/viewmodel/cubit/intialcost_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class pickedimage extends StatefulWidget {
  ImagePicker picker = ImagePicker();

  @override
  State<pickedimage> createState() => _pickedimageState();
}

class _pickedimageState extends State<pickedimage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 0.5)),
      child: MaterialButton(
        padding: const EdgeInsets.all(21),
        onPressed: () {
          BlocProvider.of<IntialcostCubit>(context).uploadimage();
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.image,
              size: 19,
            ),
            SizedBox(
              width: 7,
            ),
            Text(
              'اختيار الصور',
              style: TextStyle(fontSize: 12.5),
            ),
          ],
        ),
      ),
    );
  }
}
