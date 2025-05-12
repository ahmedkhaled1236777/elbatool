import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/suppliers/data/models/supplierrequest.dart';
import 'package:agman/features/suppliers/presentation/viewmodel/suppliers/suppliers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class editsupplierdialog extends StatelessWidget {
  final TextEditingController Suppliername;
  final TextEditingController phone;
  final TextEditingController place;
  final int id;
  const editsupplierdialog(
      {super.key,
      required this.Suppliername,
      required this.phone,
      required this.place,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 0),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Text('تعديل',
                                style: TextStyle(
                                    color: appcolors.maincolor,
                                    fontFamily: "cairo",
                                    fontSize: 12.5),
                                textAlign: TextAlign.right),
                            const SizedBox(
                              height: 15,
                            ),
                            custommytextform(
                              controller: Suppliername,
                              hintText: "اسم المورد",
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            custommytextform(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9-.]")),
                              ],
                              controller: phone,
                              hintText: "رقم الهاتف",
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            custommytextform(
                              controller: place,
                              hintText: "الجهه",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<SupplierssCubit, SupplierssState>(
                              listener: (context, state) {
                                if (state is editSupplierfailure)
                                  showdialogerror(
                                      error: state.errormessage,
                                      context: context);
                                if (state is editSuppliersuccess) {
                                  Navigator.pop(context);
                                  BlocProvider.of<SupplierssCubit>(context)
                                      .getSuppliers();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is editSupplierloading)
                                  return loading();
                                return custommaterialbutton(
                                    button_name: "تعديل",
                                    onPressed: () async {
                                      BlocProvider.of<SupplierssCubit>(context)
                                          .editsupplier(
                                              supplier: Supplierrequest(
                                                  place: place.text,
                                                  name: Suppliername.text,
                                                  phone: phone.text,
                                                  id: id));
                                    });
                              },
                            )
                          ]))))
            ])));
  }
}
