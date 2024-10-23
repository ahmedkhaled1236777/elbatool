import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? name;

  const User({this.id, this.name});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };

  @override
  List<Object?> get props => [id, name];
}
