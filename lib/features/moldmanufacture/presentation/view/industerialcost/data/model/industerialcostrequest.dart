class Industerialcostrequest {
  final String numberofhours;
  final String notes;
  final String date;
  final int stampid;
  final int machineid;

  Industerialcostrequest({
    required this.numberofhours,
    required this.notes,
    required this.date,
    required this.stampid,
    required this.machineid,
  });
  tojson() => {
        "number_hours": numberofhours,
        "notes": notes,
        "date": date,
        "stamp_id": stampid,
        "machine_id": machineid,
      };
}
