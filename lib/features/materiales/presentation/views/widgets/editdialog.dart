import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Editmaterialdialog extends StatelessWidget {
  final TextEditingController materialquantity;
  final int id;
  final String type;
  const Editmaterialdialog(
      {super.key,
      required this.type,
      required this.materialquantity,
      required this.id});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          custommytextform(
              controller: materialquantity, hintText: "كمية الخامه"),
          SizedBox(
            height: 15,
          ),
          BlocConsumer<plasticMaterialCubit, plasticMaterialState>(
            listener: (context, state) {
              if (state is updatematerialfailure)
                showdialogerror(error: state.errormessage, context: context);
              if (state is updatematerialsuccess) {
                showtoast(
                    message: state.successmessage,
                    toaststate: Toaststate.succes,
                    context: context);
                BlocProvider.of<plasticMaterialCubit>(context).queryparms = {
                  "type": type
                };
                BlocProvider.of<plasticMaterialCubit>(context)
                    .getMaterials(page: 1);
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is Updatematerialloading) return loading();
              return custommaterialbutton(
                button_name: "تسجيل",
                onPressed: () {
                  BlocProvider.of<plasticMaterialCubit>(context).updatematerial(
                      type: type,
                      quantity: double.parse(materialquantity.text),
                      id: id);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
