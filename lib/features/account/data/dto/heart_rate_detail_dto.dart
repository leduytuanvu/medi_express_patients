import 'package:medi_express_patients/features/account/domain/entities/heart_rate_detail_entity.dart';

class HeartRateDetailDto {
  final int id;
  final int patientId;
  final String heartRate;
  final String createdAt;
  final String updatedAt;

  HeartRateDetailDto({
    required this.id,
    required this.patientId,
    required this.heartRate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HeartRateDetailDto.fromJson(Map<String, dynamic> json) {
    return HeartRateDetailDto(
      id: json['id'] ?? '',
      patientId: json['PatientID'] ?? '',
      heartRate: json['HeartRate'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId ?? '',
      'HeartRate': heartRate.toString() ?? 0,
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  HeartRateDetailEntity toEntity() {
    return HeartRateDetailEntity(
      id: id,
      patientId: patientId ?? 0,
      heartRate: heartRate ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
