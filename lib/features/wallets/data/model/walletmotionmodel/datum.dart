import 'package:equatable/equatable.dart';

class Datumwalletmotion extends Equatable {
  final int? id;
  final int? storeId;
  final String? date;
  final int? status;
  final String? clientName;
  final String? employerName;
  final String? money;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? storeName;

  const Datumwalletmotion({
    this.id,
    this.storeId,
    this.date,
    this.status,
    this.clientName,
    this.employerName,
    this.money,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.storeName,
  });

  factory Datumwalletmotion.fromJson(Map<String, dynamic> json) =>
      Datumwalletmotion(
        id: json['id'] as int?,
        storeId: json['store_id'] as int?,
        date: json['date'] as String?,
        status: json['status'] as int?,
        clientName: json['client_name'] as String?,
        employerName: json['employer_name'] as String?,
        money: json['money'] as String?,
        notes: json['notes'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        storeName: json['store_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'store_id': storeId,
        'date': date,
        'status': status,
        'client_name': clientName,
        'employer_name': employerName,
        'money': money,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'store_name': storeName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      storeId,
      date,
      status,
      clientName,
      employerName,
      money,
      notes,
      createdAt,
      updatedAt,
      storeName,
    ];
  }
}
