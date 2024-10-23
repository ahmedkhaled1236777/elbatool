import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/date/date_cubit.dart';
import 'package:agman/core/common/navigation.dart';
import 'package:agman/core/common/widgets/choosedate.dart';
import 'package:agman/core/common/widgets/custommaterialbutton%20copy.dart';
import 'package:agman/core/common/widgets/customtextform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_search/dropdown_search.dart';

class addreport extends StatefulWidget {
  @override
  State<addreport> createState() => _addreportState();
}

class _addreportState extends State<addreport> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController workername = TextEditingController();

  TextEditingController machinenumber = TextEditingController();

  TextEditingController cycletime = TextEditingController();

  TextEditingController workhours = TextEditingController();

  TextEditingController counterstart = TextEditingController();

  TextEditingController counterend = TextEditingController();

  TextEditingController realprodcountity = TextEditingController();

  TextEditingController shift = TextEditingController();

  TextEditingController notes = TextEditingController(text: "لا يوجد");

  String? x;

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
                "اضافة تقرير",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "cairo",
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
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
                              child: Column(children: [
                            const SizedBox(
                              height: 50,
                            ),
                            BlocBuilder<DateCubit, DateState>(
                              builder: (context, state) {
                                return choosedate(
                                  date:
                                      BlocProvider.of<DateCubit>(context).date1,
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
                                      DropdownButtonProps(color: Colors.white),
                                  popupProps: PopupProps.menu(
                                      showSelectedItems: true,
                                      showSearchBox: true,
                                      searchFieldProps: TextFieldProps()),
                                  selectedItem: "اختر الاوردر",
                                  items: [],
                                  onChanged: (value) {},
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
                            SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              controller: workername,
                              hintText: "اسم العامل",
                              val: "برجاء ادخال اسم العامل",
                            ),
                            SizedBox(height: 10),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              keyboardType: TextInputType.number,
                              controller: shift,
                              hintText: "رقم الورديه",
                              val: "برجاء ادخال رقم الورديه",
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                              controller: machinenumber,
                              hintText: "رقم الماكينه",
                              val: "برجاء ادخال رقم الماكينه",
                              keyboardType: TextInputType.number,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                                controller: cycletime,
                                hintText: "زمن الدوره",
                                val: "برجاء ادخال زمن الدوره",
                                keyboardType: TextInputType.number),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                                controller: workhours,
                                hintText: "عدد ساعات التشغيل",
                                val: "برجاء ادخال عدد ساعات التشغيل",
                                keyboardType: TextInputType.number),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                                controller: counterstart,
                                hintText: "بداية العداد",
                                val: "برجاء ادخال بداية العداد",
                                keyboardType: TextInputType.number),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                                controller: counterend,
                                hintText: "نهاية العداد",
                                val: "برجاء ادخال نهاية العداد",
                                keyboardType: TextInputType.number),
                            const SizedBox(
                              height: 10,
                            ),
                            custommytextform(
                                controller: notes, hintText: "الملاحظات"),
                            const SizedBox(
                              height: 20,
                            ),
                            custommaterialbutton(
                              button_name: "تسجيل التقرير",
                              onPressed: () async {},
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ]))),
                    )),
              ),
            )));
  }
}
