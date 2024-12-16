import 'package:agman/core/colors/colors.dart';
import 'package:agman/core/common/styles/styles.dart';
import 'package:agman/features/wallets/presentation/viewmodel/wallet/wallet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class radioswalletsmotions extends StatelessWidget {
  final int firstradio;
  final int secondradio;
  final String firstradiotitle;
  final String secondradiotitle;
  radioswalletsmotions(
      {super.key,
      required this.firstradio,
      required this.secondradio,
      required this.firstradiotitle,
      required this.secondradiotitle});
  @override
  Widget build(BuildContext context) {
    var customerbloc = BlocProvider.of<WalletCubit>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Radio(
              activeColor: appcolors.seconderycolor,
              value: firstradio,
              groupValue: customerbloc.wallettype,
              onChanged: (val) {
                customerbloc.changewallettype(val!);
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
              groupValue: customerbloc.wallettype,
              onChanged: (val) {
                customerbloc.changewallettype(val!);
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
