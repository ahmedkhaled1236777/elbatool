import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final String? clientName;
  final String? notes;
  final String? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final double? industrialCost;
  final int? initialCost;
  final double? accessoryInitial;

  const Datum({
    this.id,
    this.name,
    this.clientName,
    this.notes,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.industrialCost,
    this.initialCost,
    this.accessoryInitial,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        clientName: json['client_name'] as String?,
        notes: json['notes'] as String?,
        date: json['date'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        industrialCost: (json['industrial_cost'] as num?)?.toDouble(),
        initialCost: json['initial_cost'] as int?,
        accessoryInitial: (json['Accessory_Initial'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'client_name': clientName,
        'notes': notes,
        'date': date,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'industrial_cost': industrialCost,
        'initial_cost': initialCost,
        'Accessory_Initial': accessoryInitial,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      clientName,
      notes,
      date,
      createdAt,
      updatedAt,
      industrialCost,
      initialCost,
      accessoryInitial,
    ];
  }
}
