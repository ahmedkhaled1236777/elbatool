import 'package:equatable/equatable.dart';

import 'datum.dart';

class Machinesmodel extends Equatable {
  final bool? status;
  final String? message;
  final List<Datum>? data;

  const Machinesmodel({this.status, this.message, this.data});

  factory Machinesmodel.fromJson(Map<String, dynamic> json) => Machinesmodel(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
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
