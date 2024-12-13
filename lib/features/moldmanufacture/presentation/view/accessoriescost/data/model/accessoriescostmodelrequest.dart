class accessoriecostmodelrequest {
  final int accessorieid;
  final String notes;
  final String date;
  final int stampid;
  final int quantity;

  accessoriecostmodelrequest(
      {required this.accessorieid,
      required this.notes,
      required this.date,
      required this.stampid,
      required this.quantity});

  tojson() => {
        "accessory_id": accessorieid,
        "notes": notes,
        "date": date,
        "stamp_id": stampid,
        "quantity": quantity,
      };
}
