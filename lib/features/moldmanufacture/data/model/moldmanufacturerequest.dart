class Moldmanufacturerequest {
  final String date;
  final String clientname;
  final String moldname;
  final String notes;

  Moldmanufacturerequest(
      {required this.date,
      required this.clientname,
      required this.moldname,
      required this.notes});
  tojson() => {
        "date": date,
        "client_name": clientname,
        "name": moldname,
        "notes": notes
      };
}
