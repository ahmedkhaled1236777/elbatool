import 'package:equatable/equatable.dart';

class Links extends Equatable {
  final String? first;
  final String? last;
  final dynamic previous;
  final String? next;

  const Links({this.first, this.last, this.previous, this.next});

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json['first'] as String?,
        last: json['last'] as String?,
        previous: json['previous'] as dynamic,
        next: json['next'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'first': first,
        'last': last,
        'previous': previous,
        'next': next,
      };

  @override
  List<Object?> get props => [first, last, previous, next];
}
