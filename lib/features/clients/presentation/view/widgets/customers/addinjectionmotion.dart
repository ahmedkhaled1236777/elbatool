import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/clients/data/models/clientmodelrequestmotion.dart';
import 'package:agman/features/clients/presentation/view/widgets/mold/radios.dart';
import 'package:agman/features/clients/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:agman/features/wallets/presentation/viewmodel/wallet/wallet_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addinjectionmotion extends StatefulWidget {
  final int clientid;
  final String clientname;
  const Addinjectionmotion(
      {super.key, required this.clientid, required this.clientname});
  @override
  State<Addinjectionmotion> createState() => _AddinjectionmotionState();
}

class _AddinjectionmotionState extends State<Addinjectionmotion> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController desc = TextEditingController();

  TextEditingController quantity = TextEditingController();
  TextEditingController putcost = TextEditingController();
  TextEditingController pieceprice = TextEditingController();
  getdata() async {
    if (BlocProvider.of<WalletCubit>(context).data.isEmpty && this.mounted)
      await BlocProvider.of<WalletCubit>(context).getwallets();
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
                "اضافة حركة عميل ${widget.clientname}",
                style: Styles.appbarstyle,
              ),
            ),
            body: BlocBuilder<CustomersCubit, CustomersState>(
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
                                  height: 7,
                                ),
                                radiostypes(
                                  sixradio: "ta7weel",
                                  sixradiotittle: "تحويل",
                                  fifthradio: "back",
                                  fifthradiotitle: "مرتجع",
                                  fourthradio: "syana",
                                  firstradio: "7aan",
                                  secondradio: "naqdi",
                                  thirdradio: "stampa",
                                  firstradiotitle: "حقن",
                                  secondradiotitle: "نقدي",
                                  thirdradiotittle: "اسطمبه",
                                  fourthradiotittle: "صيانه",
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "naqdi" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "ta7weel" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "back")
                                  monytypesradios(
                                    firstradio: "7aan",
                                    secondradio: "syana",
                                    firstradiotitle: "حقن",
                                    secondradiotitle: "صيانه",
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
                                SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                        .type ==
                                    "ta7weel")
                                  Column(
                                    children: [
                                      Container(
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
                                            selectedItem:
                                                BlocProvider.of<WalletCubit>(
                                                        context)
                                                    .walletname,
                                            items: BlocProvider.of<WalletCubit>(
                                                    context)
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
                                                        fontFamily: "cairo"),
                                                    textAlign: TextAlign.center,
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
                                                                .circular(10),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Color(
                                                                0xff535C91)),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    )),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                SizedBox(height: 10),
                                const SizedBox(
                                  height: 10,
                                ),
                                custommytextform(
                                  controller: desc,
                                  hintText: "التوضيح",
                                  val: "برجاء ادخال اسم التوضيح",
                                ),
                                SizedBox(height: 10),
                                if (BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "stampa" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "7aan" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "back" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "syana")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: quantity,
                                    hintText: "الكميه",
                                    val: "برجاء ادخال الكميه",
                                  ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "stampa" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "syana" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "back" ||
                                    BlocProvider.of<CustomersCubit>(context)
                                            .type ==
                                        "7aan")
                                  const SizedBox(
                                    height: 10,
                                  ),
                                custommytextform(
                                  keyboardType: TextInputType.number,
                                  controller: pieceprice,
                                  hintText: BlocProvider.of<CustomersCubit>(
                                                      context)
                                                  .type ==
                                              "7aan" ||
                                          BlocProvider.of<CustomersCubit>(
                                                      context)
                                                  .type ==
                                              "syana" ||
                                          BlocProvider.of<CustomersCubit>(
                                                      context)
                                                  .type ==
                                              "back" ||
                                          BlocProvider.of<CustomersCubit>(
                                                      context)
                                                  .type ==
                                              "stampa"
                                      ? "سعر الوحده"
                                      : "المبلغ المدفوع",
                                  val: "برجاء ادخال المبلغ",
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                if (BlocProvider.of<CustomersCubit>(context)
                                        .paymenttype ==
                                    "ta7weel")
                                  custommytextform(
                                    keyboardType: TextInputType.number,
                                    controller: putcost,
                                    hintText: "رسوم الايداع",
                                    val: "برجاء ادخال رسوم الايداع المدفوع",
                                  ),
                                const SizedBox(
                                  height: 20,
                                ),
                                BlocConsumer<CustomersCubit, CustomersState>(
                                  listener: (context, state) {
                                    if (state is addclientmovefailure) {
                                      showtoast(
                                          message: state.errormessage,
                                          toaststate: Toaststate.error,
                                          context: context);
                                    }
                                    if (state is addclientmovesuccess) {
                                      quantity.clear();
                                      pieceprice.clear();
                                      desc.clear();
                                      showtoast(
                                          message: state.successmessage,
                                          toaststate: Toaststate.succes,
                                          context: context);
                                      BlocProvider.of<CustomersCubit>(context)
                                          .queryparms = {
                                        "client_id": widget.clientid,
                                      };
                                      BlocProvider.of<CustomersCubit>(context)
                                          .getclientmoves();
                                      BlocProvider.of<CustomersCubit>(context)
                                          .getCustomers();
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is addclientmoveloading)
                                      return loading();
                                    return custommaterialbutton(
                                      button_name: "تسجيل عميل",
                                      onPressed: () async {
                                        BlocProvider.of<CustomersCubit>(context)
                                            .addclientmove(
                                                clientmove: clientmoverequest(
                                                    moneytype: BlocProvider.of<CustomersCubit>(context).type ==
                                                                "naqdi" ||
                                                            BlocProvider.of<CustomersCubit>(context).type ==
                                                                "ta7weel" ||
                                                            BlocProvider.of<CustomersCubit>(context).type ==
                                                                "back"
                                                        ? BlocProvider.of<CustomersCubit>(context)
                                                            .moneytype
                                                        : BlocProvider.of<CustomersCubit>(context).type ==
                                                                "7aan"
                                                            ? "7aan"
                                                            : "syana",
                                                    saveid: BlocProvider.of<CustomersCubit>(context).type == "ta7weel"
                                                        ? BlocProvider.of<WalletCubit>(context)
                                                                .walletid[
                                                            BlocProvider.of<WalletCubit>(context)
                                                                .walletname]
                                                        : null,
                                                    qty: quantity.text.isEmpty
                                                        ? "1"
                                                        : quantity.text,
                                                    pieceprice:
                                                        pieceprice.text.isEmpty
                                                            ? null
                                                            : pieceprice.text,
                                                    date: BlocProvider.of<DateCubit>(context).date1,
                                                    type: BlocProvider.of<CustomersCubit>(context).type,
                                                    notes: desc.text.isEmpty ? "لا يوجد" : desc.text,
                                                    clientid: widget.clientid));
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
