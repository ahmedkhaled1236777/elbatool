class Clientrequest {
  final String name;
  final String phone;
  int? id;
  Clientrequest({required this.name, required this.phone, this.id});
  tojson() => {"name": name, "phone": phone};
}
