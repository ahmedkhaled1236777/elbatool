import 'package:equatable/equatable.dart';

class Datumsearch extends Equatable {
  final int? id;
  final String? name;
  final String? qty;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? dateFrom;
  final String? dateTo;
  final int? buyQty;
  final int? dilapidatedQty;
  final int? salesQty;
  final String? date;

  const Datumsearch({
    this.id,
    this.name,
    this.qty,
    this.createdAt,
    this.updatedAt,
    this.dateFrom,
    this.dateTo,
    this.buyQty,
    this.dilapidatedQty,
    this.salesQty,
    this.date,
  });

  factory Datumsearch.fromJson(Map<String, dynamic> json) => Datumsearch(
        id: json['id'] as int?,
        name: json['name'] as String?,
        qty: json['qty'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        dateFrom: json['date_from'] as String?,
        dateTo: json['date_to'] as String?,
        buyQty: json['buy_qty'] as int?,
        dilapidatedQty: json['dilapidated_qty'] as int?,
        salesQty: json['sales_qty'] as int?,
        date: json['date'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'qty': qty,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'date_from': dateFrom,
        'date_to': dateTo,
        'buy_qty': buyQty,
        'dilapidated_qty': dilapidatedQty,
        'sales_qty': salesQty,
        'date': date,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      qty,
      createdAt,
      updatedAt,
      dateFrom,
      dateTo,
      buyQty,
      dilapidatedQty,
      salesQty,
      date,
    ];
  }
}
