import 'package:agman/core/colors/colors.dart';

import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:agman/features/orders/presentation/view/widgets/customtableordermoves.dart';
import 'package:agman/features/orders/presentation/viewmodel/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ordermoves extends StatefulWidget {
  final int orderid;
  final String ordernumber;
  final String actualquantity;
  final String orderquantity;
  final String stampname;
  const ordermoves(
      {super.key,
      required this.orderid,
      required this.ordernumber,
      required this.actualquantity,
      required this.stampname,
      required this.orderquantity});
  @override
  State<ordermoves> createState() => _ordermovesState();
}

class _ordermovesState extends State<ordermoves> {
  final injectionheader = [
    "التاريخ",
    "الكميه",
    "الورديه",
    "اسم الموظف",
  ];
  ScrollController scrollController = ScrollController();

  getdata() async {
    BlocProvider.of<OrdersCubit>(context).getordersmoves(id: widget.orderid);
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
                " متابعة امر الشغل رقم  ${widget.ordernumber}",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(children: [
              Container(
                height: 50,
                color: appcolors.maincolor.withOpacity(0.7),
                child: Row(
                    children: injectionheader
                        .map((e) => customheadertable(
                              textStyle:
                                  Styles.getheadertextstyle(context: context),
                              title: e,
                              flex: e == "الورديه" ? 2 : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: BlocConsumer<OrdersCubit, OrdersState>(
                      listener: (context, state) {
                if (state is getordermovesfailure)
                  showtoast(
                      context: context,
                      message: state.errormessage,
                      toaststate: Toaststate.error);
              }, builder: (context, state) {
                if (state is getordermovesloading) return loadingshimmer();
                if (state is getordermovesfailure)
                  return SizedBox();
                else {
                  if (BlocProvider.of<OrdersCubit>(context).datamoves.isEmpty)
                    return nodata();
                  else {
                    return ListView.separated(
                        controller: scrollController,
                        itemBuilder: (context, i) => InkWell(
                              onTap: () {},
                              child: Customtableordermoves(
                                shift: BlocProvider.of<OrdersCubit>(context)
                                    .datamoves[i]
                                    .numberOfShift
                                    .toString(),
                                textStyle:
                                    Styles.gettabletextstyle(context: context),
                                date: BlocProvider.of<OrdersCubit>(context)
                                        .datamoves[i]
                                        .date ??
                                    "",
                                employee: BlocProvider.of<OrdersCubit>(context)
                                    .datamoves[i]
                                    .userName!,
                                quantaity: BlocProvider.of<OrdersCubit>(context)
                                    .datamoves[i]
                                    .qty
                                    .toString(),
                              ),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<OrdersCubit>(context)
                            .datamoves
                            .length);
                  }
                }
              })),
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
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
                    width: 15,
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              if (widget.stampname != "")
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  width: double.infinity,
                  color: Color(0xff535C91),
                  child: Column(
                    children: [
                      Text(
                        " الكميه المنتجه : ${widget.actualquantity}",
                        style:
                            TextStyle(fontFamily: "cairo", color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "  المتبقي من الاوردر : ${int.parse(widget.orderquantity) - int.parse(widget.actualquantity)}",
                        style:
                            TextStyle(fontFamily: "cairo", color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        " الوقت المتبقي لانتهاء الاوردر : ${((((int.parse(widget.orderquantity) - int.parse(widget.actualquantity)) * BlocProvider.of<MoldCubit>(context).moldid[widget.stampname]!["cycletime"]) / int.parse(BlocProvider.of<MoldCubit>(context).moldid[widget.stampname]!["numberofpieces"])) / (60 * 60)).toStringAsFixed(1)} ساعه  ",
                        style:
                            TextStyle(fontFamily: "cairo", color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
            ])));
  }
}
