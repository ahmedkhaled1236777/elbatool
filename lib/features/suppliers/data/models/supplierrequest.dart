class Supplierrequest {
  final String name;
  final String phone;
  final String place;
  int? id;
  Supplierrequest(
      {required this.name, required this.phone, this.id, required this.place});
  tojson() => {"name": name, "phone": phone, "industry": place};
}
