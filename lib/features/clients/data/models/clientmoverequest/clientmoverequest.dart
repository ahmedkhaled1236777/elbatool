class Clientmoverequest {
  final String date;
  final String type;
  final String notes;
  final String qty;
  final String price_unit;
  final String status;
  final int client_id;
  int? electronic_save_id;

  Clientmoverequest(
      {required this.date,
      required this.type,
      required this.notes,
      required this.qty,
      required this.price_unit,
      required this.status,
      required this.client_id,
      this.electronic_save_id});
  tojson() => {
        "date": date,
        "type": type,
        "notes": notes,
        "qty": qty,
        "price_unit": price_unit,
        "status": status,
        "client_id": client_id,
        "electronic_save_id": electronic_save_id
      };
}
