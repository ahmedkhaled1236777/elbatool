import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/clients/data/models/clientrequest.dart';
import 'package:agman/features/clients/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class addcustomer extends StatefulWidget {
  @override
  State<addcustomer> createState() => _addcustomerState();
}

class _addcustomerState extends State<addcustomer> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController customername = TextEditingController();

  TextEditingController phone = TextEditingController();

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
                "اضافة عميل",
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
                              controller: customername,
                              hintText: "اسم العميل",
                              val: "برجاء ادخال اسم العميل",
                            ),
                            SizedBox(height: 10),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              keyboardType: TextInputType.number,
                              controller: phone,
                              hintText: "رقم هاتف العميل",
                              val: "برجاء ادخال رقم هاتف العميل",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<CustomersCubit, CustomersState>(
                              listener: (context, state) {
                                if (state is addCustomerfailure)
                                  showtoast(
                                      message: state.errormessage,
                                      toaststate: Toaststate.error,
                                      context: context);
                                if (state is addCustomersuccess) {
                                  customername.clear();
                                  phone.clear();
                                  BlocProvider.of<CustomersCubit>(context)
                                      .getCustomers();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is addCustomerloading)
                                  return loading();
                                return custommaterialbutton(
                                  button_name: "تسجيل عميل",
                                  onPressed: () async {
                                    await BlocProvider.of<CustomersCubit>(
                                            context)
                                        .addclient(
                                            client: Clientrequest(
                                                name: customername.text,
                                                phone: phone.text));
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
