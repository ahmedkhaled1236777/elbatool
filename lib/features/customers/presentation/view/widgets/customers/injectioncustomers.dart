import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/constants.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/core/common/widgets/headerwidget.dart';
import 'package:agman/features/customers/presentation/view/widgets/customerdesc.dart';
import 'package:agman/features/customers/presentation/view/widgets/customeritem.dart';
import 'package:agman/features/customers/presentation/view/widgets/customers/addinjectionmotion.dart';
import 'package:agman/features/customers/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class injectioncustomers extends StatelessWidget {
  final customerheader = [
    "اسم العميل",
    "رقم الهاتف",
    "اجمالي الحقن",
    "اجمالي الاسطمبات",
    "تعديل",
    "حذف",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
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
                onPressed: () {},
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {},
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
            Expanded(
                child: RefreshIndicator(
                    onRefresh: () async {},
                    child: ListView.separated(
                        itemBuilder: (context, i) => InkWell(
                              onTap: () {
                                BlocProvider.of<CustomersCubit>(context)
                                    .changetype(value: "INJECTION");
                                BlocProvider.of<CustomersCubit>(context)
                                    .changepaymenttype(value: "cash");
                                navigateto(
                                    context: context,
                                    page: Customerdesc(
                                      checks: BlocProvider.of<CustomersCubit>(
                                              context)
                                          .injchecks,
                                      pagename: "inj",
                                      textStyle: Styles.gettabletextstyle(
                                          context: context),
                                      name: "INJECTION",
                                      page: Addinjectionmotion(),
                                      date: "22/7/2024",
                                      desc: "حقن+خامه",
                                      quantity: "20",
                                      pieceprice: "200",
                                      total: "4000",
                                      type: "حقن",
                                    ));
                              },
                              child: customtablcustomeritem(
                                  textStyle: Styles.gettabletextstyle(
                                      context: context),
                                  name: 'محمد سيد',
                                  phone: "01552770367",
                                  totalinjection: "300",
                                  totalmold: "400",
                                  edit: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        editeicon,
                                      )),
                                  delet: IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        deleteicon,
                                        color: Colors.red,
                                      ))),
                            ),
                        separatorBuilder: (context, i) => Divider(
                              color: Colors.grey,
                            ),
                        itemCount: 5))),
            SizedBox(
              height: 10,
            ),
          ]);
        }));
  }
}
