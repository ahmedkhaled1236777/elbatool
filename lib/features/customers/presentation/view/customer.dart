import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/features/customers/presentation/view/addcustomer.dart';
import 'package:agman/features/customers/presentation/view/widgets/injection/injectioncustomers.dart';
import 'package:agman/features/customers/presentation/view/widgets/mold/moldcustomers.dart';
import 'package:agman/features/customers/presentation/view/widgets/alertcontent.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class customers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              leading: BackButton(
                color: Colors.white,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateto(context: context, page: addcustomer());
                    },
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    )),
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
                              content: Alertcontent(),
                            );
                          });
                    },
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    )),
              ],
              backgroundColor: appcolors.maincolor,
              centerTitle: true,
              title: Text(
                "العملاء",
                style: Styles.appbarstyle,
              ),
              bottom: TabBar(
                  dragStartBehavior: DragStartBehavior.down,
                  padding: EdgeInsets.all(5),
                  labelPadding: EdgeInsets.all(10),
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: appcolors.maincolor,
                  indicator: BoxDecoration(
                      color: appcolors.primarycolor,
                      borderRadius: BorderRadius.circular(15)),
                  tabs: [
                    Text(
                      "عملاء الحقن",
                      style: Styles.appbarstyle,
                    ),
                    Text(
                      "عملاء الاسطمبات",
                      style: Styles.appbarstyle,
                    ),
                  ]),
            ),
            body: TabBarView(children: [
              injectioncustomers(),
              moldcustomers(),
            ])));
  }
}
