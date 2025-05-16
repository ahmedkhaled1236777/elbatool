import 'package:equatable/equatable.dart';

import 'datum.dart';

class Holidaymodel extends Equatable {
  final bool? status;
  final String? message;
  final List<Datumholiday>? data;

  const Holidaymodel({this.status, this.message, this.data});

  factory Holidaymodel.fromJson(Map<String, dynamic> json) => Holidaymodel(
        status: json['status'] as bool?,
        message: json['message'] as String?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => Datumholiday.fromJson(e as Map<String, dynamic>))
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
