import 'package:equatable/equatable.dart';

class datummoves extends Equatable {
  final int? id;
  final String? orderNum;
  final dynamic currentQty;
  final int? userId;
  final String? name;
  final String? date;
  final int? materialId;
  final String? qty;
  final String? type;
  final dynamic clientName;
  final dynamic notes;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;

  const datummoves({
    this.id,
    this.orderNum,
    this.currentQty,
    this.userId,
    this.name,
    this.date,
    this.materialId,
    this.qty,
    this.type,
    this.clientName,
    this.notes,
    this.createdAt,
    this.updatedAt,
    this.userName,
  });

  factory datummoves.fromJson(Map<String, dynamic> json) => datummoves(
        id: json['id'] as int?,
        orderNum: json['order_num'] as String?,
        currentQty: json['current_qty'] as dynamic,
        userId: json['user_id'] as int?,
        name: json['name'] as String?,
        date: json['date'] as String?,
        materialId: json['material_id'] as int?,
        qty: json['qty'] as String?,
        type: json['type'] as String?,
        clientName: json['client_name'] as dynamic,
        notes: json['notes'] as dynamic,
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
        'order_num': orderNum,
        'current_qty': currentQty,
        'user_id': userId,
        'name': name,
        'date': date,
        'material_id': materialId,
        'qty': qty,
        'type': type,
        'client_name': clientName,
        'notes': notes,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user_name': userName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      orderNum,
      currentQty,
      userId,
      name,
      date,
      materialId,
      qty,
      type,
      clientName,
      notes,
      createdAt,
      updatedAt,
      userName,
    ];
  }
}
