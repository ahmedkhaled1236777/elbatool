class Holidaymodelrequest {
  final String date;
  final int employid;
  final String notes;
  final int status;

  Holidaymodelrequest(
      {required this.date,
      required this.employid,
      required this.notes,
      required this.status});
  tojson() =>
      {"date": date, "employer_id": employid, "notes": notes, "status": status};
}
