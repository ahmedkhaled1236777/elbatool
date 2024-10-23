import 'package:equatable/equatable.dart';

class Meta extends Equatable {
  final int? total;
  final int? currentPage;
  final int? lastPage;
  final int? perPage;

  const Meta({this.total, this.currentPage, this.lastPage, this.perPage});

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        total: json['total'] as int?,
        currentPage: json['currentPage'] as int?,
        lastPage: json['lastPage'] as int?,
        perPage: json['perPage'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'total': total,
        'currentPage': currentPage,
        'lastPage': lastPage,
        'perPage': perPage,
      };

  @override
  List<Object?> get props => [total, currentPage, lastPage, perPage];
}
