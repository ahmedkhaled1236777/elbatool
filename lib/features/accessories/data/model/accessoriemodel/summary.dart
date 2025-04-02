import 'package:equatable/equatable.dart';

class Summary extends Equatable {
  final int? saleQuantity;
  final int? addedQuantity;
  final int? consumedQuantity;

  const Summary({
    this.saleQuantity,
    this.addedQuantity,
    this.consumedQuantity,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        saleQuantity: json['sale_quantity'] as int?,
        addedQuantity: json['added_quantity'] as int?,
        consumedQuantity: json['consumed_quantity'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'sale_quantity': saleQuantity,
        'added_quantity': addedQuantity,
        'consumed_quantity': consumedQuantity,
      };

  @override
  List<Object?> get props {
    return [
      saleQuantity,
      addedQuantity,
      consumedQuantity,
    ];
  }
}
