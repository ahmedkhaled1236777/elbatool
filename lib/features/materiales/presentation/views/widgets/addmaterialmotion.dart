import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/materiales/data/models/materialmovemodelrequest.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:agman/features/materiales/presentation/views/widgets/radios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addmaterialmotion extends StatelessWidget {
  final String materialname;
  final int materialid;
  final String type;
  TextEditingController quantity = TextEditingController();
  TextEditingController notes = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Addmaterialmotion(
      {super.key,
      required this.materialname,
      required this.materialid,
      required this.type});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: Text(
            "اضافة حركه ${materialname}",
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
                        BlocBuilder<DateCubit, DateState>(
                          builder: (context, state) {
                            return choosedate(
                              date: BlocProvider.of<DateCubit>(context).date1,
                              onPressed: () {
                                BlocProvider.of<DateCubit>(context)
                                    .changedate(context);
                              },
                            );
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        BlocBuilder<plasticMaterialCubit, plasticMaterialState>(
                          builder: (context, state) {
                            return radiosmaterialtype(
                                firstradio: "1",
                                secondradio: "0",
                                firstradiotitle: "اضافه",
                                secondradiotitle: "سحب");
                          },
                        ),
                        custommytextform(
                          controller: quantity,
                          hintText: "الكميه",
                          val: "برجاء ادخال الكميه",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocConsumer<plasticMaterialCubit,
                            plasticMaterialState>(listener: (context, state) {
                          if (state is AddMaterialmovefailure) {
                            showtoast(
                                message: state.errormessage,
                                toaststate: Toaststate.error,
                                context: context);
                          }
                          if (state is AddMaterialmovesuccess) {
                            notes.clear();
                            quantity.clear();

                            BlocProvider.of<plasticMaterialCubit>(context)
                                .getMaterials(page: 1);
                            showtoast(
                                message: state.successmessage,
                                toaststate: Toaststate.succes,
                                context: context);
                          }
                        }, builder: (context, state) {
                          if (state is AddMaterialmoveLoading) return loading();
                          return custommaterialbutton(
                            button_name: "تسجيل الحركه",
                            onPressed: () async {
                              BlocProvider.of<plasticMaterialCubit>(context)
                                  .addmaterialmove(
                                      material: Materialmovemodelrequest(
                                          date: BlocProvider.of<DateCubit>(
                                                  context)
                                              .date1,
                                          materialid: materialid.toString(),
                                          qty: quantity.text,
                                          status: BlocProvider.of<
                                                  plasticMaterialCubit>(context)
                                              .type,
                                          type: type,
                                          notes: notes.text));
                            },
                          );
                        }),
                        SizedBox(
                          height: 25,
                        ),
                      ]))),
                )),
          ),
        ));
  }
}
