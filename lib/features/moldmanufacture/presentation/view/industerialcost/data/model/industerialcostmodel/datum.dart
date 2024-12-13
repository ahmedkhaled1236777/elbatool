import 'package:equatable/equatable.dart';

import 'machine.dart';
import 'stamp.dart';

class Datum extends Equatable {
  final int? id;
  final int? stampId;
  final int? machineId;
  final double? numberHours;
  final String? totalPrice;
  final String? date;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? stampName;
  final String? machineName;
  final Stamp? stamp;
  final Machine? machine;

  const Datum({
    this.id,
    this.stampId,
    this.machineId,
    this.numberHours,
    this.totalPrice,
    this.date,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.stampName,
    this.machineName,
    this.stamp,
    this.machine,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        stampId: json['stamp_id'] as int?,
        machineId: json['machine_id'] as int?,
        numberHours: (json['number_hours'] as num?)?.toDouble(),
        totalPrice: json['total_price'] as String?,
        date: json['date'] as String?,
        notes: json['notes'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        stampName: json['stamp_name'] as String?,
        machineName: json['machine_name'] as String?,
        stamp: json['stamp'] == null
            ? null
            : Stamp.fromJson(json['stamp'] as Map<String, dynamic>),
        machine: json['machine'] == null
            ? null
            : Machine.fromJson(json['machine'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'stamp_id': stampId,
        'machine_id': machineId,
        'number_hours': numberHours,
        'total_price': totalPrice,
        'date': date,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'stamp_name': stampName,
        'machine_name': machineName,
        'stamp': stamp?.toJson(),
        'machine': machine?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      stampId,
      machineId,
      numberHours,
      totalPrice,
      date,
      notes,
      createdAt,
      updatedAt,
      stampName,
      machineName,
      stamp,
      machine,
    ];
  }
}
