class clientmoverequest {
  final String date;
  final String type;
  final String notes;
  final int clientid;
  String? qty;
  String? pieceprice;
  String? moneytype;
  int? saveid;

  clientmoverequest(
      {required this.date,
      required this.type,
      required this.notes,
      this.moneytype,
      this.pieceprice,
      this.qty,
      this.saveid,
      required this.clientid});
  tojson() => {
        "date": date,
        "type": type,
        "notes": notes,
        if (qty != null) "qty": qty,
        if (pieceprice != null) "price_unit": pieceprice,
        if (moneytype != null) "status": moneytype,
        "client_id": clientid,
        if (saveid != null) "electronic_save_id": saveid
      };
}
