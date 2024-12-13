import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/moldmanufacture/data/model/moldmanufacturerequest.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/coststates.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addmoldmanufacture extends StatelessWidget {
  TextEditingController moldname = TextEditingController();
  TextEditingController clientname = TextEditingController();
  TextEditingController notes = TextEditingController(text: "لا يوجد");

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
                        custommytextform(
                          val: "برجاء ادخال اسم العميل",
                          controller: clientname,
                          hintText: "اسم العميل",
                        ),
                        SizedBox(
                          height: 10,
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
                          val: "برجاء ادخال الملاحظات",
                          controller: notes,
                          hintText: "الملاحظات",
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        BlocConsumer<Costcuibt, Coststates>(
                          listener: (context, state) {
                            if (state is addmoldmanufacturefailure)
                              showtoast(
                                  message: state.errorrmessage,
                                  toaststate: Toaststate.error,
                                  context: context);
                            if (state is addmoldmanufacturesuccess) {
                              clientname.clear();
                              moldname.clear();
                              notes.clear();
                              BlocProvider.of<DateCubit>(context).cleardates();
                              BlocProvider.of<Costcuibt>(context)
                                  .getmoldmanufacture();

                              showtoast(
                                  message: state.successmessage,
                                  toaststate: Toaststate.succes,
                                  context: context);
                            }
                            // TODO: implement listener
                          },
                          builder: (context, state) {
                            if (state is addmoldmanufactureloading)
                              return loading();
                            return custommaterialbutton(
                              button_name: "تسجيل",
                              onPressed: () async {
                                BlocProvider.of<Costcuibt>(context)
                                    .addmoldmanufacture(
                                        moldmanufacture: Moldmanufacturerequest(
                                            date: BlocProvider.of<DateCubit>(
                                                    context)
                                                .date1,
                                            clientname: clientname.text,
                                            moldname: moldname.text,
                                            notes: notes.text));
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
