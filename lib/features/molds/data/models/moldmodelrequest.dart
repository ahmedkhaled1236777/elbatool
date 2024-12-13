import 'package:dio/dio.dart';

class Moldmodelrequest {
  final String moldname;
  final String cycletime;
  final String prodweight;
  dynamic? image;
  final int numberofpieces;

  Moldmodelrequest(
      {required this.moldname,
      required this.cycletime,
      required this.numberofpieces,
      this.image,
      required this.prodweight});
  FormData tojson() => FormData.fromMap({
        if (image != null) "image": image,
        "name": moldname,
        "time_operation": cycletime,
        "weight_piece": prodweight,
        "numer_of_pieces": numberofpieces
      });
}
