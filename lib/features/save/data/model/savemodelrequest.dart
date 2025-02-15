class Savemodelrequest {
  final String date;
  final String status;
  final String money;
  final String notes;

  Savemodelrequest({
    required this.date,
    required this.status,
    required this.money,
    required this.notes,
  });
  tojson() => {
        "date": date,
        "status": status,
        "price": money,
        "client": "ي",
        "notes": notes,
      };
}
