import 'package:medi_express_patients/features/schedule/domain/entities/schedule_result_entity.dart';

class ScheduleResultDto {
  final int id;
  final int appointmentId;
  final String diagnosis;
  final String clinicalIndication;
  final DateTime createdAt;
  final DateTime updatedAt;

  ScheduleResultDto({
    required this.id,
    required this.appointmentId,
    required this.diagnosis,
    required this.clinicalIndication,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleResultDto.fromJson(Map<String, dynamic> json) {
    return ScheduleResultDto(
      id: json['id'],
      appointmentId: json['AppointmentID'],
      diagnosis: json['Diagnosis'],
      clinicalIndication: json['ClinicalIndication'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'AppointmentID': appointmentId,
      'Diagnosis': diagnosis,
      'ClinicalIndication': clinicalIndication,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  ScheduleResultEntity toEntity() {
    return ScheduleResultEntity(
      id: id,
      appointmentId: appointmentId,
      diagnosis: diagnosis,
      clinicalIndication: clinicalIndication,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
