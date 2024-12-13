import 'package:equatable/equatable.dart';

import 'datum.dart';

class Ordermoves extends Equatable {
  final bool? status;
  final String? message;
  final List<Datummoves>? data;

  const Ordermoves({this.status, this.message, this.data});

  factory Ordermoves.fromJson(Map<String, dynamic> json) => Ordermoves(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datummoves.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [status, message, data];
}
