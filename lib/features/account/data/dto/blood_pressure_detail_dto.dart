import 'package:medi_express_patients/features/account/domain/entities/blood_pressure_detail_entity.dart';

class BloodPressureDetailDto {
  final int id;
  final int patientId;
  final String dystolicBloodPressure;
  final String systolicBloodPressure;
  final String createdAt;
  final String updatedAt;

  BloodPressureDetailDto({
    required this.id,
    required this.patientId,
    required this.dystolicBloodPressure,
    required this.systolicBloodPressure,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BloodPressureDetailDto.fromJson(Map<String, dynamic> json) {
    return BloodPressureDetailDto(
      id: json['id'] ?? '',
      patientId: json['PatientID'] ?? '',
      dystolicBloodPressure: json['DystolicBloodPressure'] ?? '',
      systolicBloodPressure: json['SystolicBloodPressure'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId ?? '',
      'DystolicBloodPressure': dystolicBloodPressure.toString() ?? '',
      'SystolicBloodPressure': systolicBloodPressure.toString() ?? '',
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  BloodPressureDetailEntity toEntity() {
    return BloodPressureDetailEntity(
      id: id,
      patientId: patientId ?? 0,
      dystolicBloodPressure: dystolicBloodPressure ?? '',
      systolicBloodPressure: systolicBloodPressure ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
