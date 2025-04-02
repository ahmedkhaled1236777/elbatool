import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/error.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/core/common/widgets/loading.dart';
import 'package:agman/core/common/widgets/nodata.dart';
import 'package:agman/core/common/widgets/shimmerloading.dart';
import 'package:agman/core/common/widgets/showdialogerror.dart';
import 'package:agman/features/clients/presentation/view/widgets/alertcontent.dart';
import 'package:agman/features/clients/presentation/view/widgets/customermoves.dart';
import 'package:agman/features/clients/presentation/view/widgets/customeritem.dart';
import 'package:agman/features/clients/presentation/view/widgets/customers/addcustomer.dart';
import 'package:agman/features/clients/presentation/view/widgets/customers/editdialog.dart';
import 'package:agman/features/clients/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class injectioncustomers extends StatefulWidget {
  @override
  State<injectioncustomers> createState() => _injectioncustomersState();
}

class _injectioncustomersState extends State<injectioncustomers> {
  final customerheader = [
    "اسم العميل",
    "رقم الهاتف",
    "اجمالي الحقن",
    "اجمالي الاسطمبات",
    "الاجمالي",
    "تعديل",
    "حذف",
  ];
  getdata() async {
    await BlocProvider.of<CustomersCubit>(context).getCustomers();
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            navigateto(context: context, page: addcustomer());
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: appcolors.primarycolor,
        ),
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  await BlocProvider.of<CustomersCubit>(context).getCustomers();
                },
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
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
                            content: Alertcontent());
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
            "العملاء",
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
                  children: customerheader
                      .map((e) => customheadertable(
                            textStyle:
                                Styles.getheadertextstyle(context: context),
                            title: e,
                            flex: e == "تعديل" ||
                                    e == "حذف" ||
                                    e == "الجهه" ||
                                    e == "تحديد"
                                ? 2
                                : 3,
                          ))
                      .toList()),
            ),
            Expanded(child: BlocBuilder<CustomersCubit, CustomersState>(
              builder: (context, state) {
                if (state is getCustomersloading) return loadingshimmer();
                if (state is getCustomergfailure)
                  return errorfailure(errormessage: state.errormessage);
                return BlocProvider.of<CustomersCubit>(context).clients.isEmpty
                    ? nodata()
                    : ListView.separated(
                        itemBuilder: (context, i) => InkWell(
                              onTap: () {
                                navigateto(
                                    context: context,
                                    page: Customermoves(
                                        clientid:
                                            BlocProvider.of<CustomersCubit>(
                                                    context)
                                                .clients[i]
                                                .id!,
                                        clientname:
                                            BlocProvider.of<CustomersCubit>(
                                                    context)
                                                .clients[i]
                                                .name!));
                              },
                              child: customtablcustomeritem(
                                  total:
                                      BlocProvider.of<CustomersCubit>(context)
                                          .total[i]
                                          .toString(),
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  name: BlocProvider.of<CustomersCubit>(context)
                                          .clients[i]
                                          .name ??
                                      "",
                                  phone:
                                      BlocProvider.of<CustomersCubit>(context)
                                              .clients[i]
                                              .phone ??
                                          "",
                                  totalinjection:
                                      BlocProvider.of<CustomersCubit>(context)
                                          .clients[i]
                                          .total7aan
                                          .toString(),
                                  totalmold:
                                      BlocProvider.of<CustomersCubit>(context)
                                          .clients[i]
                                          .totalStamba
                                          .toString(),
                                  edit: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            barrierDismissible: false,
                                            // user must tap button!
                                            context: context,
                                            builder: (_) {
                                              return AlertDialog(
                                                  title: Container(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        icon: const Icon(
                                                            Icons.close)),
                                                  ),
                                                  surfaceTintColor:
                                                      Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              0)),
                                                  content: editAlertcontent(
                                                    id: BlocProvider.of<
                                                                CustomersCubit>(
                                                            context)
                                                        .clients[i]
                                                        .id!,
                                                    customername:
                                                        TextEditingController(
                                                            text: BlocProvider
                                                                    .of<CustomersCubit>(
                                                                        context)
                                                                .clients[i]
                                                                .name),
                                                    phone: TextEditingController(
                                                        text: BlocProvider.of<
                                                                    CustomersCubit>(
                                                                context)
                                                            .clients[i]
                                                            .phone),
                                                  ));
                                            });
                                      },
                                      icon: Icon(
                                        editeicon,
                                      )),
                                  delet: IconButton(
                                      onPressed: () {
                                        awsomdialogerror(
                                            context: context,
                                            mywidget: BlocConsumer<
                                                CustomersCubit, CustomersState>(
                                              listener: (context, state) {
                                                if (state
                                                    is deleteCustomersuccess) {
                                                  Navigator.pop(context);

                                                  showtoast(
                                                      message:
                                                          state.successmesssage,
                                                      toaststate:
                                                          Toaststate.succes,
                                                      context: context);
                                                }
                                                if (state
                                                    is deleteCustomerfailure) {
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
                                                    is deleteCustomerloading)
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
                                                                    CustomersCubit>(
                                                                context)
                                                            .deleteclient(
                                                                clientid: BlocProvider.of<
                                                                            CustomersCubit>(
                                                                        context)
                                                                    .clients[i]
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
                                            tittle: "هل تريد الحذف ؟");
                                      },
                                      icon: Icon(
                                        deleteicon,
                                        color: Colors.red,
                                      ))),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: BlocProvider.of<CustomersCubit>(context)
                            .clients
                            .length);
              },
            )),
            SizedBox(
              height: 10,
            ),
          ]);
        }));
  }
}
