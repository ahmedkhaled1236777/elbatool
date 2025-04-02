class Materialmodelrequest {
  final String name;
  final String qty1;
  final String qty2;
  final String qty3;
  final String type;

  Materialmodelrequest(
      {required this.name,
      required this.type,
      required this.qty1,
      required this.qty2,
      required this.qty3});
  tojson() => {
        "name": name,
        "type": type,
        "raw_material_store": type,
        "qty1": qty1,
        "qty2": qty2,
        "qty3": qty3
      };
}
