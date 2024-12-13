import 'package:equatable/equatable.dart';

class DatumMOTION extends Equatable {
  final int? id;
  final int? type;
  final String? date;
  final int? userId;
  final int? accessoryId;
  final int? qty;
  final String? buyPrice;
  final String? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;
  final String? notes;
  final String? stamp_name;

  const DatumMOTION({
    this.id,
    this.type,
    this.date,
    this.userId,
    this.accessoryId,
    this.notes,
    this.stamp_name,
    this.qty,
    this.buyPrice,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.userName,
  });

  factory DatumMOTION.fromJson(Map<String, dynamic> json) => DatumMOTION(
        id: json['id'] as int?,
        type: json['type'] as int?,
        date: json['date'] as String?,
        userId: json['user_id'] as int?,
        accessoryId: json['accessory_id'] as int?,
        qty: json['qty'] as int?,
        buyPrice: json['buy_price'] as String?,
        notes: json['notes'] as String?,
        stamp_name: json['stamp_name'] as String?,
        totalPrice: json['total_price'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        userName: json['user_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'date': date,
        'user_id': userId,
        'accessory_id': accessoryId,
        'qty': qty,
        'buy_price': buyPrice,
        'total_price': totalPrice,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user_name': userName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      type,
      date,
      userId,
      accessoryId,
      qty,
      buyPrice,
      totalPrice,
      createdAt,
      updatedAt,
      userName,
    ];
  }
}
