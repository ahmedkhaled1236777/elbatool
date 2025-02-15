import 'package:equatable/equatable.dart';

import 'data.dart';
import 'summary.dart';

class Accessoriemotionmodel extends Equatable {
  final bool? success;
  final Data? data;
  final Summary? summary;

  const Accessoriemotionmodel({this.success, this.data, this.summary});

  factory Accessoriemotionmodel.fromJson(Map<String, dynamic> json) {
    return Accessoriemotionmodel(
      success: json['success'] as bool?,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      summary: json['summary'] == null
          ? null
          : Summary.fromJson(json['summary'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.toJson(),
        'summary': summary?.toJson(),
      };

  @override
  List<Object?> get props => [success, data, summary];
}
