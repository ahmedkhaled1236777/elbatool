import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final int? qty;
  final String? buyPrice;
  final String? sellPrice;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic? dateFrom;
  final dynamic? dateTo;

  const Datum({
    this.id,
    this.name,
    this.qty,
    this.buyPrice,
    this.sellPrice,
    this.createdAt,
    this.updatedAt,
    this.dateFrom,
    this.dateTo,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        qty: json['qty'] as int?,
        buyPrice: json['buy_price'] as String?,
        sellPrice: json['sell_price'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        dateFrom: json['date_from'],
        dateTo: json['date_to'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'qty': qty,
        'buy_price': buyPrice,
        'sell_price': sellPrice,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'date_from': dateFrom,
        'date_to': dateTo,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      qty,
      buyPrice,
      sellPrice,
      createdAt,
      updatedAt,
      dateFrom,
      dateTo,
    ];
  }
}
