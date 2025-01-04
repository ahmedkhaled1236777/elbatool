import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/suppliers/data/models/supplierrequest.dart';
import 'package:agman/features/suppliers/presentation/viewmodel/suppliers/suppliers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class addsupplier extends StatefulWidget {
  @override
  State<addsupplier> createState() => _addsupplierState();
}

class _addsupplierState extends State<addsupplier> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController suppliername = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController place = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: const Text(
                "اضافة مورد",
                style: Styles.appbarstyle,
              ),
            ),
            body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        "assets/images/inj.png",
                      ))),
              child: Center(
                child: Form(
                    key: formkey,
                    child: Container(
                      height: MediaQuery.sizeOf(context).height,
                      margin: EdgeInsets.all(
                          MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.sizeOf(context).width < 600 ? 0 : 15)),
                      width: MediaQuery.sizeOf(context).width > 650
                          ? MediaQuery.sizeOf(context).width * 0.4
                          : double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 12, right: 9),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            const SizedBox(
                              height: 50,
                            ),
                            custommytextform(
                              controller: suppliername,
                              hintText: "اسم المورد",
                              val: "برجاء ادخال اسم المورد",
                            ),
                            SizedBox(height: 10),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              keyboardType: TextInputType.number,
                              controller: phone,
                              hintText: "رقم هاتف المورد",
                              val: "برجاء ادخال رقم هاتف المورد",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              controller: place,
                              hintText: "الجهه",
                              val: "برجاء ادخال الجهه",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<SupplierssCubit, SupplierssState>(
                              listener: (context, state) {
                                if (state is addSupplierfailure)
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                if (state is addSuppliersuccess) {
                                  suppliername.clear();
                                  phone.clear();
                                  place.clear();
                                  BlocProvider.of<SupplierssCubit>(context)
                                      .getSuppliers();

                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is addSupplierloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل مورد",
                                  onPressed: () async {
                                    BlocProvider.of<SupplierssCubit>(context)
                                        .addsupplier(
                                            supplier: Supplierrequest(
                                                name: suppliername.text,
                                                phone: phone.text,
                                                place: place.text));
                                  },
                                );
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ]))),
                    )),
              ),
            )));
  }
}
