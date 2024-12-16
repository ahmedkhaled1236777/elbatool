import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/sharedpref/cashhelper.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';
import 'package:agman/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';
import 'package:agman/features/users/presentation/viewmodel/showemployeecuibt/employeestates.dart';
import 'package:agman/features/users/presentation/views/widgets/customtableemployeeitem.dart';
import 'package:agman/features/users/presentation/views/widgets/editemployeedialog.dart';
import 'package:agman/features/users/presentation/views/widgets/showemployeedialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class customtableemployees extends StatefulWidget {
  ScrollController scrollController = ScrollController();
  final double width;
  customtableemployees(this.width);

  @override
  State<customtableemployees> createState() => _customtableemployeeesState();
}

class _customtableemployeeesState extends State<customtableemployees> {
  initscroll() async {
    BlocProvider.of<showemployeescuibt>(context).employeesdata.clear();
    await BlocProvider.of<showemployeescuibt>(context).getallemployees();
  }

  @override
  void initState() {
    initscroll();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 50,
            color: appcolors.maincolor.withOpacity(0.7),
            child: Row(
                children: BlocProvider.of<AddemployeeCubit>(context)
                    .headertable
                    .map((e) => customheadertable(
                        title: e,
                        flex: e == "تعديل" || e == "حذف" ? 2 : 3,
                        textStyle: Styles.getheadertextstyle(context: context)))
                    .toList()),
          ),
          Expanded(
              child: BlocConsumer<showemployeescuibt, showemployeesstates>(
                  listener: (context, state) {
            if (state is showemployeesfailure)
              showtoast(
                  message: state.error_message,
                  context: context,
                  toaststate: Toaststate.error);
            if (state is deleteemployeefailure)
              showtoast(
                  message: state.errormessage,
                  context: context,
                  toaststate: Toaststate.succes);
          }, builder: (context, state) {
            if (state is showemployeesloading) return loadingshimmer();
            if (state is showemployeesfailure) return SizedBox();
            return BlocProvider.of<showemployeescuibt>(context)
                    .employeesdata
                    .isEmpty
                ? nodata()
                : SingleChildScrollView(
                    controller: widget.scrollController,
                    child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {},
                            child: customtableemployeeitem(
                                textStyle:
                                    Styles.gettabletextstyle(context: context),
                                employeename:
                                    BlocProvider.of<showemployeescuibt>(context)
                                            .employeesdata[index]
                                            .name ??
                                        "",
                                phone:
                                    BlocProvider.of<showemployeescuibt>(context)
                                            .employeesdata[index]
                                            .phone ??
                                        "",
                                job:
                                    BlocProvider.of<showemployeescuibt>(context)
                                            .employeesdata[index]
                                            .jobTitle ??
                                        "",
                                delet: IconButton(
                                    onPressed: () async {
                                      awsomdialogerror(
                                        mywidget: BlocConsumer<
                                            showemployeescuibt,
                                            showemployeesstates>(
                                          listener: (context, state) {
                                            if (state
                                                is deleteemployeesuccess) {
                                              Navigator.pop(context);

                                              showtoast(
                                                  toaststate: Toaststate.succes,
                                                  message: state.succes_message,
                                                  context: context);
                                            }
                                            if (state
                                                is deleteemployeefailure) {
                                              Navigator.pop(context);

                                              showtoast(
                                                  toaststate: Toaststate.error,
                                                  message: state.errormessage,
                                                  context: context);
                                            }
                                          },
                                          builder: (context, state) {
                                            if (state is deleteemployeeloading)
                                              return deleteloading();
                                            return ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(
                                                          Color.fromARGB(255,
                                                              37, 163, 42)),
                                                ),
                                                onPressed: () async {
                                                  await await BlocProvider.of<
                                                              showemployeescuibt>(
                                                          context)
                                                      .deleteemployee(
                                                          token: cashhelper
                                                              .getdata(
                                                                  key: "token"),
                                                          employeenumber:
                                                              BlocProvider.of<
                                                                          showemployeescuibt>(
                                                                      context)
                                                                  .employeesdata[
                                                                      index]
                                                                  .id!
                                                                  .toInt());
                                                },
                                                child: const Text(
                                                  "تاكيد",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                ));
                                          },
                                        ),
                                        context: context,
                                        tittle: "هل تريد حذف الموظف ؟",
                                      );
                                    },
                                    icon: const Icon(
                                      size: 24,
                                      Icons.delete_outline_outlined,
                                      color: Colors.red,
                                    )),
                                edit: IconButton(
                                  icon: const Icon(
                                    Icons.edit_note,
                                    size: 29,
                                  ),
                                  onPressed: () {},
                                )),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: BlocProvider.of<showemployeescuibt>(context)
                            .employeesdata
                            .length),
                  );
          }))
        ]));
  }
}
