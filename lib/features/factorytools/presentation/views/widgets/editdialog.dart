import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/factorytools/presentation/viewmodel/factorytools/factorytools_cubit.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/radios.dart';
import 'package:agman/features/materiales/data/models/materialmodelrequest.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:agman/features/materiales/presentation/views/widgets/radios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Editfactorytooldialog extends StatelessWidget {
  final TextEditingController factorytoolquantity;
  final int id;

  const Editfactorytooldialog(
      {super.key, required this.factorytoolquantity, required this.id});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          BlocBuilder<FactorytoolsCubit, FactorytoolsState>(
            builder: (context, state) {
              return factorytoolsradio(
                  firstradio: "PUT",
                  secondradio: "DELETE",
                  firstradiotitle: "اضافه",
                  secondradiotitle: "سحب");
            },
          ),
          SizedBox(
            height: 10,
          ),
          custommytextform(
              controller: factorytoolquantity, hintText: "كمية الخامه"),
          SizedBox(
            height: 15,
          ),
          custommaterialbutton(
            button_name: "تسجيل",
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
