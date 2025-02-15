import 'package:equatable/equatable.dart';

import 'all_cash.dart';

class Data extends Equatable {
  final double? sumDay;
  final double? currentCash;
  final List<AllCash>? allCash;

  const Data({this.sumDay, this.currentCash, this.allCash});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        sumDay: (json['sum_day'] as num?)?.toDouble(),
        currentCash: (json['current_cash'] as num?)?.toDouble(),
        allCash: (json['all_cash'] as List<dynamic>?)
            ?.map((e) => AllCash.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'sum_day': sumDay,
        'current_cash': currentCash,
        'all_cash': allCash?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props => [sumDay, currentCash, allCash];
}
