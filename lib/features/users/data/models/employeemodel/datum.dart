import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final dynamic image;
  final String? name;
  final String? jobTitle;
  final String? email;
  final String? phone;
  final int? isActive;
  final List<dynamic>? permissions;

  const Datum({
    this.id,
    this.image,
    this.name,
    this.jobTitle,
    this.email,
    this.phone,
    this.isActive,
    this.permissions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        image: json['image'] as dynamic,
        name: json['name'] as String?,
        jobTitle: json['job_title'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        isActive: json['is_active'] as int?,
        permissions: json['permissions'] ?? [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'job_title': jobTitle,
        'email': email,
        'phone': phone,
        'is_active': isActive,
        'permissions': permissions,
      };

  @override
  List<Object?> get props {
    return [
      id,
      image,
      name,
      jobTitle,
      email,
      phone,
      isActive,
      permissions,
    ];
  }
}
