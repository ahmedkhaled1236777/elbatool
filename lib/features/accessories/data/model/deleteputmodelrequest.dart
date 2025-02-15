class Deleteputmodelrequest {
  final String? stampname;
  final int quantity;
  final String notes;
  final String date;
  final String type;
  String? sellprice;
  String? buyprice;
  final int id;

  Deleteputmodelrequest(
      {required this.id,
      this.stampname,
      this.sellprice,
      this.buyprice,
      required this.quantity,
      required this.notes,
      required this.date,
      required this.type});
  tojson() => {
        "accessory_id": id,
        "qty": quantity,
        "date": date,
        "sell_price": sellprice,
        "buy_price": buyprice,
        "type": type,
        "notes": notes,
        "stamp_name": stampname
      };
}
