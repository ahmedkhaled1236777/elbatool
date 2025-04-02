import 'package:equatable/equatable.dart';

import 'moves.dart';

class Suppliermotionmodel extends Equatable {
  final bool? status;
  final Moves? moves;
  final dynamic? totalCredit;
  final dynamic? totalDue;

  const Suppliermotionmodel({
    this.status,
    this.moves,
    this.totalCredit,
    this.totalDue,
  });

  factory Suppliermotionmodel.fromJson(Map<String, dynamic> json) {
    return Suppliermotionmodel(
      status: json['status'] as bool?,
      moves: json['moves'] == null
          ? null
          : Moves.fromJson(json['moves'] as Map<String, dynamic>),
      totalCredit: json["total_supply"],
      totalDue: json["total_pay"],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'moves': moves?.toJson(),
        'total_credit': totalCredit,
        'total_due': totalDue,
      };

  @override
  List<Object?> get props => [status, moves, totalCredit, totalDue];
}
