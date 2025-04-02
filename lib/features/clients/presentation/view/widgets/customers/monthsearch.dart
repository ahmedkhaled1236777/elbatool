import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/features/clients/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Monthsearch extends StatefulWidget {
  int clientid;

  Monthsearch({required this.clientid});
  @override
  State<Monthsearch> createState() => _MonthsearchState();
}

class _MonthsearchState extends State<Monthsearch> {
  int? month;

  int? year;

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SizedBox(
                  width: MediaQuery.sizeOf(context).width > 950
                      ? MediaQuery.sizeOf(context).width * 0.25
                      : MediaQuery.sizeOf(context).width * 1,
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Text('بحث بواسطة',
                                style: Styles.textStyle12
                                    .copyWith(color: appcolors.maincolor),
                                textAlign: TextAlign.right),
                            const SizedBox(
                              height: 15,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate3(context);
                                  },
                                  date:
                                      BlocProvider.of<DateCubit>(context).date3,
                                );
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  onPressed: () {
                                    BlocProvider.of<DateCubit>(context)
                                        .changedate4(context);
                                  },
                                  date:
                                      BlocProvider.of<DateCubit>(context).date4,
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
                                      DropdownButtonProps(color: Colors.white),
                                  popupProps: PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps()),
                                  selectedItem:
                                      BlocProvider.of<CustomersCubit>(context)
                                          .searchtype,
                                  items:
                                      BlocProvider.of<CustomersCubit>(context)
                                          .searchtypes,
                                  onChanged: (value) {
                                    BlocProvider.of<CustomersCubit>(context)
                                        .changesearchtype(value: value!);
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
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color(0xff535C91)),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          )),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            custommaterialbutton(
                              button_name: "بحث",
                              onPressed: () async {
                                BlocProvider.of<CustomersCubit>(context)
                                    .queryparms = {
                                  "client_id": widget.clientid,
                                  if (BlocProvider.of<DateCubit>(context)
                                          .date3 !=
                                      "التاريخ من")
                                    "date_from":
                                        BlocProvider.of<DateCubit>(context)
                                            .date3,
                                  if (BlocProvider.of<DateCubit>(context)
                                          .date4 !=
                                      "التاريخ الي")
                                    "date_to":
                                        BlocProvider.of<DateCubit>(context)
                                            .date4,
                                  if (BlocProvider.of<CustomersCubit>(context)
                                          .searchtype !=
                                      "اختر مجال البحث")
                                    "type": BlocProvider.of<CustomersCubit>(
                                                context)
                                            .searchtypemap[
                                        BlocProvider.of<CustomersCubit>(context)
                                            .searchtype]
                                };
                                print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
                                print(BlocProvider.of<CustomersCubit>(context)
                                    .queryparms);
                                await BlocProvider.of<CustomersCubit>(context)
                                    .getclientmoves();
                                Navigator.pop(context);
                              },
                            )
                          ]))))
            ])));
  }
}

Future<void> _onPressed({
  required BuildContext context,
  String? locale,
}) async {}
