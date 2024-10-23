class Moldmodelrequest {
  final String moldname;
  final String cycletime;
  final String prodweight;
  final int numberofpieces;

  Moldmodelrequest(
      {required this.moldname,
      required this.cycletime,
      required this.numberofpieces,
      required this.prodweight});
  tojson() => {
        "name": moldname,
        "period_time": cycletime,
        "weight": prodweight,
        "pieces_quantity": numberofpieces
      };
}
