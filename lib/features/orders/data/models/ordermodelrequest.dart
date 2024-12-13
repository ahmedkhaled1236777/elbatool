import 'package:agman/core/common/errors/failure.dart';

class Ordermodelrequest {
  final String date;
  final String quantituy1;
  final String quantituy2;
  final String quantituy3;
  final int color;
  final String colorquantity;
  final int stampid;
  final int materialid;
  final String orderquantity;

  Ordermodelrequest({
    required this.date,
    required this.quantituy1,
    required this.quantituy2,
    required this.quantituy3,
    required this.color,
    required this.colorquantity,
    required this.stampid,
    required this.materialid,
    required this.orderquantity,
  });

  tojson() => {
        "date": date,
        "qt1": quantituy1,
        "qt2": quantituy2,
        "qt3": quantituy3,
        "color_id": color,
        "stamp_id": stampid,
        "qty_order": orderquantity,
        "material_id": materialid,
        "qty_masterpatch": colorquantity,
      };
}
