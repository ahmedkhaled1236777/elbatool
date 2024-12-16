class Walletmodelrequest {
  final String name;
  final String date;
  final String money;

  Walletmodelrequest(
      {required this.name, required this.date, required this.money});
  tojson() => {"name": name, "date": date, "money": money};
}
