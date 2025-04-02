import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/features/factorytools/presentation/viewmodel/factorytools/factorytools_cubit.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/customtablefactorytoolitem.dart';
import 'package:agman/features/factorytools/presentation/views/widgets/factorytoolitem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Factorytoolssearch extends StatefulWidget {
  final String startdate;
  final String enddate;

  const Factorytoolssearch(
      {super.key, required this.startdate, required this.enddate});
  @override
  State<Factorytoolssearch> createState() => _FactorytoolssearchState();
}

class _FactorytoolssearchState extends State<Factorytoolssearch> {
  final accessoriesheader = [
    "اسم الاداه",
    "اجمالي الشراء",
    "اجمالي الاستهلاك",
    "اجمالي البيع",
    "الكميه الحاليه",
    "الكميه قبل الجرد",
    "الكميه بعد الجرد",
  ];

  getdata() async {
    BlocProvider.of<FactorytoolsCubit>(context).getfactorytoolswithsearch(
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
                        child:
                            BlocBuilder<FactorytoolsCubit, FactorytoolsState>(
                          builder: (context, state) {
                            if (state is gettoolloading)
                              return loadingshimmer();
                            if (state is gettoolfailure) return SizedBox();
                            return BlocProvider.of<FactorytoolsCubit>(context)
                                    .data
                                    .isEmpty
                                ? nodata()
                                : ListView.separated(
                                    itemBuilder: (context, i) => InkWell(
                                          onTap: () {
                                            navigateto(
                                                context: context,
                                                page: Factorytoolitem(
                                                  id: BlocProvider.of<
                                                              FactorytoolsCubit>(
                                                          context)
                                                      .data[i]
                                                      .id!,
                                                ));
                                          },
                                          child: Customtablefactorytoolitem(
                                            lasttime: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .factools[i]
                                                .dateTo
                                                .toString(),
                                            firsttime: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .factools[i]
                                                .dateFrom
                                                .toString(),
                                            totalbuy: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .factools[i]
                                                .buyQty
                                                .toString(),
                                            totalconsume: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .factools[i]
                                                .dilapidatedQty
                                                .toString(),
                                            totalsell: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .factools[i]
                                                .salesQty
                                                .toString(),
                                            textStyle: Styles.gettabletextstyle(
                                                context: context),
                                            factorytoolname: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .factools[i]
                                                .name!,
                                            quantity: BlocProvider.of<
                                                    FactorytoolsCubit>(context)
                                                .factools[i]
                                                .qty!,
                                          ),
                                        ),
                                    separatorBuilder: (context, i) => Divider(
                                          color: Colors.grey,
                                        ),
                                    itemCount:
                                        BlocProvider.of<FactorytoolsCubit>(
                                                context)
                                            .factools
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
