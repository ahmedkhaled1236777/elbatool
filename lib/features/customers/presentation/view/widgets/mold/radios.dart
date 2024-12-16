import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/features/customers/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:agman/features/suppliers/presentation/viewmodel/suppliers/suppliers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class radios extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  radios(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    var customerbloc = BlocProvider.of<CustomersCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: customerbloc.customeertype,
              onChanged: (val) {
                customerbloc.changetcustomerype(value: val!);
              }),
          Text(
            firstradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: customerbloc.customeertype,
              onChanged: (val) {
                customerbloc.changetcustomerype(value: val!);
              }),
          Text(
            secondradiotitle,
            style: Styles.textStyle12,
          ),
        ],
      ),
    );
  }
}

class radiostypes extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String thirdradio;
  final String fourthradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotittle;
  final String fourthradiotittle;
  radiostypes(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.thirdradio,
      required this.fourthradio,
      required this.thirdradiotittle,
      required this.fourthradiotittle,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    var customerbloc = BlocProvider.of<CustomersCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: customerbloc.type,
              onChanged: (val) {
                customerbloc.changetype(value: val!);
              }),
          Text(
            firstradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: fourthradio,
              groupValue: customerbloc.type,
              onChanged: (val) {
                customerbloc.changetype(value: val!);
              }),
          Text(
            fourthradiotittle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: thirdradio,
              groupValue: customerbloc.type,
              onChanged: (val) {
                customerbloc.changetype(value: val!);
              }),
          Text(
            thirdradiotittle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: customerbloc.type,
              onChanged: (val) {
                customerbloc.changetype(value: val!);
              }),
          Text(
            secondradiotitle,
            style: Styles.textStyle12.copyWith(color: Colors.green),
          ),
        ],
      ),
    );
  }
}

class RadiosSUPPLIERtypes extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  RadiosSUPPLIERtypes(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    var customerbloc = BlocProvider.of<SupplierssCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: customerbloc.type,
              onChanged: (val) {
                customerbloc.changetype(value: val!);
              }),
          Text(
            firstradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: customerbloc.type,
              onChanged: (val) {
                customerbloc.changetype(value: val!);
              }),
          Text(
            secondradiotitle,
            style: Styles.textStyle12,
          ),
        ],
      ),
    );
  }
}

class customerradios extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  customerradios(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    var customerbloc = BlocProvider.of<CustomersCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: customerbloc.paymenttype,
              onChanged: (val) {
                customerbloc.changepaymenttype(value: val!);
              }),
          Text(
            firstradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: customerbloc.paymenttype,
              onChanged: (val) {
                customerbloc.changepaymenttype(value: val!);
              }),
          Text(
            secondradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class customerradiospay extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  customerradiospay(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    var customerbloc = BlocProvider.of<CustomersCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: customerbloc.paymenttypesec,
              onChanged: (val) {
                customerbloc.changepaymenttypepay(value: val!);
              }),
          Text(
            firstradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: customerbloc.paymenttypesec,
              onChanged: (val) {
                customerbloc.changepaymenttypepay(value: val!);
              }),
          Text(
            secondradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

class supplierradios extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  supplierradios(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    var customerbloc = BlocProvider.of<SupplierssCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: customerbloc.paymenttype,
              onChanged: (val) {
                customerbloc.changepaymenttype(value: val!);
              }),
          Text(
            firstradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: secondradio,
              groupValue: customerbloc.paymenttype,
              onChanged: (val) {
                customerbloc.changepaymenttype(value: val!);
              }),
          Text(
            secondradiotitle,
            style: Styles.textStyle12,
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}
