import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/data/model/addmachinereques.dart';
import 'package:agman/features/moldmanufacture/presentation/view/machinecost/presentation/viewmodel/cubit/induxterialcost_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addmachine extends StatefulWidget {
  @override
  State<Addmachine> createState() => _AddmachineState();
}

class _AddmachineState extends State<Addmachine> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController machinename = TextEditingController();
  TextEditingController cost = TextEditingController();
  TextEditingController notes = TextEditingController(text: "لا يوجد");

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
                "اضافة سعر ساعه ماكينه",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
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
                child: Container(
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
                        Form(
                          key: formkey,
                          child: Column(
                            children: [
                              custommytextform(
                                  controller: machinename,
                                  hintText: "اسم الماكينه",
                                  val: "برجاء ادخال اسم الماكينه",
                                  keyboardType: TextInputType.number),
                              const SizedBox(
                                height: 10,
                              ),
                              custommytextform(
                                  controller: cost,
                                  hintText: "تكلفة الساعه",
                                  val: "برجاء ادخال تكلفه الساعه للماكينه",
                                  keyboardType: TextInputType.number),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        custommytextform(
                            controller: notes,
                            hintText: "الملاحظات",
                            val: "برجاء ادخال الملاحظات",
                            keyboardType: TextInputType.number),
                        SizedBox(
                          height: 10,
                        ),
                        BlocConsumer<InduxterialcostCubit,
                            InduxterialcostState>(
                          listener: (context, state) {
                            if (state is addmachinefailure) {
                              showtoast(
                                  message: state.errormessage,
                                  toaststate: Toaststate.error,
                                  context: context);
                            }
                            if (state is addmachinesuccess) {
                              notes.clear();
                              cost.clear();
                              machinename.clear();
                              showtoast(
                                  message: state.successmessage,
                                  toaststate: Toaststate.succes,
                                  context: context);
                              BlocProvider.of<InduxterialcostCubit>(context)
                                  .getmachines();
                            }
                          },
                          builder: (context, state) {
                            if (state is addmachineloading) return loading();
                            return custommaterialbutton(
                              button_name: "تسجيل تكلفه",
                              onPressed: () async {
                                if (formkey.currentState!.validate()) {
                                  BlocProvider.of<InduxterialcostCubit>(context)
                                      .addmachine(
                                          machine: Addmachinereques(
                                              name: machinename.text,
                                              priceperhour:
                                                  double.parse(cost.text),
                                              notes: notes.text.isEmpty
                                                  ? "لا يوجد"
                                                  : notes.text));
                                }
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 25,
                        ),
                      ]))),
                ),
              ),
            )));
  }
}
