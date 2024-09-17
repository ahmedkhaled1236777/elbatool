import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/texts.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/core/common/widgets/failurewidget.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/features/auth/login/presentation/view/login.dart';
import 'package:agman/features/oldproj/group/presentation/viewmodel/groups/groups_cubit.dart';
import 'package:agman/features/oldproj/view/gridcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Groups extends StatefulWidget {
  @override
  State<Groups> createState() => _GroupsState();
}

class _GroupsState extends State<Groups> {
  @override
  void initState() {
    BlocProvider.of<GroupsCubit>(context).getgroups(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appcolors.transcolors,
        centerTitle: true,
        title: Text(
          "المجموعات",
          style:
              TextStyle(color: Colors.white, fontFamily: apptexts.appfonfamily),
        ),
      ),
      body: BlocBuilder<GroupsCubit, GroupsState>(
        builder: (context, state) {
          if (state is GetGroupsLoading) return loading();
          if (state is GetGroupsFailure)
            return FailureView(errorMessage: state.error_message);
          return BlocProvider.of<GroupsCubit>(context).groups.isEmpty
              ? nodata()
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  child: AnimationLimiter(
                    child: GridView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 2,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5),
                      children: List.generate(
                          BlocProvider.of<GroupsCubit>(context).groups.length,
                          (index) => AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              columnCount: 2,
                              child: SlideAnimation(
                                  delay: Duration(milliseconds: 300),
                                  child: FlipAnimation(
                                      child: gridcard(
                                    name:
                                        "المجموعه رقم ${BlocProvider.of<GroupsCubit>(context).groups[index].groupnumber}",
                                    image: "assets/images/other.png",
                                    screen: Login(),
                                  ))))),
                    ),
                  ));
        },
      ),
    );
  }
}
