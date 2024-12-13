import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';

import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/accessories/data/model/accessoriemodelrequest.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:agman/features/accessories/presentation/views/widgets/radios.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Editaccessoriesdialog extends StatelessWidget {
  final int accessorieid;
  TextEditingController accessoriesname;
  TextEditingController quantity;
  TextEditingController buymoney;
  TextEditingController sellmoney;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Editaccessoriesdialog(
      {required this.accessoriesname,
      required this.buymoney,
      required this.quantity,
      required this.accessorieid,
      required this.sellmoney});
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Form(
        key: formkey,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            custommytextform(
              controller: accessoriesname,
              hintText: "اسم الاكسسوار",
              val: "برجاء ادخال اسم الاكسسوار ",
            ),
            const SizedBox(
              height: 10,
            ),
            custommytextform(
              controller: quantity,
              hintText: "الكميه",
              val: "برجاء ادخال الكميه",
            ),
            const SizedBox(
              height: 10,
            ),
            custommytextform(
                controller: buymoney,
                hintText: "سعر الشراء",
                val: "برجاء ادخال سعر الشراء",
                keyboardType: TextInputType.number),
            const SizedBox(
              height: 10,
            ),
            custommytextform(
                controller: sellmoney,
                hintText: "ٍسعر البيع",
                val: "برجاء ادخال سعر البيع",
                keyboardType: TextInputType.number),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 15,
            ),
            BlocConsumer<plasticaccessoriesCubit, plasticaccessoriesState>(
              listener: (context, state) async {
                if (state is editaccessoriesuccess) {
                  accessoriesname.clear;
                  quantity.clear();
                  buymoney.clear();
                  sellmoney.clear();
                  showtoast(
                      context: context,
                      message: state.successmessage,
                      toaststate: Toaststate.succes);
                  await BlocProvider.of<plasticaccessoriesCubit>(context)
                      .getaccessories();
                  Navigator.pop(context);
                }
                if (state is editaccessoriefailure)
                  showdialogerror(error: state.errormessage, context: context);
              },
              builder: (context, state) {
                if (state is editaccessorieloading) return loading();
                return custommaterialbutton(
                  button_name: "تعديل",
                  onPressed: () {
                    if (formkey.currentState!.validate())
                      BlocProvider.of<plasticaccessoriesCubit>(context)
                          .editaccessorie(
                              accessorieid: accessorieid,
                              accessorie: Accessoriemodelrequest(
                                  name: accessoriesname.text,
                                  quantity: int.parse(quantity.text),
                                  sellprice: double.parse(sellmoney.text),
                                  buyprice: double.parse(buymoney.text)));
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
