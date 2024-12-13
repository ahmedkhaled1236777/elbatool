import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/moldmanufacture/data/model/moldmanufacturerequest.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/coststates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class Editstamp extends StatelessWidget {
  final int stampid;
  TextEditingController name;
  TextEditingController clientname;
  TextEditingController notes;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  Editstamp(
      {required this.stampid,
      required this.name,
      required this.clientname,
      required this.notes});
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
              val: "برجاء ادخال اسم العميل",
              controller: clientname,
              hintText: "اسم العميل",
            ),
            SizedBox(
              height: 10,
            ),
            custommytextform(
              val: "برجاء ادخال اسم الاسطمبه",
              controller: name,
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
                if (state is editmoldmanufacturefailure)
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
                if (state is editmoldmanufacturesuccess) {
                  clientname.clear();
                  name.clear();
                  notes.clear();
                  BlocProvider.of<DateCubit>(context).cleardates();
                  BlocProvider.of<Costcuibt>(context).getmoldmanufacture();

                  showtoast(
                      message: state.succcessmessage,
                      toaststate: Toaststate.succes,
                      context: context);
                  Navigator.pop(context);
                }
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is editmoldmanufactureloading) return loading();
                return custommaterialbutton(
                  button_name: "تسجيل",
                  onPressed: () async {
                    BlocProvider.of<Costcuibt>(context).editmoldmanufacture(
                        stampid: stampid,
                        stamp: Moldmanufacturerequest(
                            date: BlocProvider.of<DateCubit>(context).date1,
                            clientname: clientname.text,
                            moldname: name.text,
                            notes: notes.text));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
