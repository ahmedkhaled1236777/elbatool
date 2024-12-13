class Accessoriemodelrequest {
  final String name;
  final int quantity;
  final double sellprice;
  final double buyprice;

  Accessoriemodelrequest(
      {required this.name,
      required this.quantity,
      required this.sellprice,
      required this.buyprice});
  tojson() => {
        "name": name,
        "qty": quantity,
        "buy_price": buyprice,
        "sell_price": sellprice
      };
}
