import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final num? weight;
  final num? periodTime;

  const Datum({this.id, this.name, this.weight, this.periodTime});

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        weight: json['weight'] as num?,
        periodTime: json['period_time'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'weight': weight,
        'period_time': periodTime,
      };

  @override
  List<Object?> get props => [id, name, weight, periodTime];
}
