import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/localdata.dart';
import 'package:agman/core/common/texts.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/custommaterialbutton.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/oldproj/baqa/presentation/view/widgets/customtextform.dart';
import 'package:agman/features/oldproj/group/data/model/geoupmodel.dart';
import 'package:agman/features/oldproj/group/presentation/viewmodel/groups/groups_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../baqa/presentation/view/widgets/dropdown.dart';

class Addgroup extends StatefulWidget {
  @override
  State<Addgroup> createState() => _AddgroupState();
}

class _AddgroupState extends State<Addgroup> {
  TextEditingController groupnumber = TextEditingController();

  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  getgrous() async {
    List<Map> groups =
        await Localdata.readdatabase(sql: "SELECT * FROM groups");
    print("iiiiiiiiiiiiioooooooooooooooooooooooooooooooo");
    print(groups);
  }

  @override
  void initState() {
    getgrous();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolors.transcolors,
          centerTitle: true,
          title: Text(
            "اضافة مجموعه",
            style: TextStyle(
                fontFamily: apptexts.appfonfamily, color: Colors.white),
          ),
        ),
        body: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 40,
              ),
              Expanded(
                  child: Container(
                width: MediaQuery.sizeOf(context).width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 35,
                      ),
                      Image.asset(
                        "assets/images/other.png",
                        height: 100,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Customtextformincex(
                        controller: groupnumber,
                        valid: "برجاء ادخال رقم المجموعه",
                        hint: "رقم المجموعه",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      BlocBuilder<GroupsCubit, GroupsState>(
                        builder: (context, state) {
                          return Dropdownapp(
                            onChanged: (p0) {
                              BlocProvider.of<GroupsCubit>(context)
                                  .groupdatechange(p0!);
                            },
                            array: ["1", "15"],
                            hint: "تاريخ بداية الباقه",
                            valx: BlocProvider.of<GroupsCubit>(context)
                                .groupstartdate,
                          );
                        },
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: BlocConsumer<GroupsCubit, GroupsState>(
                          listener: (context, state) {
                            if (state is AddGroupsFailure)
                              showtoast(
                                  message: state.error_message,
                                  toaststate: Toaststate.error,
                                  context: context);
                            if (state is AddGroupsSuccess) {
                              groupnumber.clear();
                              BlocProvider.of<GroupsCubit>(context).retsetdat();
                              showtoast(
                                  context: context,
                                  message: state.success_message,
                                  toaststate: Toaststate.succes);
                            }
                          },
                          builder: (context, state) {
                            if (state is AddGroupsLoading) return loading();
                            return custommaterialbutton(
                              button_name: "تاكيد",
                              onPressed: () {
                                if (globalKey.currentState!.validate()) {
                                  if (BlocProvider.of<GroupsCubit>(context)
                                          .groupstartdate ==
                                      null) {
                                    showdialogerror(
                                        error:
                                            "لا بد منم اختيار تاريخ بداية الباقه",
                                        context: context);
                                  } else {
                                    BlocProvider.of<GroupsCubit>(context)
                                        .addgroup(
                                            group: groupmodel(
                                                groupnumber: groupnumber.text,
                                                groupstatrtdate: BlocProvider
                                                        .of<GroupsCubit>(
                                                            context)
                                                    .groupstartdate!),
                                            context: context);
                                  }
                                }
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
        backgroundColor: appcolors.transcolors,
      ),
    );
  }
}
