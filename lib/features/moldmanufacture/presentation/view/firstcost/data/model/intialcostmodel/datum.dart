import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? type;
  final int? stampId;
  final String? cost;
  final String? notes;
  final String? image;
  final String? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Datum({
    this.id,
    this.type,
    this.stampId,
    this.cost,
    this.notes,
    this.image,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        type: json['type'] as String?,
        stampId: json['stamp_id'] as int?,
        cost: json['cost'] as String?,
        notes: json['notes'] as String?,
        image: json['image'] as String?,
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
        'type': type,
        'stamp_id': stampId,
        'cost': cost,
        'notes': notes,
        'image': image,
        'date': date,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      type,
      stampId,
      cost,
      notes,
      image,
      date,
      createdAt,
      updatedAt,
    ];
  }
}
