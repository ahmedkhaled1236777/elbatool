import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/features/molds/presentation/viewmodel/mold/mold_cubit.dart';
import 'package:agman/features/orders/presentation/view/addorder.dart';
import 'package:agman/features/orders/presentation/view/widgets/alertcontent.dart';
import 'package:agman/features/orders/presentation/view/widgets/customtableproductionitem.dart';
import 'package:agman/features/orders/presentation/view/widgets/ordermoves.dart';
import 'package:agman/features/orders/presentation/viewmodel/cubit/orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Orders extends StatefulWidget {
  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  final injectionheader = [
    "التاريخ",
    "اسم\nالمنتج",
    "رقم\nالاوردر",
    "الكميه",
    "حالة\nالاوردر",
    "حذف",
  ];
  ScrollController scrollController = ScrollController();

  getdata() async {
    BlocProvider.of<OrdersCubit>(context).queryparms = null;
    await BlocProvider.of<OrdersCubit>(context).getorders();
    if (BlocProvider.of<MoldCubit>(context).molds.isEmpty) {
      await BlocProvider.of<MoldCubit>(context).getmolds();
    }
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
              actions: [
                IconButton(
                    onPressed: () async {
                      BlocProvider.of<OrdersCubit>(context).firstloading =
                          false;
                      BlocProvider.of<OrdersCubit>(context).queryparms = null;
                      await BlocProvider.of<OrdersCubit>(context).getorders();
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<DateCubit>(context).cleardates();

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
                              content: Alertinjectioncontent(),
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
              title: const Text(
                "اوردرات الحقن",
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
                              flex: e == "تعديل" ||
                                      e == "حذف" ||
                                      e == "اسم\nالخط" ||
                                      e == "حالة\nالاوردر"
                                  ? 2
                                  : 3,
                            ))
                        .toList()),
              ),
              Expanded(
                  child: BlocConsumer<OrdersCubit, OrdersState>(
                      listener: (context, state) {
                if (state is GetOrdersFailure)
                  showtoast(
                      context: context,
                      message: state.errormessage,
                      toaststate: Toaststate.error);
              }, builder: (context, state) {
                if (state is GetOrdersLoading) return loadingshimmer();
                if (state is GetOrdersFailure)
                  return SizedBox();
                else {
                  if (BlocProvider.of<OrdersCubit>(context).data.isEmpty)
                    return nodata();
                  else {
                    return ListView.separated(
                        controller: scrollController,
                        itemBuilder: (context, i) => InkWell(
                              onTap: () {
                                navigateto(
                                    context: context,
                                    page: ordermoves(
                                        orderquantity:
                                            BlocProvider.of<OrdersCubit>(
                                                    context)
                                                .data[i]
                                                .qtyOrder!,
                                        actualquantity:
                                            BlocProvider.of<OrdersCubit>(
                                                    context)
                                                .data[i]
                                                .qtyImplemented!
                                                .toString(),
                                        stampname: BlocProvider.of<OrdersCubit>(
                                                context)
                                            .data[i]
                                            .stampName!,
                                        orderid: BlocProvider.of<OrdersCubit>(
                                                context)
                                            .data[i]
                                            .id!,
                                        ordernumber:
                                            BlocProvider.of<OrdersCubit>(
                                                    context)
                                                .data[i]
                                                .orderNum!));
                              },
                              child: customtableinjectionshallitem(
                                  ordernumber:
                                      BlocProvider.of<OrdersCubit>(context)
                                              .data[i]
                                              .orderNum ??
                                          "",
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  status: int.parse(
                                              BlocProvider.of<OrdersCubit>(context)
                                                  .data[i]
                                                  .qtyOrder!) >
                                          BlocProvider.of<OrdersCubit>(context)
                                              .data[i]
                                              .qtyImplemented!
                                      ? false
                                      : true,
                                  date: BlocProvider.of<OrdersCubit>(context)
                                          .data[i]
                                          .date ??
                                      "",
                                  name:
                                      "${BlocProvider.of<OrdersCubit>(context).data[i].stampName}-${BlocProvider.of<OrdersCubit>(context).data[i].colorName}",
                                  quantaity:
                                      BlocProvider.of<OrdersCubit>(context)
                                          .data[i]
                                          .qtyOrder
                                          .toString(),
                                  delet: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<OrdersCubit,
                                                OrdersState>(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteOrderSuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      message:
                                                          state.successmessage,
                                                      toaststate:
                                                          Toaststate.succes,
                                                      context: context);
                                                }
                                                if (state
                                                    is DeleteOrdersFailure) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      message:
                                                          state.errormessage,
                                                      toaststate:
                                                          Toaststate.error,
                                                      context: context);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is DeleteOrdersLoading)
                                                  return deleteloading();
                                                return SizedBox(
                                                  height: 50,
                                                  width: 100,
                                                  child: ElevatedButton(
                                                      style: const ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Color.fromARGB(
                                                                    255,
                                                                    37,
                                                                    163,
                                                                    42)),
                                                      ),
                                                      onPressed: () async {
                                                        await BlocProvider.of<
                                                                    OrdersCubit>(
                                                                context)
                                                            .deleteorder(
                                                                orderid: BlocProvider.of<
                                                                            OrdersCubit>(
                                                                        context)
                                                                    .data[i]
                                                                    .id!);
                                                      },
                                                      child: const Text(
                                                        "تاكيد",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: "cairo",
                                                            color:
                                                                Colors.white),
                                                        textAlign:
                                                            TextAlign.center,
                                                      )),
                                                );
                                              },
                                            ),
                                            tittle:
                                                "هل تريد حذف الاوردر رقم ${BlocProvider.of<OrdersCubit>(context).data[i].orderNum}");
                                      },
                                      icon: Icon(
                                        deleteicon,
                                        color: Colors.red,
                                      ))),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount:
                            BlocProvider.of<OrdersCubit>(context).data.length);
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
                      onTap: () async {
                        navigateto(context: context, page: Addorder());
                      },
                      child: Container(
                        height: 45,
                        width: 45,
                        child: Icon(
                          Icons.add,
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
                height: 15,
              ),
            ])));
  }
}
