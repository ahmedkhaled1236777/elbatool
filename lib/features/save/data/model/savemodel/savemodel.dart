import 'package:equatable/equatable.dart';

import 'data.dart';

class Savemodel extends Equatable {
  final bool? success;
  final Data? data;

  const Savemodel({this.success, this.data});

  factory Savemodel.fromJson(Map<String, dynamic> json) => Savemodel(
        success: json['success'] as bool?,
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
      };

  @override
  List<Object?> get props => [success, data];
}
