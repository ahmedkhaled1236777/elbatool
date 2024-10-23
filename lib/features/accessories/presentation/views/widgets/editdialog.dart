import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';

import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:agman/features/accessories/presentation/views/widgets/radios.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Editaccessoriesdialog extends StatelessWidget {
  TextEditingController accessoriesquantity = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          BlocBuilder<plasticaccessoriesCubit, plasticaccessoriesState>(
            builder: (context, state) {
              return radios(
                  firstradio: "اضافه",
                  secondradio: "سحب",
                  firstradiotitle: "اضافه",
                  secondradiotitle: "سحب");
            },
          ),
          SizedBox(
            height: 10,
          ),
          custommytextform(
            controller: accessoriesquantity,
            hintText: "عدد الاكسسوارات",
            suffixtext: "قطعه",
          ),
          SizedBox(
            height: 15,
          ),
          custommaterialbutton(button_name: "تسجيل")
        ],
      ),
    );
  }
}
