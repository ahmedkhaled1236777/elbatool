import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:agman/core/common/widgets/dialogerror.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/accessories/presentation/viewmodel/cubit/accessories_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/view/accessoriescost/data/model/accessoriescostmodelrequest.dart';
import 'package:agman/features/moldmanufacture/presentation/view/accessoriescost/presentation/viewmodel/cubit/accessoriecost_cubit.dart';
import 'package:agman/features/moldmanufacture/presentation/viewmodel/costcuibt/costcuibt.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Addaccessoriecost extends StatefulWidget {
  final int stampid;

  Addaccessoriecost({super.key, required this.stampid});

  @override
  State<Addaccessoriecost> createState() => _AddaccessoriecostState();
}

class _AddaccessoriecostState extends State<Addaccessoriecost> {
  TextEditingController quantity = TextEditingController();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  getdata() {
    BlocProvider.of<plasticaccessoriesCubit>(context).getaccessories();
  }

  @override
  void initState() {
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Colors.white,
          ),
          backgroundColor: appcolors.maincolor,
          centerTitle: true,
          title: const Text(
            "اضافة تكلفه اوليه",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "cairo",
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<plasticaccessoriesCubit, plasticaccessoriesState>(
          builder: (context, state) {
            if (state is getaccessoriesloading) return loading();
            if (state is getaccessoriesfailure) return SizedBox();
            return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          "assets/images/inj.png",
                        ))),
                child: Center(
                  child: Container(
                    height: MediaQuery.sizeOf(context).height,
                    margin: EdgeInsets.all(
                        MediaQuery.sizeOf(context).width < 600 ? 0 : 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                            MediaQuery.sizeOf(context).width < 600 ? 0 : 15)),
                    width: MediaQuery.sizeOf(context).width > 650
                        ? MediaQuery.sizeOf(context).width * 0.4
                        : double.infinity,
                    child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 9),
                        child: SingleChildScrollView(
                            child: Form(
                                key: formkey,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 50,
                                    ),
                                    BlocBuilder<DateCubit, DateState>(
                                      builder: (context, state) {
                                        return choosedate(
                                          date: BlocProvider.of<DateCubit>(
                                                  context)
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
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xff535C91)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                  )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    custommytextform(
                                      val: "برجاء ادخال الكميه",
                                      controller: quantity,
                                      hintText: "الكميه",
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    custommytextform(
                                      val: "برجاء ادخال الملاحظات",
                                      controller: notes,
                                      hintText: "الملاحظات",
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    BlocConsumer<accessoriecostCubit,
                                        accessoriecostState>(
                                      listener: (context, state) {
                                        if (state is addaccessoriecostfailure) {
                                          showtoast(
                                              message: state.errormessage,
                                              toaststate: Toaststate.error,
                                              context: context);
                                        }

                                        if (state is addaccessoriecostsuccess) {
                                          BlocProvider.of<DateCubit>(context)
                                              .cleardates();
                                          notes.clear();

                                          BlocProvider.of<accessoriecostCubit>(
                                                  context)
                                              .getaccessoriescosts(
                                                  stampid: widget.stampid);
                                          BlocProvider.of<Costcuibt>(context)
                                              .getmoldmanufacture();
                                          showtoast(
                                              message: state.successmessage,
                                              toaststate: Toaststate.succes,
                                              context: context);
                                        }
                                        // TODO: implement listener
                                      },
                                      builder: (context, state) {
                                        if (state is addaccessoriecostloading)
                                          return loading();
                                        return custommaterialbutton(
                                          button_name: "تسجيل",
                                          onPressed: () async {
                                            if (BlocProvider.of<
                                                            plasticaccessoriesCubit>(
                                                        context)
                                                    .accessoriename ==
                                                "اختر الاكسسوار") {
                                              showdialogerror(
                                                  error:
                                                      "لابد من اختبار الاكسسوار",
                                                  context: context);
                                            } else {
                                              if (formkey.currentState!.validate())
                                                BlocProvider.of<accessoriecostCubit>(context).addaccessoriecost(
                                                    accessoriecost: accessoriecostmodelrequest(
                                                        accessorieid: BlocProvider.of<plasticaccessoriesCubit>(context)
                                                                .accessorieid[
                                                            BlocProvider.of<plasticaccessoriesCubit>(context)
                                                                .accessoriename]!,
                                                        notes: notes.text.isEmpty
                                                            ? "لا يوجد"
                                                            : notes.text,
                                                        date: BlocProvider.of<DateCubit>(
                                                                context)
                                                            .date1,
                                                        stampid: widget.stampid,
                                                        quantity: int.parse(
                                                            quantity.text)));
                                            }
                                          },
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height: 50,
                                    )
                                  ],
                                )))),
                  ),
                ));
          },
        ));
  }
}
