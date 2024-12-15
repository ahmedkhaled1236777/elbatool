import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/factorytools/data/models/factorytoolmodelrequest.dart';

import 'package:agman/features/factorytools/presentation/viewmodel/factorytools/factorytools_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Editfactorytooldialog extends StatelessWidget {
  final TextEditingController factorytoolquantity;
  final TextEditingController factorytoolname;
  final int id;

  const Editfactorytooldialog(
      {super.key,
      required this.factorytoolquantity,
      required this.id,
      required this.factorytoolname});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          custommytextform(controller: factorytoolname, hintText: "اسم الاداه"),
          SizedBox(
            height: 10,
          ),
          custommytextform(controller: factorytoolquantity, hintText: "الكميه"),
          SizedBox(
            height: 15,
          ),
          BlocConsumer<FactorytoolsCubit, FactorytoolsState>(
            listener: (context, state) {
              if (state is edittoolfailure)
                showdialogerror(error: state.errormessage, context: context);
              if (state is edittoolsuccess) {
                BlocProvider.of<FactorytoolsCubit>(context).getfactorytools();
                Navigator.pop(context);
                showtoast(
                    message: state.successmessage,
                    toaststate: Toaststate.succes,
                    context: context);
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is edittoolloading) return loading();
              return custommaterialbutton(
                button_name: "تسجيل",
                onPressed: () async {
                  await BlocProvider.of<FactorytoolsCubit>(context).updatetool(
                      factorytool: Factorytoolmodelrequest(
                          toolname: factorytoolname.text,
                          quantity: factorytoolquantity.text),
                      factorytoolid: id);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
