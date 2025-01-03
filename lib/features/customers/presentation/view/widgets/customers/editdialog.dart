import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/customers/data/models/clientrequest.dart';
import 'package:agman/features/customers/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class editAlertcontent extends StatelessWidget {
  final TextEditingController customername;
  final TextEditingController phone;
  final int id;
  const editAlertcontent(
      {super.key,
      required this.customername,
      required this.phone,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width > 950
                      ? MediaQuery.sizeOf(context).width * 0.25
                      : MediaQuery.sizeOf(context).width * 1,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
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
                              controller: customername,
                              hintText: "اسم العميل",
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            custommytextform(
                              controller: phone,
                              hintText: "رقم الهاتف",
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<CustomersCubit, CustomersState>(
                              listener: (context, state) {
                                if (state is editCustomerfailure)
                                  showdialogerror(
                                      error: state.errormessage,
                                      context: context);
                                if (state is editCustomersuccess) {
                                  Navigator.pop(context);
                                  BlocProvider.of<CustomersCubit>(context)
                                      .getCustomers();
                                  showtoast(
                                      message: state.successmessage,
                                      toaststate: Toaststate.succes,
                                      context: context);
                                }
                              },
                              builder: (context, state) {
                                if (state is editcustomerloading)
                                  return loading();
                                return custommaterialbutton(
                                    button_name: "تعديل",
                                    onPressed: () async {
                                      BlocProvider.of<CustomersCubit>(context)
                                          .editclient(
                                              client: Clientrequest(
                                                  name: customername.text,
                                                  phone: phone.text,
                                                  id: id));
                                    });
                              },
                            )
                          ]))))
            ])));
  }
}
