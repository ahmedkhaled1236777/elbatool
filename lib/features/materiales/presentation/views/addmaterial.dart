import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/materiales/data/models/materialmodelrequest.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:agman/features/materiales/presentation/views/widgets/radios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class addmaterial extends StatefulWidget {
  @override
  State<addmaterial> createState() => _addmaterialState();
}

class _addmaterialState extends State<addmaterial> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController materialname = TextEditingController();
  TextEditingController quantity = TextEditingController(text: "0");

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
                "اضافة خامه",
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
                            BlocBuilder<plasticMaterialCubit,
                                plasticMaterialState>(
                              builder: (context, state) {
                                return materialradios(
                                    firstradio: "MATERIAL",
                                    secondradio: "MASTER_PATCH",
                                    firstradiotitle: "خامه",
                                    secondradiotitle: "ماستر باتش");
                              },
                            ),
                            BlocBuilder<plasticMaterialCubit,
                                plasticMaterialState>(
                              builder: (context, state) {
                                return custommytextform(
                                    controller: materialname,
                                    hintText:
                                        BlocProvider.of<plasticMaterialCubit>(
                                                        context)
                                                    .materialtype ==
                                                "MATERIAL"
                                            ? "اسم الخامه"
                                            : "اللون",
                                    val: BlocProvider.of<plasticMaterialCubit>(
                                                    context)
                                                .materialtype ==
                                            "MATERIAL"
                                        ? "برجاء ادخال اسم الخامه"
                                        : "برجاء ادخال اللون",
                                    keyboardType: TextInputType.number);
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<plasticMaterialCubit,
                                plasticMaterialState>(
                              builder: (context, state) {
                                return BlocProvider.of<plasticMaterialCubit>(
                                                context)
                                            .materialtype ==
                                        "MATERIAL"
                                    ? SizedBox()
                                    : custommytextform(
                                        controller: quantity,
                                        hintText: "الكميه",
                                        val: "برجاء ادخال الكميه",
                                      );
                              },
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            BlocConsumer<plasticMaterialCubit,
                                    plasticMaterialState>(
                                listener: (context, state) {
                              if (state is AddMaterialFailure) {
                                showtoast(
                                    message: state.errormessage,
                                    toaststate: Toaststate.error,
                                    context: context);
                              }
                              if (state is AddMaterialSuccess) {
                                materialname.clear();
                                quantity = TextEditingController(text: "0");
                                BlocProvider.of<plasticMaterialCubit>(context)
                                    .changematerialtype(value: "MATERIAL");
                                BlocProvider.of<plasticMaterialCubit>(context)
                                    .getMaterials(page: 1);
                                showtoast(
                                    message: state.successmessage,
                                    toaststate: Toaststate.succes,
                                    context: context);
                              }
                            }, builder: (context, state) {
                              if (state is AddMaterialLoading) return loading();
                              return custommaterialbutton(
                                button_name: "تسجيل الخامه",
                                onPressed: () async {
                                  BlocProvider.of<plasticMaterialCubit>(context)
                                      .addmaterial(
                                          material: Materialmodelrequest(
                                              name: materialname.text,
                                              quantity:
                                                  double.parse(quantity.text),
                                              type: BlocProvider.of<
                                                          plasticMaterialCubit>(
                                                      context)
                                                  .materialtype));
                                },
                              );
                            }),
                            SizedBox(
                              height: 25,
                            ),
                          ]))),
                    )),
              ),
            )));
  }
}
