import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final num? id;
  final String? name;
  final DateTime? employmentDate;
  final String? jobTitle;
  final String? salary;
  final String? hourlyRate;
  final String? workedHours;
  final String? phone;
  final num? numberOfShift;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final num? totalAbsence;
  final num? totalVacation;
  final num? totalAttendance;
  final num? totalPermissions;
  final num? totalExtraTime;
  final String? totalDebit;
  final String? totalCredit;
  final num? totalBonusHours;
  final num? totalPenaltyHours;
  final num? monthlyBonusDays;
  final num? onTimeDays;
  final bool? perfectAttendance;
  final bool? perfectPunctuality;
  final num? totalRegularHours;
  final num? adjustedHoursWithBonus;

  const Datum({
    this.id,
    this.name,
    this.employmentDate,
    this.jobTitle,
    this.salary,
    this.hourlyRate,
    this.workedHours,
    this.phone,
    this.numberOfShift,
    this.createdAt,
    this.updatedAt,
    this.totalAbsence,
    this.totalVacation,
    this.totalAttendance,
    this.totalPermissions,
    this.totalExtraTime,
    this.totalDebit,
    this.totalCredit,
    this.totalBonusHours,
    this.totalPenaltyHours,
    this.monthlyBonusDays,
    this.onTimeDays,
    this.perfectAttendance,
    this.perfectPunctuality,
    this.totalRegularHours,
    this.adjustedHoursWithBonus,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as num?,
        name: json['name'] as String?,
        employmentDate: json['employment_date'] == null
            ? null
            : DateTime.parse(json['employment_date'] as String),
        jobTitle: json['job_title'] as String?,
        salary: json['salary'] as String?,
        hourlyRate: json['hourly_rate'] as String?,
        workedHours: json['worked_hours'] as String?,
        phone: json['phone'] as String?,
        numberOfShift: json['number_of_shift'] as num?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        totalAbsence: json['total_absence'] as num?,
        totalVacation: json['total_vacation'] as num?,
        totalAttendance: json['total_attendance'] as num?,
        totalPermissions: json['total_permissions'] as num?,
        totalExtraTime: json['total_extra_time'] as num?,
        totalDebit: json['total_debit'] as String?,
        totalCredit: json['total_credit'] as String?,
        totalBonusHours: json['total_bonus_hours'] as num?,
        totalPenaltyHours: json['total_penalty_hours'] as num?,
        monthlyBonusDays: json['monthly_bonus_days'] as num?,
        onTimeDays: json['on_time_days'] as num?,
        perfectAttendance: json['perfect_attendance'] as bool?,
        perfectPunctuality: json['perfect_punctuality'] as bool?,
        totalRegularHours: json['total_regular_hours'] as num?,
        adjustedHoursWithBonus: json['adjusted_hours_with_bonus'] as num?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'employment_date': employmentDate?.toIso8601String(),
        'job_title': jobTitle,
        'salary': salary,
        'hourly_rate': hourlyRate,
        'worked_hours': workedHours,
        'phone': phone,
        'number_of_shift': numberOfShift,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'total_absence': totalAbsence,
        'total_vacation': totalVacation,
        'total_attendance': totalAttendance,
        'total_permissions': totalPermissions,
        'total_extra_time': totalExtraTime,
        'total_debit': totalDebit,
        'total_credit': totalCredit,
        'total_bonus_hours': totalBonusHours,
        'total_penalty_hours': totalPenaltyHours,
        'monthly_bonus_days': monthlyBonusDays,
        'on_time_days': onTimeDays,
        'perfect_attendance': perfectAttendance,
        'perfect_punctuality': perfectPunctuality,
        'total_regular_hours': totalRegularHours,
        'adjusted_hours_with_bonus': adjustedHoursWithBonus,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      employmentDate,
      jobTitle,
      salary,
      hourlyRate,
      workedHours,
      phone,
      numberOfShift,
      createdAt,
      updatedAt,
      totalAbsence,
      totalVacation,
      totalAttendance,
      totalPermissions,
      totalExtraTime,
      totalDebit,
      totalCredit,
      totalBonusHours,
      totalPenaltyHours,
      monthlyBonusDays,
      onTimeDays,
      perfectAttendance,
      perfectPunctuality,
      totalRegularHours,
      adjustedHoursWithBonus,
    ];
  }
}
