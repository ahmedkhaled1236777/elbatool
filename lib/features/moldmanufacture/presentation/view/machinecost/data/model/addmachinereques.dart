class Addmachinereques {
  final String name;
  final double priceperhour;
  final String notes;

  Addmachinereques(
      {required this.name, required this.priceperhour, required this.notes});
  tojson() => {"name": name, "price_per_hour": priceperhour, "notes": notes};
}
