import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/view/customgridimages.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/view/pickedimage.dart';
import 'package:agman/features/moldmanufacture/presentation/view/firstcost/presentation/viewmodel/cubit/intialcost_cubit.dart';
import 'package:agman/features/molds/data/models/moldmodelrequest.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addmold extends StatelessWidget {
  TextEditingController secondsperpiece = TextEditingController();
  TextEditingController numberofpieces = TextEditingController();
  TextEditingController moldname = TextEditingController();
  TextEditingController weight = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "اضافة اسطمبه",
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
                      child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        custommytextform(
                          val: "برجاء ادخال اسم الاسطمبه",
                          controller: moldname,
                          hintText: "اسم الاسطمبه",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        custommytextform(
                          val: "برجاء ادخال عدد القطع",
                          controller: numberofpieces,
                          hintText: "عدد القطع",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        custommytextform(
                          val: "برجاء ادخال عدد الثواني",
                          controller: secondsperpiece,
                          hintText: "عدد الثواني",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        custommytextform(
                          val: "برجاء ادخال وزن القطعه بالجرام",
                          controller: weight,
                          hintText: "(جرام) وزن القطعه ",
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<IntialcostCubit, IntialcostState>(
                          builder: (context, state) {
                            return Column(
                              children: [
                                pickedimage(),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<IntialcostCubit>(context)
                                        .image !=
                                    null)
                                  customgridimages(),
                                if (BlocProvider.of<IntialcostCubit>(context)
                                        .image !=
                                    null)
                                  const SizedBox(
                                    height: 10,
                                  ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocConsumer<MoldCubit, MoldState>(
                          listener: (context, state) {
                            if (state is AddMoldFailure) {
                              showtoast(
                                  message: state.errormessage,
                                  toaststate: Toaststate.error,
                                  context: context);
                            }
                            if (state is AddMoldSuccess) {
                              moldname.clear();
                              weight.clear();
                              numberofpieces.clear();
                              secondsperpiece.clear();
                              BlocProvider.of<IntialcostCubit>(context)
                                  .resetimage();
                              BlocProvider.of<MoldCubit>(context).getmolds();
                              showtoast(
                                  message: state.successmessage,
                                  toaststate: Toaststate.succes,
                                  context: context);
                            }
                          },
                          builder: (context, state) {
                            if (state is AddMoldLoading) return loading();
                            return custommaterialbutton(
                              button_name: "تسجيل",
                              onPressed: () async {
                                await BlocProvider.of<MoldCubit>(context).addmold(
                                    mold: Moldmodelrequest(
                                        image: BlocProvider.of<IntialcostCubit>(context)
                                                    .image !=
                                                null
                                            ? await MultipartFile.fromFile(
                                                BlocProvider.of<IntialcostCubit>(
                                                        context)
                                                    .image!
                                                    .path,
                                                filename:
                                                    BlocProvider.of<IntialcostCubit>(
                                                            context)
                                                        .image!
                                                        .path
                                                        .split("/")
                                                        .last)
                                            : null,
                                        numberofpieces:
                                            int.parse(numberofpieces.text),
                                        prodweight: weight.text,
                                        cycletime: secondsperpiece.text,
                                        moldname: moldname.text));
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  )))),
        ),
      ),
    );
  }
}
