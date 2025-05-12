import 'package:equatable/equatable.dart';

class Datummove extends Equatable {
  final int? id;
  final String? date;
  final String? type;
  final String? notes;
  final String? qty;
  final String? priceUnit;
  final String? status;
  final int? clientId;
  final int? electronicSaveId;
  final String? productName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? total7aan;
  final int? totalStamba;

  const Datummove({
    this.id,
    this.date,
    this.type,
    this.notes,
    this.qty,
    this.priceUnit,
    this.status,
    this.clientId,
    this.electronicSaveId,
    this.productName,
    this.createdAt,
    this.updatedAt,
    this.total7aan,
    this.totalStamba,
  });

  factory Datummove.fromJson(Map<String, dynamic> json) => Datummove(
        id: json['id'] as int?,
        date: json['date'] as String?,
        type: json['type'] as String?,
        notes: json['notes'] as String?,
        qty: json['qty'] as String?,
        priceUnit: json['price_unit'] as String?,
        status: json['status'] as String?,
        clientId: json['client_id'] as int?,
        electronicSaveId: json['electronic_save_id'] as int?,
        productName: json['product_name'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        total7aan: json['total_7aan'] as int?,
        totalStamba: json['total_stamba'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
        'type': type,
        'notes': notes,
        'qty': qty,
        'price_unit': priceUnit,
        'status': status,
        'client_id': clientId,
        'electronic_save_id': electronicSaveId,
        'product_name': productName,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'total_7aan': total7aan,
        'total_stamba': totalStamba,
      };

  @override
  List<Object?> get props {
    return [
      id,
      date,
      type,
      notes,
      qty,
      priceUnit,
      status,
      clientId,
      electronicSaveId,
      productName,
      createdAt,
      updatedAt,
      total7aan,
      totalStamba,
    ];
  }
}
