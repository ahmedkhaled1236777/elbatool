import 'package:equatable/equatable.dart';

class Datummoves extends Equatable {
  final int? id;
  final int? userId;
  final int? orderId;
  final String? date;
  final String? name;
  final String? qty;
  final int? numberOfShift;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? userName;

  const Datummoves({
    this.id,
    this.userId,
    this.orderId,
    this.date,
    this.name,
    this.qty,
    this.numberOfShift,
    this.createdAt,
    this.updatedAt,
    this.userName,
  });

  factory Datummoves.fromJson(Map<String, dynamic> json) => Datummoves(
        id: json['id'] as int?,
        userId: json['user_id'] as int?,
        orderId: json['order_id'] as int?,
        date: json['date'] as String?,
        name: json['name'] as String?,
        qty: json['qty'] as String?,
        numberOfShift: json['number_of_shift'] as int?,
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
        'user_id': userId,
        'order_id': orderId,
        'date': date,
        'name': name,
        'qty': qty,
        'number_of_shift': numberOfShift,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user_name': userName,
      };

  @override
  List<Object?> get props {
    return [
      id,
      userId,
      orderId,
      date,
      name,
      qty,
      numberOfShift,
      createdAt,
      updatedAt,
      userName,
    ];
  }
}
