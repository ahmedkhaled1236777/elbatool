import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:agman/features/factorytools/presentation/viewmodel/factorytools/factorytools_cubit.dart';
import 'package:agman/features/materiales/presentation/viewmodel/cubit/material_cubit.dart';
import 'package:agman/features/suppliers/data/models/suppliermotionrequest.dart';
import 'package:agman/features/suppliers/presentation/view/widgets/radios.dart';
import 'package:agman/features/suppliers/presentation/viewmodel/suppliers/suppliers_cubit.dart';
import 'package:agman/features/wallets/presentation/viewmodel/wallet/wallet_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddSuppliersmotion extends StatefulWidget {
  final int supplierid;

  const AddSuppliersmotion({super.key, required this.supplierid});
  @override
  State<AddSuppliersmotion> createState() => _AddSuppliersmotionState();
}

class _AddSuppliersmotionState extends State<AddSuppliersmotion> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController type = TextEditingController();

  TextEditingController desc = TextEditingController();

  TextEditingController quantity = TextEditingController();
  TextEditingController accessoriesell = TextEditingController();
  TextEditingController accessoriebuy = TextEditingController();
  TextEditingController putcost = TextEditingController();
  TextEditingController pieceprice = TextEditingController();
  TextEditingController totalvalue = TextEditingController();
  TextEditingController payedvalue = TextEditingController();
  Getdata() async {
    if (BlocProvider.of<plasticMaterialCubit>(context).materialsnames.isEmpty)
      await BlocProvider.of<plasticMaterialCubit>(context)
          .getMaterials(page: 1);
    if (BlocProvider.of<plasticaccessoriesCubit>(context)
        .accessoriesnames
        .isEmpty)
      await BlocProvider.of<plasticaccessoriesCubit>(context).getaccessories();
    if (BlocProvider.of<FactorytoolsCubit>(context).tools.isEmpty)
      await BlocProvider.of<FactorytoolsCubit>(context).getfactorytools();
    if (BlocProvider.of<WalletCubit>(context).wallets.isEmpty)
      await BlocProvider.of<WalletCubit>(context).getwallets();
  }

  @override
  void initState() {
    Getdata();
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
              title: const Text(
                "اضافة حركة مورد",
                style: Styles.appbarstyle,
              ),
            ),
            body: BlocBuilder<SupplierssCubit, SupplierssState>(
              builder: (context, state) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            "assets/images/inj.png",
                          ))),
                  child: Center(
                    child: Form(
                        key: formkey,
                        child: Container(
                          height: MediaQuery.sizeOf(context).height,
                          margin: EdgeInsets.all(
                              MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                  MediaQuery.sizeOf(context).width < 600
                                      ? 0
                                      : 15)),
                          width: MediaQuery.sizeOf(context).width > 650
                              ? MediaQuery.sizeOf(context).width * 0.4
                              : double.infinity,
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 12, right: 9),
                              child: SingleChildScrollView(
                                  child: Column(children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                RadiosSUPPLIERtypes(
                                  firstradio: "SUPPLY",
                                  secondradio: "PAYMENT",
                                  thirdradio: "Back",
                                  firstradiotitle: "توريد",
                                  secondradiotitle: "دفعه",
                                  thirdradiotitle: "مرتجع",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type !=
                                        "SUPPLY" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .type !=
                                        "Back")
                                  supplierradios(
                                    firstradio: "cash",
                                    secondradio: "transported",
                                    firstradiotitle: "نقدي",
                                    secondradiotitle: "تحويل",
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                        .type ==
                                    "SUPPLY")
                                  SizedBox(
                                    height: 10,
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                        .type ==
                                    "SUPPLY")
                                  supplierradioadd(
                                      firstradio: "material",
                                      secondradio: "accessories",
                                      thirdradio: "factorytools",
                                      fourthradio: "other",
                                      thirdradiotittle: "ادوات المصنع",
                                      fourthradiotittle: "اخري",
                                      firstradiotitle: "الخامات",
                                      secondradiotitle: "الاكسسورات"),
                                SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "SUPPLY" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .supplypart ==
                                        "material")
                                  RadiosSUPPLIERtypesformaterial(
                                    firstradio: "pure",
                                    secondradio: "kasr_elkasara",
                                    thirdradio: "el_mkhraz",
                                    firstradiotitle: "بيور",
                                    secondradiotitle: "كشر كساره",
                                    thirdradiotitle: "مخرز",
                                  ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "SUPPLY" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .supplypart ==
                                        "accessories")
                                  BlocBuilder<plasticaccessoriesCubit,
                                      plasticaccessoriesState>(
                                    builder: (context, state) {
                                      if (state is getaccessoriesloading)
                                        return loading();
                                      if (state is getaccessoriesfailure)
                                        return Text(state.errormessage);
                                      return Container(
                                        color: Color(0xff535C91),
                                        child: Center(
                                          child: BlocBuilder<
                                              plasticaccessoriesCubit,
                                              plasticaccessoriesState>(
                                            builder: (context, state) {
                                              return DropdownSearch<String>(
                                                dropdownButtonProps:
                                                    DropdownButtonProps(
                                                        color: Colors.white),
                                                popupProps: PopupProps.menu(
                                                    showSelectedItems: true,
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps()),
                                                selectedItem: BlocProvider.of<
                                                            plasticaccessoriesCubit>(
                                                        context)
                                                    .accessoriename,
                                                items: BlocProvider.of<
                                                            plasticaccessoriesCubit>(
                                                        context)
                                                    .accessoriesnames,
                                                onChanged: (value) {
                                                  BlocProvider.of<
                                                              plasticaccessoriesCubit>(
                                                          context)
                                                      .changeaccessorie(value!);
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                        baseStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "cairo"),
                                                        textAlign:
                                                            TextAlign.center,
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          enabled: true,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff535C91)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff535C91)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "SUPPLY" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .supplypart ==
                                        "material")
                                  BlocBuilder<plasticMaterialCubit,
                                      plasticMaterialState>(
                                    builder: (context, state) {
                                      if (state is GetMaterialsLoading)
                                        return loading();
                                      if (state is GetMaterialsFailure)
                                        return Text(state.errormessage);
                                      return Container(
                                        color: Color(0xff535C91),
                                        child: Center(
                                          child: BlocBuilder<
                                              plasticMaterialCubit,
                                              plasticMaterialState>(
                                            builder: (context, state) {
                                              return DropdownSearch<String>(
                                                dropdownButtonProps:
                                                    DropdownButtonProps(
                                                        color: Colors.white),
                                                popupProps: PopupProps.menu(
                                                    showSelectedItems: true,
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps()),
                                                selectedItem: BlocProvider.of<
                                                            plasticMaterialCubit>(
                                                        context)
                                                    .materialname,
                                                items: BlocProvider.of<
                                                            plasticMaterialCubit>(
                                                        context)
                                                    .materialsnames,
                                                onChanged: (value) {
                                                  BlocProvider.of<
                                                              plasticMaterialCubit>(
                                                          context)
                                                      .changematerialname(
                                                          value!);
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                        baseStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "cairo"),
                                                        textAlign:
                                                            TextAlign.center,
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          enabled: true,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff535C91)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff535C91)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "SUPPLY" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .supplypart ==
                                        "factorytools")
                                  BlocBuilder<FactorytoolsCubit,
                                      FactorytoolsState>(
                                    builder: (context, state) {
                                      if (state is gettoolloading)
                                        return loading();
                                      if (state is gettoolfailure)
                                        return Text(state.errormessage);
                                      return Container(
                                        color: Color(0xff535C91),
                                        child: Center(
                                          child: BlocBuilder<FactorytoolsCubit,
                                              FactorytoolsState>(
                                            builder: (context, state) {
                                              return DropdownSearch<String>(
                                                dropdownButtonProps:
                                                    DropdownButtonProps(
                                                        color: Colors.white),
                                                popupProps: PopupProps.menu(
                                                    showSelectedItems: true,
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps()),
                                                selectedItem: BlocProvider.of<
                                                            FactorytoolsCubit>(
                                                        context)
                                                    .toolname,
                                                items: BlocProvider.of<
                                                            FactorytoolsCubit>(
                                                        context)
                                                    .tools,
                                                onChanged: (value) {
                                                  BlocProvider.of<
                                                              FactorytoolsCubit>(
                                                          context)
                                                      .changettoolname(
                                                          value: value!);
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                        baseStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "cairo"),
                                                        textAlign:
                                                            TextAlign.center,
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          enabled: true,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff535C91)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff535C91)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                              );
                                            },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                SizedBox(
                                  height: 10,
                                ),
                                BlocBuilder<DateCubit, DateState>(
                                  builder: (context, state) {
                                    return choosedate(
                                      date: BlocProvider.of<DateCubit>(context)
                                          .date1,
                                      onPressed: () {
                                        BlocProvider.of<DateCubit>(context)
                                            .changedate(context);
                                      },
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<SupplierssCubit>(
                                                context)
                                            .paymenttype ==
                                        "transported" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .type !=
                                        "SUPPLY" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .type !=
                                        "Back")
                                  Column(
                                    children: [
                                      BlocBuilder<WalletCubit, walletState>(
                                        builder: (context, state) {
                                          if (state is getwalletloading)
                                            return loading();
                                          if (state is getwalletfailure)
                                            return Text(state.errormessage);
                                          return Container(
                                            color: Color(0xff535C91),
                                            child: Center(
                                              child: DropdownSearch<String>(
                                                dropdownButtonProps:
                                                    DropdownButtonProps(
                                                        color: Colors.white),
                                                popupProps: PopupProps.menu(
                                                    showSelectedItems: true,
                                                    showSearchBox: true,
                                                    searchFieldProps:
                                                        TextFieldProps()),
                                                selectedItem: BlocProvider.of<
                                                        WalletCubit>(context)
                                                    .walletname,
                                                items: BlocProvider.of<
                                                        WalletCubit>(context)
                                                    .wallets,
                                                onChanged: (value) {
                                                  BlocProvider.of<WalletCubit>(
                                                          context)
                                                      .changewalletname(value!);
                                                },
                                                dropdownDecoratorProps:
                                                    DropDownDecoratorProps(
                                                        baseStyle: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                "cairo"),
                                                        textAlign:
                                                            TextAlign.center,
                                                        dropdownSearchDecoration:
                                                            InputDecoration(
                                                          enabled: true,
                                                          enabledBorder:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff535C91)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          border:
                                                              OutlineInputBorder(
                                                            borderSide: BorderSide(
                                                                color: Color(
                                                                    0xff535C91)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 10),
                                custommytextform(
                                  controller: desc,
                                  hintText: "التوضيح",
                                  val: "برجاء ادخال اسم التوضيح",
                                ),
                                SizedBox(height: 10),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "SUPPLY" ||
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "Back")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: quantity,
                                    hintText: "الكميه",
                                    val: "برجاء ادخال الكميه",
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "SUPPLY" ||
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "Back")
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "SUPPLY" ||
                                    BlocProvider.of<SupplierssCubit>(context)
                                                .type ==
                                            "Back" &&
                                        BlocProvider.of<SupplierssCubit>(
                                                    context)
                                                .supplypart !=
                                            "accessories")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: pieceprice,
                                    hintText: "سعر الوحده",
                                    val: "برجاء ادخال سعر الوحده",
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "SUPPLY" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .supplypart ==
                                        "accessories")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: accessoriesell,
                                    hintText: "سعر الشراء",
                                    val: "برجاء ادخال سعر الشراء",
                                  ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                            .type ==
                                        "SUPPLY" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .supplypart ==
                                        "accessories")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: accessoriebuy,
                                    hintText: "سعر البيع",
                                    val: "برجاء ادخال سعر البيع",
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                        .type ==
                                    "SUPPLY")
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                        .type ==
                                    "PAYMENT")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: payedvalue,
                                    hintText: "المبلغ المدفوع",
                                    val: "برجاء ادخال المبلغ المدفوع",
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(context)
                                        .paymenttype ==
                                    "transported")
                                  const SizedBox(
                                    height: 10,
                                  ),
                                if (BlocProvider.of<SupplierssCubit>(
                                                context)
                                            .paymenttype ==
                                        "transported" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .type !=
                                        "SUPPLY" &&
                                    BlocProvider.of<SupplierssCubit>(context)
                                            .type !=
                                        "Back")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: putcost,
                                    hintText: "رسوم التحويل",
                                    val: "برجاء ادخال رسوم التحويل ",
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                BlocConsumer<SupplierssCubit, SupplierssState>(
                                  listener: (context, state) async {
                                    if (state is addsuppliermotionsuccess) {
                                      await BlocProvider.of<SupplierssCubit>(
                                              context)
                                          .getsuppliermovesmoves(queryparmes: {
                                        "supplier_id": widget.supplierid
                                      });
                                      showtoast(
                                          message: state.successmessage,
                                          toaststate: Toaststate.succes,
                                          context: context);
                                    }
                                    if (state is addsuppliermotionfailure) {
                                      showtoast(
                                          message: state.errormessage,
                                          toaststate: Toaststate.error,
                                          context: context);
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is addsuppliermotionloading)
                                      return loading();
                                    return custommaterialbutton(
                                      button_name: "تسجيل",
                                      onPressed: () async {
                                        BlocProvider.of<SupplierssCubit>(context)
                                            .addsuppliermotion(
                                                supplier: Suppliermotionrequest(
                                                    electronicsaveid: BlocProvider.of<SupplierssCubit>(context).type == "PAYMENT" &&
                                                            BlocProvider.of<SupplierssCubit>(context)
                                                                    .paymenttype ==
                                                                "transported"
                                                        ? BlocProvider.of<WalletCubit>(context).walletid[
                                                            BlocProvider.of<WalletCubit>(context)
                                                                .walletname]
                                                        : null,
                                                    supplierid:
                                                        widget.supplierid,
                                                    status: BlocProvider.of<SupplierssCubit>(context).type ==
                                                            "SUPPLY"
                                                        ? "1"
                                                        : BlocProvider.of<SupplierssCubit>(context).type ==
                                                                "PAYMENT"
                                                            ? "0"
                                                            : "2",
                                                    date: BlocProvider.of<DateCubit>(context)
                                                        .date1,
                                                    notes: desc.text,
                                                    quantity: quantity.text.isEmpty
                                                        ? 1
                                                        : double.parse(quantity.text),
                                                    price: double.parse(pieceprice.text),
                                                    materialtype: BlocProvider.of<SupplierssCubit>(context).supplypart == "material" && BlocProvider.of<SupplierssCubit>(context).type == "SUPPLY" ? BlocProvider.of<SupplierssCubit>(context).materialtype : null,
                                                    sellprice: accessoriebuy.text.isEmpty ? 10 : double.parse(accessoriebuy.text),
                                                    type: BlocProvider.of<SupplierssCubit>(context).type == "Back" ? null : BlocProvider.of<SupplierssCubit>(context).supplypart,
                                                    typeid: BlocProvider.of<SupplierssCubit>(context).type == "SUPPLY"
                                                        ? BlocProvider.of<SupplierssCubit>(context).supplypart == "material"
                                                            ? BlocProvider.of<plasticMaterialCubit>(context).materialid[BlocProvider.of<plasticMaterialCubit>(context).materialname]
                                                            : BlocProvider.of<SupplierssCubit>(context).supplypart == "accessories"
                                                                ? BlocProvider.of<plasticaccessoriesCubit>(context).accessorieid[BlocProvider.of<plasticaccessoriesCubit>(context).accessoriename]
                                                                : BlocProvider.of<SupplierssCubit>(context).supplypart == "factorytools"
                                                                    ? BlocProvider.of<FactorytoolsCubit>(context).factorytoolsid[BlocProvider.of<FactorytoolsCubit>(context).toolname]
                                                                    : null
                                                        : null));
                                      },
                                    );
                                  },
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ]))),
                        )),
                  ),
                );
              },
            )));
  }
}
