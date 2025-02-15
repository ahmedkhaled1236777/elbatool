import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? total7aan;
  final int? totalStamba;

  const Datum({
    this.id,
    this.name,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.total7aan,
    this.totalStamba,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        phone: json['phone'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        total7aan: json['total_7aan'] as int?,
        totalStamba: json['total_stamba'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'total_7aan': total7aan,
        'total_stamba': totalStamba,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      phone,
      createdAt,
      updatedAt,
      total7aan,
      totalStamba,
    ];
  }
}
