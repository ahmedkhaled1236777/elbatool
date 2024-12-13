import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? orderNum;
  final String? date;
  final int? stampId;
  final int? materialId;
  final String? qt1;
  final String? qt2;
  final String? qt3;
  final int? colorId;
  final String? qtyMasterpatch;
  final String? qtyOrder;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? stampName;
  final String? colorName;
  final int? qtyImplemented;
  final String? materialName;

  const Datum({
    this.id,
    this.orderNum,
    this.date,
    this.stampId,
    this.materialId,
    this.qt1,
    this.qt2,
    this.qt3,
    this.colorId,
    this.qtyMasterpatch,
    this.qtyOrder,
    this.createdAt,
    this.updatedAt,
    this.stampName,
    this.colorName,
    this.qtyImplemented,
    this.materialName,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        orderNum: json['order_num'] as String?,
        date: json['date'] as String?,
        stampId: json['stamp_id'] as int?,
        materialId: json['material_id'] as int?,
        qt1: json['qt1'] as String?,
        qt2: json['qt2'] as String?,
        qt3: json['qt3'] as String?,
        colorId: json['color_id'] as int?,
        qtyMasterpatch: json['qty_masterpatch'] as String?,
        qtyOrder: json['qty_order'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        stampName: json['stamp_name'] as String?,
        colorName: json['color_name'] as String?,
        qtyImplemented: json['qty_implemented'] as int?,
        materialName: json['material_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'order_num': orderNum,
        'date': date,
        'stamp_id': stampId,
        'material_id': materialId,
        'qt1': qt1,
        'qt2': qt2,
        'qt3': qt3,
        'color_id': colorId,
        'qty_masterpatch': qtyMasterpatch,
        'qty_order': qtyOrder,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'stamp_name': stampName,
        'color_name': colorName,
        'qty_implemented': qtyImplemented,
        'material_name': materialName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      orderNum,
      date,
      stampId,
      materialId,
      qt1,
      qt2,
      qt3,
      colorId,
      qtyMasterpatch,
      qtyOrder,
      createdAt,
      updatedAt,
      stampName,
      colorName,
      qtyImplemented,
      materialName,
    ];
  }
}
