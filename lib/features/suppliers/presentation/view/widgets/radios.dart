import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/features/suppliers/presentation/viewmodel/suppliers/suppliers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadiosSUPPLIERtypes extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String thirdradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotitle;
  RadiosSUPPLIERtypes(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.thirdradio,
      required this.thirdradiotitle,
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
            thirdradiotitle,
            style: Styles.textStyle12,
          ),
        ],
      ),
    );
  }
}

class RadiosSUPPLIERtypesformaterial extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String thirdradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotitle;
  RadiosSUPPLIERtypesformaterial(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.thirdradio,
      required this.thirdradiotitle,
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
              groupValue: customerbloc.materialtype,
              onChanged: (val) {
                customerbloc.changesupplymaterialtype(value: val!);
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
              groupValue: customerbloc.materialtype,
              onChanged: (val) {
                customerbloc.changesupplymaterialtype(value: val!);
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
              value: thirdradio,
              groupValue: customerbloc.materialtype,
              onChanged: (val) {
                customerbloc.changesupplymaterialtype(value: val!);
              }),
          Text(
            thirdradiotitle,
            style: Styles.textStyle12,
          ),
        ],
      ),
    );
  }
}

class supplierradioadd extends StatelessWidget {
  final String firstradio;
  final String secondradio;
  final String thirdradio;
  final String fourthradio;
  final String firstradiotitle;
  final String secondradiotitle;
  final String thirdradiotittle;
  final String fourthradiotittle;
  supplierradioadd(
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
    var customerbloc = BlocProvider.of<SupplierssCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: customerbloc.supplypart,
              onChanged: (val) {
                customerbloc.changesupplytype(value: val!);
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
              groupValue: customerbloc.supplypart,
              onChanged: (val) {
                customerbloc.changesupplytype(value: val!);
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
              value: thirdradio,
              groupValue: customerbloc.supplypart,
              onChanged: (val) {
                customerbloc.changesupplytype(value: val!);
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
              value: fourthradio,
              groupValue: customerbloc.supplypart,
              onChanged: (val) {
                customerbloc.changesupplytype(value: val!);
              }),
          Text(fourthradiotittle,
              style: Styles.textStyle12.copyWith(color: Colors.green)),
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
