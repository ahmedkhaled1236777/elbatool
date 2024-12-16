class Walletmotionmodelrequest {
  final String date;
  final int status;
  final String money;
  final String notes;
  final int walletid;

  Walletmotionmodelrequest(
      {required this.date,
      required this.status,
      required this.money,
      required this.notes,
      required this.walletid});
  tojson() => {
        "date": date,
        "status": status,
        "money": money,
        "notes": notes,
        "store_id": walletid
      };
}
