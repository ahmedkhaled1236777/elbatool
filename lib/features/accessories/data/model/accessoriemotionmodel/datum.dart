import 'package:equatable/equatable.dart';

class DatumMOTION extends Equatable {
  final int? id;
  final String? currentQty;
  final int? type;
  final String? stampName;
  final String? date;
  final String? notes;
  final int? userId;
  final int? accessoryId;
  final int? qty;
  final String? buyPrice;
  final String? sellPrice;
  final String? totalPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;

  const DatumMOTION({
    this.id,
    this.currentQty,
    this.type,
    this.stampName,
    this.date,
    this.notes,
    this.userId,
    this.accessoryId,
    this.qty,
    this.buyPrice,
    this.sellPrice,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.userName,
  });

  factory DatumMOTION.fromJson(Map<String, dynamic> json) => DatumMOTION(
        id: json['id'] as int?,
        currentQty: json['current_qty'] as String?,
        type: json['type'] as int?,
        stampName: json['stamp_name'] as String?,
        date: json['date'] as String?,
        notes: json['notes'] as String?,
        userId: json['user_id'] as int?,
        accessoryId: json['accessory_id'] as int?,
        qty: json['qty'] as int?,
        buyPrice: json['buy_price'] as String?,
        sellPrice: json['sell_price'] as String?,
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
        'current_qty': currentQty,
        'type': type,
        'stamp_name': stampName,
        'date': date,
        'notes': notes,
        'user_id': userId,
        'accessory_id': accessoryId,
        'qty': qty,
        'buy_price': buyPrice,
        'sell_price': sellPrice,
        'total_price': totalPrice,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user_name': userName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      currentQty,
      type,
      stampName,
      date,
      notes,
      userId,
      accessoryId,
      qty,
      buyPrice,
      sellPrice,
      totalPrice,
      createdAt,
      updatedAt,
      userName,
    ];
  }
}
