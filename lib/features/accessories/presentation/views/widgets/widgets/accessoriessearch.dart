import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/error.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:agman/features/accessories/presentation/views/widgets/widgets/accessoriesearchitem.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Accessoriessearch extends StatefulWidget {
  final String startdate;
  final String enddate;

  Accessoriessearch(
      {super.key, required this.startdate, required this.enddate});
  @override
  State<Accessoriessearch> createState() => _AccessoriessearchState();
}

class _AccessoriessearchState extends State<Accessoriessearch> {
  final accessoriesheader = [
    "الكميه قبل الجرد",
    "اجمالي الشراء",
    "اجمالي البيع",
    "اجمالي الاستهلاك",
    "الكميه بعد الجرد",
  ];

  getdata() async {
    BlocProvider.of<plasticaccessoriesCubit>(context).getaccessorieswithsearch(
        datefrom: widget.startdate, dateto: widget.enddate);
  }

  @override
  void initState() {
    getdata();
  }

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
                "الجرد من ${widget.startdate}  حتي    ${widget.enddate}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: LayoutBuilder(builder: (context, constrains) {
              return Column(children: [
                Container(
                  height: 50,
                  color: appcolors.maincolor.withOpacity(0.7),
                  child: Row(
                      children: accessoriesheader
                          .map((e) => customheadertable(
                                textStyle:
                                    Styles.getheadertextstyle(context: context),
                                title: e,
                                flex: 3,
                              ))
                          .toList()),
                ),
                Expanded(
                    child: RefreshIndicator(
                        onRefresh: () async {},
                        child: BlocBuilder<plasticaccessoriesCubit,
                            plasticaccessoriesState>(
                          builder: (context, state) {
                            if (state is getaccessoriesloading)
                              return loadingshimmer();
                            if (state is getaccessoriesfailure)
                              return errorfailure(
                                errormessage: state.errormessage,
                              );
                            return BlocProvider.of<plasticaccessoriesCubit>(context)
                                    .datasearch
                                    .isEmpty
                                ? nodata()
                                : ListView.separated(
                                    itemBuilder: (context, i) => Accessoriesearchitem(
                                        textStyle: Styles.gettabletextstyle(
                                            context: context),
                                        totalsell:
                                            BlocProvider.of<plasticaccessoriesCubit>(context)
                                                .datasearch[i]
                                                .sellPrice!,
                                        firsttime:
                                            BlocProvider.of<plasticaccessoriesCubit>(context)
                                                .datasearch[i]
                                                .dateFrom!
                                                .toString(),
                                        lasttime:
                                            BlocProvider.of<plasticaccessoriesCubit>(context)
                                                .datasearch[i]
                                                .dateTo!
                                                .toString(),
                                        totalconsume:
                                            BlocProvider.of<plasticaccessoriesCubit>(context)
                                                .datasearch[i]
                                                .dateFrom!
                                                .toString(),
                                        totalbuy:
                                            BlocProvider.of<plasticaccessoriesCubit>(context)
                                                .datasearch[i]
                                                .dateFrom!
                                                .toString()),
                                    separatorBuilder: (context, i) => Divider(
                                          color: Colors.grey,
                                        ),
                                    itemCount:
                                        BlocProvider.of<plasticaccessoriesCubit>(context)
                                            .datasearch
                                            .length);
                          },
                        ))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.picture_as_pdf,
                            color: Colors.white,
                          ),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                    InkWell(
                        onTap: () async {},
                        child: Container(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                              color: appcolors.primarycolor,
                              borderRadius: BorderRadius.circular(7)),
                        )),
                    SizedBox(
                      width: 7,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ]);
            })));
  }
}
