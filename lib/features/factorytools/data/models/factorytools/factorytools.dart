import 'package:equatable/equatable.dart';

import 'datum.dart';

class Factorytools extends Equatable {
  final String? message;
  final List<Datum>? data;

  const Factorytools({this.message, this.data});

  factory Factorytools.fromJson(Map<String, dynamic> json) => Factorytools(
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [message, data];
}
