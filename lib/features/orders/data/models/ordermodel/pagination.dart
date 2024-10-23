import 'package:equatable/equatable.dart';

import 'links.dart';
import 'meta.dart';

class Pagination extends Equatable {
  final Meta? meta;
  final Links? links;

  const Pagination({this.meta, this.links});

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        meta: json['meta'] == null
            ? null
            : Meta.fromJson(json['meta'] as Map<String, dynamic>),
        links: json['links'] == null
            ? null
            : Links.fromJson(json['links'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'meta': meta?.toJson(),
        'links': links?.toJson(),
      };

  @override
  List<Object?> get props => [meta, links];
}
