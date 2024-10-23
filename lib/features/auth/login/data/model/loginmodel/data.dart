import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final int? id;
  final String? image;
  final String? name;
  final String? factory;
  final String? email;
  final String? phone;
  final int? isAdmin;
  final List<String>? permissions;
  final String? token;

  const Data({
    this.id,
    this.image,
    this.name,
    this.factory,
    this.email,
    this.phone,
    this.isAdmin,
    this.permissions,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        image: json['image'] as String?,
        name: json['name'] as String?,
        factory: json['factory'] as String?,
        email: json['email'] as String?,
        phone: json['phone'] as String?,
        isAdmin: json['is_admin'] as int?,
        permissions: List<String>.from(json['permissions'] ?? []),
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'image': image,
        'name': name,
        'factory': factory,
        'email': email,
        'phone': phone,
        'is_admin': isAdmin,
        'permissions': permissions,
        'token': token,
      };

  @override
  List<Object?> get props {
    return [
      id,
      image,
      name,
      factory,
      email,
      phone,
      isAdmin,
      permissions,
      token,
    ];
  }
}
