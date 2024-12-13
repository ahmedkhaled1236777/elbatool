import 'dart:io';

import 'package:dio/dio.dart';

class Intialcostmodelrequest {
  final String cost;
  final String notes;
  dynamic image;
  final String date;
  final int stampid;
  final String type;

  Intialcostmodelrequest(
      {required this.cost,
      required this.notes,
      required this.date,
      required this.stampid,
      required this.type,
      this.image});
  FormData tojson() => FormData.fromMap({
        if (image != null) "image": image,
        "cost": cost,
        "notes": notes,
        "date": date,
        "stamp_id": stampid,
        "type": type,
      });
}
