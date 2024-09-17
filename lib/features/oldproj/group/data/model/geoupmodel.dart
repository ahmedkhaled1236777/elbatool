import 'package:cloud_firestore/cloud_firestore.dart';

class groupmodel {
  final String groupnumber;
  final String groupstatrtdate;
  int id;
  groupmodel(
      {required this.groupnumber, required this.groupstatrtdate, this.id = 1});
  tojson({required int id}) => {
        "groupnumber": groupnumber,
        "groupstatrtdate": groupstatrtdate,
        "id": id,
      };
  factory groupmodel.fromjson(var data) {
    return groupmodel(
        id: data["id"],
        groupnumber: data["groupnumber"],
        groupstatrtdate: data["groupstatrtdate"]);
  }
}
