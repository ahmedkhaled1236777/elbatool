import 'package:agman/features/attendance/presentation/view/widgets/permessionradio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/attendance/data/models/attendancepermessionrequest.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';
import 'package:agman/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';

class Addpermession extends StatelessWidget {
  final int employerid;
  final String employername;
  TextEditingController permessionhours = TextEditingController();
  TextEditingController notes = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  Addpermession(
      {super.key, required this.employerid, required this.employername});
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
              title: Text(
                "اضافة اذن",
                style: Styles.appbarstyle,
              ),
            ),
            body: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/images/home.png",
                        ))),
                child: Center(
                    child: Form(
                        key: formkey,
                        child: Container(
                            height: MediaQuery.sizeOf(context).height,
                            margin: EdgeInsets.all(
                                MediaQuery.sizeOf(context).width < 600
                                    ? 0
                                    : 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    MediaQuery.sizeOf(context).width < 600
                                        ? 0
                                        : 15)),
                            width: MediaQuery.sizeOf(context).width > 650
                                ? MediaQuery.sizeOf(context).width * 0.4
                                : double.infinity,
                            child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12, right: 9),
                                child: SingleChildScrollView(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      height: 15,
                                    ),
                                    BlocBuilder<DateCubit, DateState>(
                                      builder: (context, state) {
                                        return choosedate(
                                          date: BlocProvider.of<DateCubit>(
                                                  context)
                                              .date2,
                                          onPressed: () {
                                            BlocProvider.of<DateCubit>(context)
                                                .changedate2(context);
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    BlocBuilder<Attendancecuibt,
                                        Attendancestate>(
                                      builder: (context, state) {
                                        return permessionradio(
                                            firstradio: "0",
                                            secondradio: "1",
                                            firstradiotitle: "اذن",
                                            secondradiotitle: "اضافى");
                                      },
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    BlocBuilder<Attendancecuibt,
                                        Attendancestate>(
                                      builder: (context, state) {
                                        return custommytextform(
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp("[0-9-.]")),
                                          ],
                                          keyboardType: TextInputType.number,
                                          controller: permessionhours,
                                          hintText:
                                              BlocProvider.of<Attendancecuibt>(
                                                              context)
                                                          .permessionstatus ==
                                                      "اذن"
                                                  ? "عدد ساعات الاذن"
                                                  : "عدد ساعات الاضافى",
                                          val: "برجاء ادخال عدد ساعات العمل",
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 7,
                                    ),
                                    custommytextform(
                                      controller: notes,
                                      hintText: "الملاحظات",
                                      val: "برجاء كتابة الملاحظات",
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    BlocConsumer<Attendancecuibt,
                                        Attendancestate>(
                                      listener: (context, state) {
                                        if (state is addpermessionfailure) {
                                          showtoast(
                                              message: state.errormessage,
                                              toaststate: Toaststate.error,
                                              context: context);
                                        }
                                        if (state is addpermessionsuccess) {
                                          permessionhours.clear();
                                          notes.clear();

                                          getdata() async {
                                            await BlocProvider.of<WorkersCubit>(
                                                    context)
                                                .getworkersmoves(
                                              year:
                                                  "${BlocProvider.of<Attendancecuibt>(context).year}",
                                              workerid: employername,
                                              month:
                                                  "${BlocProvider.of<Attendancecuibt>(context).month}",
                                            );
                                          }

                                          showtoast(
                                              message: state.successmessage,
                                              toaststate: Toaststate.succes,
                                              context: context);
                                        }
                                        // TODO: implement listener
                                      },
                                      builder: (context, state) {
                                        if (state is addpermessionloading)
                                          return loading();
                                        return custommaterialbutton(
                                          button_name: "تسجيل",
                                          onPressed: () {
                                            if (BlocProvider.of<DateCubit>(
                                                        context)
                                                    .date2 ==
                                                "اختر التاريخ") {
                                              showdialogerror(
                                                  error: "برجاء اختيار التاريخ",
                                                  context: context);
                                            } else {
                                              if (formkey.currentState!.validate())
                                                BlocProvider.of<Attendancecuibt>(
                                                        context)
                                                    .addpermession(
                                                        permession: Attendancepermessionrequest(
                                                            status: BlocProvider
                                                                    .of<Attendancecuibt>(
                                                                        context)
                                                                .permessionstatus,
                                                            employerid:
                                                                employerid,
                                                            numberofhours:
                                                                permessionhours
                                                                    .text,
                                                            date: BlocProvider
                                                                    .of<DateCubit>(
                                                                        context)
                                                                .date2,
                                                            notes: notes.text));
                                            }
                                          },
                                        );
                                      },
                                    )
                                  ],
                                )))))))));
  }
}
