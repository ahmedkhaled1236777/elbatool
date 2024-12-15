import 'package:equatable/equatable.dart';

import 'datum.dart';

class Factorytoolsmoves extends Equatable {
  final bool? status;
  final String? message;
  final List<datummoves>? data;

  const Factorytoolsmoves({this.status, this.message, this.data});

  factory Factorytoolsmoves.fromJson(Map<String, dynamic> json) {
    return Factorytoolsmoves(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => datummoves.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'message': message,
        'data': data?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [status, message, data];
}
