import 'package:equatable/equatable.dart';

class Content extends Equatable {
  final int? id;
  final String? name;
  final num? quantity;
  final String? rawMaterialStore;
  final dynamic type;

  const Content({
    this.id,
    this.name,
    this.quantity,
    this.rawMaterialStore,
    this.type,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        name: json['name'] as String?,
        quantity: json['quantity'] as num?,
        rawMaterialStore: json['raw_material_store'] as String?,
        type: json['type'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'quantity': quantity,
        'raw_material_store': rawMaterialStore,
        'type': type,
      };

  @override
  List<Object?> get props => [id, name, quantity, rawMaterialStore, type];
}
