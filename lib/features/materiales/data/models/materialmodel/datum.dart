import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? type;
  final String? name;
  final String? qty;
  final String? materialType;
  final String? masterpatchQty;

  const Datum({
    this.id,
    this.type,
    this.name,
    this.qty,
    this.materialType,
    this.masterpatchQty,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        type: json['type'] as String?,
        name: json['name'] as String?,
        qty: json['qty'] as String?,
        materialType: json['material_type'] as String?,
        masterpatchQty: json['masterpatch_qty'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'name': name,
        'qty': qty,
        'material_type': materialType,
        'masterpatch_qty': masterpatchQty,
      };

  @override
  List<Object?> get props {
    return [
      id,
      type,
      name,
      qty,
      materialType,
      masterpatchQty,
    ];
  }
}
