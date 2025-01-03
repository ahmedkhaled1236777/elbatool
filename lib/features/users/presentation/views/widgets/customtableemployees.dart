import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/features/users/presentation/viewmodel/addemployee/addemployee_cubit.dart';
import 'package:agman/features/users/presentation/viewmodel/showemployeecuibt/employeecuibt.dart';
import 'package:agman/features/users/presentation/viewmodel/showemployeecuibt/employeestates.dart';
import 'package:agman/features/users/presentation/views/widgets/customtableemployeeitem.dart';
import 'package:agman/features/users/presentation/views/widgets/editemployeedialog.dart';

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
                        flex: e == "تعديل" || e == "الحاله" ? 2 : 3,
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
                                status:
                                    BlocProvider.of<showemployeescuibt>(context)
                                                .employeesdata[index]
                                                .isActive ==
                                            1
                                        ? "مفعل"
                                        : "غير مفعل",
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
                                edit: IconButton(
                                  icon: const Icon(
                                    Icons.edit_note,
                                    size: 29,
                                  ),
                                  onPressed: () {
                                    BlocProvider.of<AddemployeeCubit>(context)
                                            .is_active =
                                        BlocProvider.of<showemployeescuibt>(
                                                context)
                                            .employeesdata[index]
                                            .isActive
                                            .toString();
                                    BlocProvider.of<AddemployeeCubit>(context)
                                            .manager =
                                        BlocProvider.of<showemployeescuibt>(
                                                context)
                                            .employeesdata[index]
                                            .roleId
                                            .toString();
                                    //صلاحيات الموظف مش راجعه مع المستخدمين
                                    showDialog(
                                        barrierDismissible: false,
                                        // user must tap button!
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                              title: Container(
                                                alignment: Alignment.topLeft,
                                                child: IconButton(
                                                    onPressed: () {
                                                      BlocProvider.of<
                                                                  AddemployeeCubit>(
                                                              context)
                                                          .resetdata();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    icon: const Icon(
                                                        Icons.close)),
                                              ),
                                              surfaceTintColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              content: editemployeedialog(
                                                isactive: BlocProvider.of<
                                                            showemployeescuibt>(
                                                        context)
                                                    .employeesdata[index]
                                                    .isActive
                                                    .toString(),
                                                userid: BlocProvider.of<
                                                            showemployeescuibt>(
                                                        context)
                                                    .employeesdata[index]
                                                    .id
                                                    .toString(),
                                                width: MediaQuery
                                                                .sizeOf(context)
                                                            .width >
                                                        950
                                                    ? MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.25
                                                    : MediaQuery.sizeOf(context)
                                                            .width *
                                                        1,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.85,
                                                role: BlocProvider.of<
                                                            showemployeescuibt>(
                                                        context)
                                                    .employeesdata[index]
                                                    .roleId
                                                    .toString(),
                                                employeename: TextEditingController(
                                                    text: BlocProvider.of<
                                                                showemployeescuibt>(
                                                            context)
                                                        .employeesdata[index]
                                                        .name
                                                        .toString()),
                                                email: TextEditingController(
                                                    text: BlocProvider.of<
                                                                showemployeescuibt>(
                                                            context)
                                                        .employeesdata[index]
                                                        .email
                                                        .toString()),
                                                phone: TextEditingController(
                                                    text: BlocProvider.of<
                                                                showemployeescuibt>(
                                                            context)
                                                        .employeesdata[index]
                                                        .phone
                                                        .toString()),
                                                jobtittle: TextEditingController(
                                                    text: BlocProvider.of<
                                                                showemployeescuibt>(
                                                            context)
                                                        .employeesdata[index]
                                                        .jobTitle
                                                        .toString()),
                                              ));
                                        });
                                  },
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
