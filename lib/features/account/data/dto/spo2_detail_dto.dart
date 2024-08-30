import 'package:medi_express_patients/features/account/domain/entities/spo2_detail_entity.dart';

class Spo2DetailDto {
  final int id;
  final int patientId;
  final String spo2;
  final String createdAt;
  final String updatedAt;

  Spo2DetailDto({
    required this.id,
    required this.patientId,
    required this.spo2,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Spo2DetailDto.fromJson(Map<String, dynamic> json) {
    return Spo2DetailDto(
      id: json['id'] ?? '',
      patientId: json['PatientID'] ?? '',
      spo2: json['SpO2'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId ?? '',
      'SpO2': spo2.toString() ?? 0,
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  Spo2DetailEntity toEntity() {
    return Spo2DetailEntity(
      id: id,
      patientId: patientId ?? 0,
      spo2: spo2 ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
