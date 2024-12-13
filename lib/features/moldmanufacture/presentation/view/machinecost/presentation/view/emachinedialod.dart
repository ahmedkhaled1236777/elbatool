import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/model/addmachinereques.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/viewmodel/cubit/induxterialcost_cubit.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Editmachinecostdialog extends StatelessWidget {
  final TextEditingController machinecost;
  final TextEditingController machinename;
  final TextEditingController notes;
  final int id;
  const Editmachinecostdialog(
      {super.key,
      required this.machinecost,
      required this.id,
      required this.machinename,
      required this.notes});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          custommytextform(
            val: "برجاء ادخال اسم الماكينه",
            controller: machinename,
            hintText: "اسم الماكينه",
          ),
          SizedBox(
            height: 10,
          ),
          custommytextform(
            val: "برجاء ادخال تكلفة الساعه",
            controller: machinecost,
            hintText: "تكلفة الساعه",
          ),
          SizedBox(
            height: 10,
          ),
          custommytextform(
            controller: notes,
            hintText: "الملاحظات",
          ),
          SizedBox(
            height: 15,
          ),
          BlocConsumer<InduxterialcostCubit, InduxterialcostState>(
            listener: (context, state) {
              if (state is editmachinefailure) {
                showtoast(
                    message: state.errormessage,
                    toaststate: Toaststate.error,
                    context: context);
              }
              if (state is editmachinesuccess) {
                showtoast(
                    message: state.successmessage,
                    toaststate: Toaststate.succes,
                    context: context);
                Navigator.pop(context);
                BlocProvider.of<InduxterialcostCubit>(context).getmachines();
              }
            },
            builder: (context, state) {
              if (state is editmachineloading) return loading();
              return custommaterialbutton(
                button_name: "تعديل",
                onPressed: () async {
                  BlocProvider.of<InduxterialcostCubit>(context).updatemachine(
                      id: id,
                      machine: Addmachinereques(
                          name: machinename.text,
                          priceperhour: double.parse(machinecost.text),
                          notes: notes.text.isEmpty ? "لا يوجد" : notes.text));
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
