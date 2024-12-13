class Deleteputmodelrequest {
  final String? stampname;
  final int quantity;
  final String notes;
  final String date;
  final String type;
  final int id;

  Deleteputmodelrequest(
      {required this.id,
      this.stampname,
      required this.quantity,
      required this.notes,
      required this.date,
      required this.type});
  tojson() => {
        "accessory_id": id,
        "qty": quantity,
        "date": date,
        "type": type,
        "notes": notes,
        "stamp_name": stampname
      };
}
