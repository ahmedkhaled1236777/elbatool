import 'package:equatable/equatable.dart';

class AllCash extends Equatable {
  final int? id;
  final String? date;
  final int? status;
  final String? client;
  final String? price;
  final String? employer;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const AllCash({
    this.id,
    this.date,
    this.status,
    this.client,
    this.price,
    this.employer,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory AllCash.fromJson(Map<String, dynamic> json) => AllCash(
        id: json['id'] as int?,
        date: json['date'] as String?,
        status: json['status'] as int?,
        client: json['client'] as String?,
        price: json['price'] as String?,
        employer: json['employer'] as String?,
        notes: json['notes'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'status': status,
        'client': client,
        'price': price,
        'employer': employer,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      date,
      status,
      client,
      price,
      employer,
      notes,
      createdAt,
      updatedAt,
    ];
  }
}
