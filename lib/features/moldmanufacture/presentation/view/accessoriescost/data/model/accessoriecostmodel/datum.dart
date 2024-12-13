import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final int? stampId;
  final int? accessoryId;
  final String? buyPrice;
  final int? quantity;
  final String? notes;
  final String? date;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? accessoryName;
  final dynamic stampName;

  const Datum({
    this.id,
    this.stampId,
    this.accessoryId,
    this.buyPrice,
    this.quantity,
    this.notes,
    this.date,
    this.createdAt,
    this.updatedAt,
    this.accessoryName,
    this.stampName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        stampId: json['stamp_id'] as int?,
        accessoryId: json['accessory_id'] as int?,
        buyPrice: json['buy_price'] as String?,
        quantity: json['quantity'] as int?,
        notes: json['notes'] as String?,
        date: json['date'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        accessoryName: json['accessory_name'] as String?,
        stampName: json['stamp_name'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'stamp_id': stampId,
        'accessory_id': accessoryId,
        'buy_price': buyPrice,
        'quantity': quantity,
        'notes': notes,
        'date': date,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'accessory_name': accessoryName,
        'stamp_name': stampName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      stampId,
      accessoryId,
      buyPrice,
      quantity,
      notes,
      date,
      createdAt,
      updatedAt,
      accessoryName,
      stampName,
    ];
  }
}
