import 'package:equatable/equatable.dart';

import 'datum.dart';

class Permessionmodel extends Equatable {
  final bool? status;
  final String? message;
  final List<Datumpermession>? data;

  const Permessionmodel({this.status, this.message, this.data});

  factory Permessionmodel.fromJson(Map<String, dynamic> json) {
    return Permessionmodel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datumpermession.fromJson(e as Map<String, dynamic>))
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
