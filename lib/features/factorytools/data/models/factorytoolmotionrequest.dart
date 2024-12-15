class Factorytoolmotionrequest {
  final String date;
  final int quantity;
  final int id;
  final String status;
  final String notes;

  Factorytoolmotionrequest(
      {required this.date,
      required this.quantity,
      required this.id,
      required this.status,
      required this.notes});
  tojson() => {
        "date": date,
        "qty": quantity,
        "status": status,
        "notes": notes,
        "stock_id": id
      };
}
