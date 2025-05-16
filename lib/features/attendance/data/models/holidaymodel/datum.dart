import 'package:equatable/equatable.dart';

class Datumholiday extends Equatable {
  final int? id;
  final int? employerId;
  final int? status;
  final String? date;
  final String? notes;
  final String? createdAt;
  final String? updatedAt;

  const Datumholiday({
    this.id,
    this.employerId,
    this.status,
    this.date,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory Datumholiday.fromJson(Map<String, dynamic> json) => Datumholiday(
        id: json['id'] as int?,
        employerId: json['employer_id'] as int?,
        status: json['status'] as int?,
        date: json['date'] as String?,
        notes: json['notes'] as String?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'employer_id': employerId,
        'status': status,
        'date': date,
        'notes': notes,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  List<Object?> get props {
    return [
      id,
      employerId,
      status,
      date,
      notes,
      createdAt,
      updatedAt,
    ];
  }
}
