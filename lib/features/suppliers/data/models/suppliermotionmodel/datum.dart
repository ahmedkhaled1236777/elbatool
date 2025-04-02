import 'package:equatable/equatable.dart';

class Datummove extends Equatable {
  final int? id;
  final int? supplierId;
  final bool? status;
  final String? type;
  final int? objectId;
  final String? date;
  final String? notes;
  final int? qty;
  final int? price;
  final int? sellPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Datummove({
    this.id,
    this.supplierId,
    this.status,
    this.type,
    this.objectId,
    this.date,
    this.notes,
    this.qty,
    this.price,
    this.sellPrice,
    this.createdAt,
    this.updatedAt,
  });

  factory Datummove.fromJson(Map<String, dynamic> json) => Datummove(
        id: json['id'] as int?,
        supplierId: json['supplier_id'] as int?,
        status: json['status'] as bool?,
        type: json['type'] as String?,
        objectId: json['object_id'] as int?,
        date: json['date'] as String?,
        notes: json['notes'] as String?,
        qty: json['qty'] as int?,
        price: json['price'] as int?,
        sellPrice: json['sell_price'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'supplier_id': supplierId,
        'status': status,
        'type': type,
        'object_id': objectId,
        'date': date,
        'notes': notes,
        'qty': qty,
        'price': price,
        'sell_price': sellPrice,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      supplierId,
      status,
      type,
      objectId,
      date,
      notes,
      qty,
      price,
      sellPrice,
      createdAt,
      updatedAt,
    ];
  }
}
