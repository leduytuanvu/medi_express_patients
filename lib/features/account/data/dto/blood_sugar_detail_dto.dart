import 'package:medi_express_patients/features/account/domain/entities/blood_sugar_detail_entity.dart';

class BloodSugarDetailDto {
  final int id;
  final int patientId;
  final String bloodSugarAfterMeal;
  final String bloodSugarBeforeMeal;
  final String createdAt;
  final String updatedAt;

  BloodSugarDetailDto({
    required this.id,
    required this.patientId,
    required this.bloodSugarAfterMeal,
    required this.bloodSugarBeforeMeal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BloodSugarDetailDto.fromJson(Map<String, dynamic> json) {
    return BloodSugarDetailDto(
      id: json['id'] ?? '',
      patientId: json['PatientID'] ?? '',
      bloodSugarAfterMeal: json['BloodSugarAfterMeal'] ?? '',
      bloodSugarBeforeMeal: json['BloodSugarBeforeMeal'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId ?? '',
      'BloodSugarAfterMeal': bloodSugarAfterMeal.toString() ?? '',
      'BloodSugarBeforeMeal': bloodSugarBeforeMeal.toString() ?? '',
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  BloodSugarDetailEntity toEntity() {
    return BloodSugarDetailEntity(
      id: id,
      patientId: patientId ?? 0,
      bloodSugarAfterMeal: bloodSugarAfterMeal ?? '',
      bloodSugarBeforeMeal: bloodSugarBeforeMeal ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
