import 'package:agman/core/common/errors/failure.dart';

class Ordermodelrequest {
  final String date;
  final String quantituy;
  final String color;
  final String colorquantity;
  final String stampid;
  final String materialid;
  final String purequantity;
  final String break_crusher_quantity;
  final String broken_awl_quantity;

  Ordermodelrequest(
      {required this.date,
      required this.quantituy,
      required this.color,
      required this.colorquantity,
      required this.stampid,
      required this.materialid,
      required this.purequantity,
      required this.break_crusher_quantity,
      required this.broken_awl_quantity});

  tojson() => {
        "order_date": date,
        "machine_number": colorquantity,
        "quantity": quantituy,
        "color": color,
        "stamp_id": stampid,
        "raw_material_store_id": materialid,
        "pure_quantity": purequantity,
        "break_crusher_quantity": break_crusher_quantity,
        "broken_awl_quantity": broken_awl_quantity
      };
}
