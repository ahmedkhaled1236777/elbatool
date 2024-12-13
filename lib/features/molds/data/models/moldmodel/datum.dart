import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? id;
  final String? name;
  final String? numerOfPieces;
  final double? timeOperation;
  final double? weightPiece;
  final dynamic image;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Datum({
    this.id,
    this.name,
    this.numerOfPieces,
    this.timeOperation,
    this.weightPiece,
    this.image,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        name: json['name'] as String?,
        numerOfPieces: json['numer_of_pieces'] as String?,
        timeOperation: (json['time_operation'] as num?)?.toDouble(),
        weightPiece: (json['weight_piece'] as num?)?.toDouble(),
        image: json['image'] as dynamic,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'numer_of_pieces': numerOfPieces,
        'time_operation': timeOperation,
        'weight_piece': weightPiece,
        'image': image,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      numerOfPieces,
      timeOperation,
      weightPiece,
      image,
      createdAt,
      updatedAt,
    ];
  }
}
