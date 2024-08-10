import 'package:medi_express_patients/features/schedule/domain/entities/create_appointment_entity.dart';

class CreateAppointmentDto {
  final int id;
  final int? patientId;
  final int? doctorId;
  final int? serviceId;
  final int? serviceTypeId;
  final String? appointmentDate;
  final String? startTime;
  final String? endTime;
  final String? status;
  final String? conclusion;
  final String? createdAt;
  final String? updatedAt;

  CreateAppointmentDto({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.serviceId,
    required this.serviceTypeId,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.conclusion,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateAppointmentDto.fromJson(Map<String, dynamic> json) {
    return CreateAppointmentDto(
      id: json['id'] ?? -1,
      patientId: json['PatientID'] ?? -1,
      doctorId: json['DoctorID'] ?? -1,
      serviceId: json['ServiceID'] ?? -1,
      serviceTypeId: json['ServiceTypeID'] ?? -1,
      appointmentDate: json['AppointmentDate'] ?? '',
      startTime: json['StartTime'] ?? '',
      endTime: json['EndTime'] ?? '',
      status: json['Status'] ?? '',
      conclusion: json['Conclusion'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? -1,
      'PatientID': patientId ?? -1,
      'DoctorID': doctorId ?? -1,
      'ServiceID': serviceId ?? -1,
      'ServiceTypeID': serviceTypeId ?? -1,
      'AppointmentDate': appointmentDate ?? '',
      'StartTime': startTime ?? '',
      'EndTime': endTime ?? '',
      'Status': status ?? '',
      'Conclusion': conclusion ?? '',
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  CreateAppointmentEntity toEntity() {
    return CreateAppointmentEntity(
      id: id ?? -1,
      patientId: patientId ?? -1,
      doctorId: doctorId ?? -1,
      serviceId: serviceId ?? -1,
      serviceTypeId: serviceTypeId ?? -1,
      appointmentDate: appointmentDate ?? '',
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      status: status ?? '',
      conclusion: conclusion ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
