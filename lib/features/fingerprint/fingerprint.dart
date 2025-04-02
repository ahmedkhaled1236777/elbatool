import 'package:agman/core/common/toast/toast.dart';
import 'package:agman/core/common/widgets/errorwidget.dart';
import 'package:agman/features/fingerprint/fingerprint/fingerprint_cubit.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

class Fingerprint extends StatefulWidget {
  @override
  State<Fingerprint> createState() => _FingerprintState();
}

class _FingerprintState extends State<Fingerprint> {
  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
            child: BlocConsumer<FingerprintCubit, FingerprintState>(
              listener: (context, state) {
                if (state is Fingerprintfailure) {
                  showtoast(
                      message: state.errormessage,
                      toaststate: Toaststate.error,
                      context: context);
                }
                if (state is Fingerprintsuccess) {
                  showtoast(
                      message: "تم الاتصال بالجهاز",
                      toaststate: Toaststate.succes,
                      context: context);
                }
              },
              builder: (context, state) {
                if (state is Fingerprintloading) return loading();
                return ElevatedButton(
                    onPressed: () async {
                      await BlocProvider.of<FingerprintCubit>(context)
                          .getdata();
                    },
                    child: Text(
                      "الاتصال بالجهاز",
                      style: TextStyle(color: Colors.red),
                    ));
              },
            ),
          ),
          BlocBuilder<FingerprintCubit, FingerprintState>(
            builder: (context, state) {
              return Expanded(
                  child: state is Fingerprintsuccess
                      ? ListView.builder(
                          itemCount: state.employes.length,
                          itemBuilder: (context, i) => Text(state.employes[i]))
                      : SizedBox());
            },
          )
        ],
      ),
    );
  }
}
