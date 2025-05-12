import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/features/clients/presentation/view/widgets/customermoves.dart';
import 'package:agman/features/clients/presentation/view/widgets/customers/monthsearch.dart';
import 'package:flutter/material.dart';

class clientmovestabbars extends StatefulWidget {
  final int clientid;
  final String clientname;

  clientmovestabbars(
      {super.key, required this.clientid, required this.clientname});

  @override
  State<clientmovestabbars> createState() => _clientmovestabbarsState();
}

class _clientmovestabbarsState extends State<clientmovestabbars> {
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
                    "الحقن",
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
                    "الاسطمبات",
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            title: Container(
                              height: 20,
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.close,
                                    color: appcolors.maincolor,
                                  )),
                            ),
                            contentPadding: EdgeInsets.all(10),
                            backgroundColor: Colors.white,
                            insetPadding: EdgeInsets.all(35),
                            content: Monthsearch(
                              status: index == 0 ? "7aan" : "syana",
                              clientid: widget.clientid,
                            ));
                      });
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () async {
                  /*  BlocProvider.of<CustomersCubit>(context).queryparms = {
                      "client_id": widget.clientid,
                    };
                    await BlocProvider.of<CustomersCubit>(context)
                        .getclientmoves();*/
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
          ],
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: Text(
            widget.clientname,
            style: Styles.appbarstyle,
          ),
        ),
        body: TabBarView(children: [
          Customermoves(
            clientid: widget.clientid,
            clientname: widget.clientname,
            status: "7aan",
          ),
          Customermoves(
            clientid: widget.clientid,
            clientname: widget.clientname,
            status: "syana",
          ),
        ]),
      ),
    );
  }
}
