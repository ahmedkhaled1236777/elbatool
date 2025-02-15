class Materialmovemodelrequest {
  final String date;
  final String materialid;
  final String qty;
  final String status;
  final String type;
  final String notes;

  Materialmovemodelrequest(
      {required this.date,
      required this.materialid,
      required this.qty,
      required this.status,
      required this.type,
      required this.notes});
  tojson() => {
        "date": date,
        "material_id": materialid,
        "qty": qty,
        "type": status,
        "notes": notes,
        "name": type
      };
}
