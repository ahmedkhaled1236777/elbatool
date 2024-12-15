import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final String? qty;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? buyQty;
  final int? dilapidatedQty;
  final int? salesQty;

  const Datum({
    this.id,
    this.name,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.buyQty,
    this.dilapidatedQty,
    this.salesQty,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        qty: json['qty'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        buyQty: json['buy_qty'] as int?,
        dilapidatedQty: json['dilapidated_qty'] as int?,
        salesQty: json['sales_qty'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'qty': qty,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'buy_qty': buyQty,
        'dilapidated_qty': dilapidatedQty,
        'sales_qty': salesQty,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      qty,
      createdAt,
      updatedAt,
      buyQty,
      dilapidatedQty,
      salesQty,
    ];
  }
}
