import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';

class ScheduleDto {
  final int appointmentId;
  final int? patientId;
  final String? namePatient;
  final String? phonePatient;
  final int? doctorId;
  final String? nameDoctor;
  final String? phoneDoctor;
  final String? nameService;
  final String? nameServiceType;
  final String? address;
  final String? appointmentDate;
  final String? startTime;
  final String? endTime;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  ScheduleDto({
    required this.appointmentId,
    required this.patientId,
    required this.namePatient,
    required this.phonePatient,
    required this.doctorId,
    required this.nameDoctor,
    required this.phoneDoctor,
    required this.nameService,
    required this.nameServiceType,
    required this.address,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleDto.fromJson(Map<String, dynamic> json) {
    return ScheduleDto(
      appointmentId: json['AppointmentID'] ?? -1,
      patientId: json['PatientID'] ?? -1,
      namePatient: json['NamePatient'] ?? '',
      phonePatient: json['PhonePatient'] ?? '',
      doctorId: json['DoctorID'] ?? -1,
      nameDoctor: json['NameDoctor'] ?? '',
      phoneDoctor: json['PhoneDotor'] ??
          '', // Typo in JSON field: should be "PhoneDoctor"
      nameService: json['NameService'] ?? '',
      nameServiceType: json['NameServiceType'] ?? '',
      address: json['Address'] ?? '',
      appointmentDate: json['AppointmentDate'] ?? '',
      startTime: json['StartTime'] ?? '',
      endTime: json['EndTime'] ?? '',
      status: json['Status'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AppointmentID': appointmentId ?? -1,
      'PatientID': patientId ?? -1,
      'NamePatient': namePatient ?? '',
      'PhonePatient': phonePatient ?? '',
      'DoctorID': doctorId ?? -1,
      'NameDoctor': nameDoctor ?? '',
      'PhoneDoctor': phoneDoctor ?? '', // Typo fixed here
      'NameService': nameService ?? '',
      'NameServiceType': nameServiceType ?? '',
      'Address': address ?? '',
      'AppointmentDate': appointmentDate ?? '',
      'StartTime': startTime ?? '',
      'EndTime': endTime ?? '',
      'Status': status ?? '',
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  ScheduleEntity toEntity() {
    return ScheduleEntity(
      appointmentId: appointmentId ?? -1,
      patientId: patientId ?? -1,
      namePatient: namePatient ?? '',
      phonePatient: phonePatient ?? '',
      doctorId: doctorId ?? -1,
      nameDoctor: nameDoctor ?? '',
      phoneDoctor: phoneDoctor ?? '',
      nameService: nameService ?? '',
      nameServiceType: nameServiceType ?? '',
      address: address ?? '',
      appointmentDate: appointmentDate ?? '',
      startTime: startTime ?? '',
      endTime: endTime ?? '',
      status: status ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
