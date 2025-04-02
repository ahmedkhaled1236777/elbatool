class Suppliermotionrequest {
  final String status;
  String? type;
  int? typeid;
  final String date;
  final String notes;
  double? quantity;
  final double price;
  double? sellprice;
  final int supplierid;
  String? materialtype;
  int? electronicsaveid;

  Suppliermotionrequest(
      {required this.status,
      required this.date,
      required this.notes,
      required this.supplierid,
      this.quantity,
      required this.price,
      this.materialtype,
      this.electronicsaveid,
      this.sellprice,
      required this.type,
      this.typeid});
  tojson() => {
        "status": status,
        "type": type,
        "object_id": typeid,
        "date": date,
        "notes": notes,
        "qty": quantity,
        "price": price,
        "sell_price": sellprice,
        "name": materialtype,
        "electronic_save_id": electronicsaveid,
        "supplier_id": supplierid,
        "client_name": "jj"
      };
}
