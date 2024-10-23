import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class cvs extends StatefulWidget {
  @override
  State<cvs> createState() => _cvsState();
}

class _cvsState extends State<cvs> {
  void pickfile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result != null) {
      var filepath = result.files.first.path!;
      final input = File(filepath).openRead();
      var fiels = await input
          .transform(Utf8Decoder())
          .transform(const CsvToListConverter())
          .toList();
      List v = [];

      for (int i = 0; i < fiels[0].length; i++) {
        if (i % 17 == 0 && i != 0) {
          data.add(v);
          print("lllllllllllllllllllllllllllllllll");
          v = [];
        }
      }

      data = fiels;

      setState(() {});
    }
  }

  List<List<dynamic>> data = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: () {
                  pickfile();
                },
                child: Text("add")),
            if (data.isNotEmpty)
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, i) => Card(
                          color: i == 0 ? Colors.amber : Colors.white,
                          margin: const EdgeInsets.all(3),
                          child: ListTile(
                            leading: Text(
                              data[i][21].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: i == 0 ? 18 : 15,
                                  fontWeight: i == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: i == 0 ? Colors.blue : Colors.black),
                            ),
                            title: Text(
                              data[i][1],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: i == 0 ? 18 : 15,
                                  fontWeight: i == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: i == 0 ? Colors.red : Colors.black),
                            ),
                            trailing: Text(
                              data[i][2].toString(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: i == 0 ? 18 : 15,
                                  fontWeight: i == 0
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: i == 0 ? Colors.red : Colors.black),
                            ),
                          ),
                        ),
                    separatorBuilder: (context, i) => Divider(),
                    itemCount: data.length),
              ),
          ],
        ),
      ),
    );
  }
}
