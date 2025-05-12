import 'package:equatable/equatable.dart';

class datamoves extends Equatable {
  final String? employerName;
  final String? date;
  final String? timeIn;
  final String? timeOut;

  const datamoves({this.employerName, this.date, this.timeIn, this.timeOut});

  factory datamoves.fromJson(Map<String, dynamic> json) => datamoves(
        employerName: json['employer_name'] as String?,
        date: json['date'] as String?,
        timeIn: json['time_in'] as String?,
        timeOut: json['time_out'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'employer_name': employerName,
        'date': date,
        'time_in': timeIn,
        'time_out': timeOut,
      };

  @override
  List<Object?> get props => [employerName, date, timeIn, timeOut];
}
