class productionmodel {
  final String date;
  final String workername;
  final int machinenumber;
  final num prodname;
  final num cycletime;
  final int numberofpieces;
  final num workhours;
  final num counterstart;
  final num counterend;
  final int realprodcountity;
  final num expectedprod;
  final num scrapcountity;
  final num proddivision;
  final num machinestop;
  final String notes;
  final num shift;
  final int ordernuber;
  final String? color;
  String? stampname;
  String? ordernumber;
  int? id;
  productionmodel(
      {required this.date,
      this.stampname,
      this.ordernumber,
      this.id,
      required this.ordernuber,
      required this.workername,
      required this.color,
      required this.machinenumber,
      required this.shift,
      required this.prodname,
      required this.cycletime,
      required this.numberofpieces,
      required this.workhours,
      required this.counterstart,
      required this.counterend,
      required this.realprodcountity,
      required this.expectedprod,
      required this.scrapcountity,
      required this.proddivision,
      required this.machinestop,
      required this.notes});

  tojson() => {
        "date": date,
        "number_of_shift": shift,
        "worker": workername,
        "number_of_machine": machinenumber,
        "stamp_id": prodname,
        "period_time": cycletime,
        "number_of_pieces": numberofpieces,
        "number_of_operating_hours": workhours,
        "time_start": counterstart,
        "time_end": counterend,
        "qty_actual": realprodcountity,
        "qty_expected": expectedprod,
        "qty_missing": proddivision,
        "qty_dilapidated": scrapcountity,
        "time_stop_machine": machinestop,
        "notes": notes,
        "order_id": ordernuber,
        "color": color,
      };
  factory productionmodel.fromjson(var data, {String? dta, String? color}) {
    return productionmodel(
        date: data["date"],
        workername: data["worker"],
        shift: data["number_of_shift"],
        ordernuber: data["order_id"],
        color: data["color"],
        ordernumber: data["order_num"],
        stampname: data["stamp_name"],
        machinenumber: data["number_of_machine"],
        prodname: data["stamp_id"],
        cycletime: data["period_time"],
        numberofpieces: data["number_of_pieces"],
        workhours: data["number_of_operating_hours"],
        counterstart: data["time_start"],
        counterend: data["time_end"],
        realprodcountity: data["qty_actual"],
        expectedprod: data["qty_expected"],
        scrapcountity: data["qty_dilapidated"],
        proddivision: data["qty_missing"],
        id: data["id"],
        machinestop: data["time_stop_machine"],
        notes: data["notes"]);
  }
}
