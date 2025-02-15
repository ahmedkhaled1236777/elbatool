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
import 'package:agman/features/suppliers/presentation/view/addsupplier.dart';
import 'package:agman/features/suppliers/presentation/view/supplieritem.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/addSUPPLIERmotion.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/widgets/alertcontent.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/widgets/SUPPLIERdesc.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/widgets/editsupplierdialog.dart';
import 'package:agman/features/suppliers/presentation/viewmodel/suppliers/suppliers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Suppliers extends StatefulWidget {
  @override
  State<Suppliers> createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  final supplierheader = [
    "اسم المورد",
    "رقم الهاتف",
    "الجهه",
    "تعديل",
    "حذف",
  ];
  getdata() async {
    await BlocProvider.of<SupplierssCubit>(context).getSuppliers();
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                          content: Alertsuppliercontent(),
                        );
                      });
                },
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
          ],
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: const Text(
            "الموردين",
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
                  children: supplierheader
                      .map((e) => customheadertable(
                            textStyle:
                                Styles.getheadertextstyle(context: context),
                            title: e,
                            flex: e == "تعديل" || e == "حذف" || e == "الجهه"
                                ? 2
                                : 3,
                          ))
                      .toList()),
            ),
            Expanded(
                child: RefreshIndicator(
                    onRefresh: () async {},
                    child: BlocBuilder<SupplierssCubit, SupplierssState>(
                      builder: (context, state) {
                        if (state is getSuppliergfailure)
                          return errorfailure(errormessage: state.errormessage);
                        if (state is getSuppliersloading)
                          return loadingshimmer();
                        return BlocProvider.of<SupplierssCubit>(context)
                                .suppliers
                                .isEmpty
                            ? nodata()
                            : ListView.separated(
                                itemBuilder: (context, i) => InkWell(
                                      onTap: () {
                                        navigateto(
                                            context: context,
                                            page: AddSuppliersmotion());
                                      },
                                      child: customtablsupplieritem(
                                          textStyle: Styles.gettabletextstyle(
                                              context: context),
                                          name:
                                              BlocProvider.of<SupplierssCubit>(
                                                          context)
                                                      .suppliers[i]
                                                      .name ??
                                                  "",
                                          phone:
                                              BlocProvider.of<SupplierssCubit>(
                                                          context)
                                                      .suppliers[i]
                                                      .phone ??
                                                  "",
                                          place:
                                              BlocProvider.of<SupplierssCubit>(
                                                          context)
                                                      .suppliers[i]
                                                      .industry ??
                                                  "",
                                          edit: IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    barrierDismissible: false,
                                                    // user must tap button!
                                                    context: context,
                                                    builder: (_) {
                                                      return AlertDialog(
                                                          title: Container(
                                                            alignment: Alignment
                                                                .topLeft,
                                                            child: IconButton(
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                                icon: const Icon(
                                                                    Icons
                                                                        .close)),
                                                          ),
                                                          surfaceTintColor:
                                                              Colors.white,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          0)),
                                                          content:
                                                              editsupplierdialog(
                                                            id: BlocProvider.of<
                                                                        SupplierssCubit>(
                                                                    context)
                                                                .suppliers[i]
                                                                .id!,
                                                            place: TextEditingController(
                                                                text: BlocProvider.of<
                                                                            SupplierssCubit>(
                                                                        context)
                                                                    .suppliers[
                                                                        i]
                                                                    .industry),
                                                            Suppliername: TextEditingController(
                                                                text: BlocProvider.of<
                                                                            SupplierssCubit>(
                                                                        context)
                                                                    .suppliers[
                                                                        i]
                                                                    .name),
                                                            phone: TextEditingController(
                                                                text: BlocProvider.of<
                                                                            SupplierssCubit>(
                                                                        context)
                                                                    .suppliers[
                                                                        i]
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
                                                        SupplierssCubit,
                                                        SupplierssState>(
                                                      listener:
                                                          (context, state) {
                                                        if (state
                                                            is deleteSuppliersuccess) {
                                                          Navigator.pop(
                                                              context);

                                                          showtoast(
                                                              message: state
                                                                  .successmesssage,
                                                              toaststate:
                                                                  Toaststate
                                                                      .succes,
                                                              context: context);
                                                        }
                                                        if (state
                                                            is deleteSupplierfailure) {
                                                          Navigator.pop(
                                                              context);

                                                          showtoast(
                                                              message: state
                                                                  .errormessage,
                                                              toaststate:
                                                                  Toaststate
                                                                      .error,
                                                              context: context);
                                                        }
                                                      },
                                                      builder:
                                                          (context, state) {
                                                        if (state
                                                            is deleteSupplierloading)
                                                          return deleteloading();
                                                        return SizedBox(
                                                          height: 50,
                                                          width: 100,
                                                          child: ElevatedButton(
                                                              style:
                                                                  const ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStatePropertyAll(
                                                                        Color.fromARGB(
                                                                            255,
                                                                            37,
                                                                            163,
                                                                            42)),
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                await BlocProvider.of<
                                                                            SupplierssCubit>(
                                                                        context)
                                                                    .deletesupplier(
                                                                        supplierid: BlocProvider.of<SupplierssCubit>(context)
                                                                            .suppliers[i]
                                                                            .id!);
                                                              },
                                                              child: const Text(
                                                                "تاكيد",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    fontFamily:
                                                                        "cairo",
                                                                    color: Colors
                                                                        .white),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
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
                                itemCount:
                                    BlocProvider.of<SupplierssCubit>(context)
                                        .suppliers
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
                InkWell(
                    onTap: () async {
                      BlocProvider.of<SupplierssCubit>(context)
                          .changetype(value: "SUPPLY");
                      BlocProvider.of<SupplierssCubit>(context)
                          .changepaymenttype(value: "cash");
                      navigateto(context: context, page: addsupplier());
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
                  width: 7,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ]);
        }));
  }
}
