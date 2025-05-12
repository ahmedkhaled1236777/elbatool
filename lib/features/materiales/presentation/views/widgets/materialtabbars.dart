import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:agman/features/materiales/presentation/views/material.dart';
import 'package:agman/features/materiales/presentation/views/widgets/alertcontent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Materialtabbars extends StatefulWidget {
  @override
  State<Materialtabbars> createState() => _MaterialtabbarsState();
}

class _MaterialtabbarsState extends State<Materialtabbars> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          bottom: TabBar(
              onTap: (value) {
                index = value;

                setState(() {});
              },
              labelPadding: EdgeInsets.all(15),
              dividerColor: appcolors.maincolor,
              padding: EdgeInsets.all(10),
              indicatorSize: TabBarIndicatorSize.tab,
              splashFactory: NoSplash.splashFactory,
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                // Use the default focused overlay color
                return states.contains(MaterialState.focused)
                    ? null
                    : Colors.transparent;
              }),
              indicator: BoxDecoration(color: appcolors.maincolor),
              tabs: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: index == 0
                        ? appcolors.primarycolor
                        : appcolors.maincolor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                  child: Text(
                    "الخامات",
                    style: TextStyle(fontFamily: "cairo", color: Colors.white),
                  ),
                ),
                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: index == 1
                        ? appcolors.primarycolor
                        : appcolors.maincolor,
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 100, vertical: 5),
                  child: Text(
                    "الماستر باتش",
                    style: TextStyle(fontFamily: "cairo", color: Colors.white),
                  ),
                ),
              ]),
          leading: BackButton(
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Container(
                            height: 20,
                            alignment: Alignment.topLeft,
                            child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: appcolors.maincolor,
                                )),
                          ),
                          contentPadding: EdgeInsets.all(10),
                          backgroundColor: Colors.white,
                          insetPadding: EdgeInsets.all(35),
                          content: Alertmaterialcontent(
                            status: index == 0 ? "material" : "masterpatch",
                          ),
                        );
                      });
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () async {
                  BlocProvider.of<plasticMaterialCubit>(context).firstloading =
                      false;
                  BlocProvider.of<plasticMaterialCubit>(context).queryparms = {
                    "type": index == 0 ? "material" : "masterpatch"
                  };
                  await BlocProvider.of<plasticMaterialCubit>(context)
                      .getMaterials(page: 1);
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
          ],
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: Text(
            "الخامات والماستر",
            style: Styles.appbarstyle,
          ),
        ),
        body: TabBarView(children: [
          plasticMaterial(status: "material"),
          plasticMaterial(status: "masterpatch"),
        ]),
      ),
    );
  }
}
