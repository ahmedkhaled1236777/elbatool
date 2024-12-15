class Factorytoolmodelrequest {
  final String toolname;
  final String quantity;

  Factorytoolmodelrequest({required this.toolname, required this.quantity});
  tojson() => {"name": toolname, "qty": quantity};
}
