import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/features/clients/presentation/viewmodel/customers/customers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class monytypesradios extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  monytypesradios(
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
              groupValue: customerbloc.moneytype,
              onChanged: (val) {
                customerbloc.changemonetytype(value: val!);
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
              groupValue: customerbloc.moneytype,
              onChanged: (val) {
                customerbloc.changemonetytype(value: val!);
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
  final String sixradio;
  final String sixradiotittle;
  final String fifthradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotittle;
  final String fourthradiotittle;
  final String fifthradiotitle;
  radiostypes(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.fifthradio,
      required this.thirdradio,
      required this.sixradio,
      required this.sixradiotittle,
      required this.fourthradio,
      required this.thirdradiotittle,
      required this.fourthradiotittle,
      required this.fifthradiotitle,
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
              value: fifthradio,
              groupValue: customerbloc.type,
              onChanged: (val) {
                customerbloc.changetype(value: val!);
              }),
          Text(
            fifthradiotitle,
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
          SizedBox(
            width: 10,
          ),
          Radio(
              activeColor: appcolors.seconderycolor,
              value: sixradio,
              groupValue: customerbloc.type,
              onChanged: (val) {
                customerbloc.changetype(value: val!);
              }),
          Text(
            sixradiotittle,
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
