import 'package:equatable/equatable.dart';

import 'content.dart';
import 'pagination.dart';

class Data extends Equatable {
  final List<Content>? content;
  final Pagination? pagination;

  const Data({this.content, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        content: (json['content'] as List<dynamic>?)
            ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
            .toList(),
        pagination: json['pagination'] == null
            ? null
            : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'content': content?.map((e) => e.toJson()).toList(),
        'pagination': pagination?.toJson(),
      };

  @override
  List<Object?> get props => [content, pagination];
}
