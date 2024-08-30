import 'package:medi_express_patients/features/account/domain/entities/temperature_detail_entity.dart';

class TemperatureDetailDto {
  final int id;
  final int patientId;
  final String temperature;
  final String createdAt;
  final String updatedAt;

  TemperatureDetailDto({
    required this.id,
    required this.patientId,
    required this.temperature,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TemperatureDetailDto.fromJson(Map<String, dynamic> json) {
    return TemperatureDetailDto(
      id: json['id'] ?? '',
      patientId: json['PatientID'] ?? '',
      temperature: json['Temperature'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId ?? '',
      'Temperature': temperature.toString() ?? 0,
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  TemperatureDetailEntity toEntity() {
    return TemperatureDetailEntity(
      id: id,
      patientId: patientId ?? 0,
      temperature: temperature ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
