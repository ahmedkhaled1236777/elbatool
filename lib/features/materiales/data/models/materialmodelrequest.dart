class Materialmodelrequest {
  final String name;
  final double quantity;
  final String type;

  Materialmodelrequest(
      {required this.name, required this.quantity, required this.type});
  tojson() => {"name": name, "quantity": quantity, "raw_material_store": type};
}
