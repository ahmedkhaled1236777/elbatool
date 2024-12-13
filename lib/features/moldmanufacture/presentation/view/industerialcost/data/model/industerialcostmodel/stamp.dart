import 'package:equatable/equatable.dart';

class Stamp extends Equatable {
  final int? id;
  final String? name;
  final String? clientName;
  final String? notes;
  final String? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Stamp({
    this.id,
    this.name,
    this.clientName,
    this.notes,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory Stamp.fromJson(Map<String, dynamic> json) => Stamp(
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
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'client_name': clientName,
        'notes': notes,
        'date': date,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
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
    ];
  }
}
