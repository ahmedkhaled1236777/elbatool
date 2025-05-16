import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/attendance/data/models/holidaymodelrequest.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancecuibt.dart';
import 'package:agman/features/attendance/presentation/viewmodel/attendance/attendancestate.dart';
import 'package:agman/features/workers/presentation/viewmodel/cubit/workers_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addholiday extends StatefulWidget {
  @override
  State<Addholiday> createState() => _AddholidayState();
}

class _AddholidayState extends State<Addholiday> {
  TextEditingController notes = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  getdata() async {
    if (BlocProvider.of<WorkersCubit>(context).workersnames.isEmpty) {
      await BlocProvider.of<WorkersCubit>(context).getworkers();
    }
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        backgroundColor: appcolors.maincolor,
        centerTitle: true,
        title: const Text(
          "اضافة ساعات اضافى",
          style: TextStyle(
            color: Colors.white,
            fontFamily: "cairo",
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: formkey,
          child: Container(
            height: MediaQuery.sizeOf(context).height,
            margin: EdgeInsets.all(
              MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                MediaQuery.sizeOf(context).width < 600 ? 0 : 15,
              ),
            ),
            width: MediaQuery.sizeOf(context).width > 650
                ? MediaQuery.sizeOf(context).width * 0.4
                : double.infinity,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 9),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "التاريخ",
                        style: TextStyle(
                          fontSize: 12.5,
                          color: appcolors.maincolor,
                          fontFamily: "cairo",
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ),
                    const SizedBox(height: 10),
                    BlocBuilder<DateCubit, DateState>(
                      builder: (context, state) {
                        return choosedate(
                          date: BlocProvider.of<DateCubit>(context).date2,
                          onPressed: () {
                            BlocProvider.of<DateCubit>(
                              context,
                            ).changedate2(context);
                          },
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    BlocBuilder<WorkersCubit, WorkersState>(
                      builder: (context, state) {
                        if (state is getworkerloading) return loading();
                        if (state is getworkerfailure)
                          return Text(state.errormessage);
                        return Column(children: [
                          Container(
                              color: Color(0xff535C91),
                              child: Center(
                                  child: DropdownSearch<String>(
                                dropdownButtonProps:
                                    DropdownButtonProps(color: Colors.white),
                                popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps()),
                                selectedItem:
                                    BlocProvider.of<WorkersCubit>(context)
                                        .workername,
                                items: BlocProvider.of<WorkersCubit>(context)
                                    .workersnames,
                                onChanged: (value) {
                                  BlocProvider.of<WorkersCubit>(context)
                                      .changeworker(value!);
                                },
                                dropdownDecoratorProps: DropDownDecoratorProps(
                                    baseStyle: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "cairo"),
                                    textAlign: TextAlign.center,
                                    dropdownSearchDecoration: InputDecoration(
                                      enabled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff535C91)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xff535C91)),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )),
                              ))),
                        ]);
                      },
                    ),
                    SizedBox(height: 10),
                    custommytextform(
                      controller: notes,
                      hintText: "الملاحظات",
                      val: "برجاء ادخال اسم الملاجظات",
                    ),
                    SizedBox(height: 20),
                    BlocConsumer<Attendancecuibt, Attendancestate>(
                      listener: (context, state) {
                        if (state is addholidaysuccess) {
                          BlocProvider.of<DateCubit>(context).cleardates();
                          notes.clear();
                          showtoast(
                            context: context,
                            message: state.successmessage,
                            toaststate: Toaststate.succes,
                          );
                        }
                        if (state is addholidayfailure) {
                          showtoast(
                            context: context,
                            message: state.errormessage,
                            toaststate: Toaststate.error,
                          );
                        }
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is addholidayloading) return loading();
                        return custommaterialbutton(
                          button_name: "تسجيل",
                          onPressed: () {
                            if (BlocProvider.of<DateCubit>(context).date2 ==
                                "اختر التاريخ") {
                              showdialogerror(
                                error: "برجاء اختيار التاريخ",
                                context: context,
                              );
                            } else if (BlocProvider.of<WorkersCubit>(context)
                                    .workername ==
                                "اسم العامل") {
                              showdialogerror(
                                  error: "برجاء اختيار اسم العامل",
                                  context: context);
                            } else {
                              if (formkey.currentState!.validate())
                                BlocProvider.of<Attendancecuibt>(
                                  context,
                                ).addholiday(
                                  holidayrequest: Holidaymodelrequest(
                                    employid: BlocProvider.of<WorkersCubit>(
                                                context)
                                            .workerid[
                                        BlocProvider.of<WorkersCubit>(context)
                                            .workername],
                                    notes: notes.text,
                                    date: BlocProvider.of<DateCubit>(
                                      context,
                                    ).date2,
                                    status: 1,
                                  ),
                                );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
