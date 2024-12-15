import 'package:equatable/equatable.dart';

class datummoves extends Equatable {
  final int? id;
  final int? stockId;
  final String? date;
  final String? qty;
  final int? status;
  final String? notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? stockName;

  const datummoves({
    this.id,
    this.stockId,
    this.date,
    this.qty,
    this.status,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.stockName,
  });

  factory datummoves.fromJson(Map<String, dynamic> json) => datummoves(
        id: json['id'] as int?,
        stockId: json['stock_id'] as int?,
        date: json['date'] as String?,
        qty: json['qty'] as String?,
        status: json['status'] as int?,
        notes: json['notes'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        stockName: json['stock_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'stock_id': stockId,
        'date': date,
        'qty': qty,
        'status': status,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'stock_name': stockName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      stockId,
      date,
      qty,
      status,
      notes,
      createdAt,
      updatedAt,
      stockName,
    ];
  }
}
