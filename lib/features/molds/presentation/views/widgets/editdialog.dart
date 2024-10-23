import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/molds/data/models/moldmodelrequest.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class editmolddialog extends StatelessWidget {
  final TextEditingController moldname;
  final TextEditingController weight;
  final TextEditingController cycletime;
  final int id;

  const editmolddialog(
      {super.key,
      required this.moldname,
      required this.weight,
      required this.cycletime,
      required this.id});
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          custommytextform(
            controller: moldname,
            hintText: "اسم الاسطمبه",
            val: "لابد من ادخال اسم الاسطمبه",
          ),
          SizedBox(
            height: 10,
          ),
          custommytextform(
            controller: weight,
            hintText: "وزن القطعه",
            val: "لابد من ادخال اسم القطعه",
          ),
          SizedBox(
            height: 10,
          ),
          custommytextform(
            controller: cycletime,
            hintText: "زمن الدوره",
            val: "لابد من ادخال زمن الدوره",
          ),
          SizedBox(
            height: 15,
          ),
          BlocConsumer<MoldCubit, MoldState>(
            listener: (context, state) {
              if (state is updatemoldfailure)
                showdialogerror(error: state.errormessage, context: context);
              if (state is updatemoldsuccess) {
                showtoast(
                    message: state.successmessage,
                    toaststate: Toaststate.succes,
                    context: context);
                BlocProvider.of<MoldCubit>(context).getmolds();
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              if (state is Updatemoldloading) return loading();
              return custommaterialbutton(
                button_name: "تسجيل",
                onPressed: () {
                  BlocProvider.of<MoldCubit>(context).updatemold(
                      mold: Moldmodelrequest(
                          moldname: moldname.text,
                          numberofpieces: 5,
                          cycletime: cycletime.text,
                          prodweight: weight.text),
                      id: id);
                },
              );
            },
          )
        ],
      ),
    );
  }
}
