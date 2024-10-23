import 'package:equatable/equatable.dart';

import 'user.dart';

class Content extends Equatable {
  final int? id;
  final User? user;
  final int? orderNumber;
  final String? orderDate;
  final int? quantity;
  final String? color;
  final int? machineNumber;
  final String? stamp;
  final String? rawMaterialStore;
  final int? pureQuantity;
  final int? breakCrusherQuantity;
  final int? brokenAwlQuantity;
  final int? isConfirmed;
  final String? createdAt;
  final String? updatedAt;

  const Content({
    this.id,
    this.user,
    this.orderNumber,
    this.orderDate,
    this.quantity,
    this.color,
    this.machineNumber,
    this.stamp,
    this.rawMaterialStore,
    this.pureQuantity,
    this.breakCrusherQuantity,
    this.brokenAwlQuantity,
    this.isConfirmed,
    this.createdAt,
    this.updatedAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json['id'] as int?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
        orderNumber: json['order_number'] as int?,
        orderDate: json['order_date'] as String?,
        quantity: json['quantity'] as int?,
        color: json['color'] as String?,
        machineNumber: json['machine_number'] as int?,
        stamp: json['stamp'] as String?,
        rawMaterialStore: json['raw_material_store'] as String?,
        pureQuantity: json['pure_quantity'] as int?,
        breakCrusherQuantity: json['break_crusher_quantity'] as int?,
        brokenAwlQuantity: json['broken_awl_quantity'] as int?,
        isConfirmed: json['is_confirmed'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user?.toJson(),
        'order_number': orderNumber,
        'order_date': orderDate,
        'quantity': quantity,
        'color': color,
        'machine_number': machineNumber,
        'stamp': stamp,
        'raw_material_store': rawMaterialStore,
        'pure_quantity': pureQuantity,
        'break_crusher_quantity': breakCrusherQuantity,
        'broken_awl_quantity': brokenAwlQuantity,
        'is_confirmed': isConfirmed,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  List<Object?> get props {
    return [
      id,
      user,
      orderNumber,
      orderDate,
      quantity,
      color,
      machineNumber,
      stamp,
      rawMaterialStore,
      pureQuantity,
      breakCrusherQuantity,
      brokenAwlQuantity,
      isConfirmed,
      createdAt,
      updatedAt,
    ];
  }
}
