import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';

class ScheduleDto {
  final int appointmentId;
  final int patientId;
  final String namePatient;
  final String phonePatient;
  final int doctorId;
  final String nameDoctor;
  final String phoneDoctor;
  final String nameService;
  final String nameServiceType;
  final String clinic;
  final String appointmentDate;
  final String startTime;
  final String endTime;
  final String status;
  final String createdAt;
  final String updatedAt;

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
    required this.clinic,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduleDto.fromJson(Map<String, dynamic> json) {
    return ScheduleDto(
      appointmentId: json['AppointmentID'],
      patientId: json['PatientID'],
      namePatient: json['NamePatient'],
      phonePatient: json['PhonePatient'],
      doctorId: json['DoctorID'],
      nameDoctor: json['NameDoctor'],
      phoneDoctor: json['PhoneDotor'],
      nameService: json['NameService'],
      nameServiceType: json['NameServiceType'],
      clinic: json['Clinic'],
      appointmentDate: json['AppointmentDate'],
      startTime: json['StartTime'],
      endTime: json['EndTime'],
      status: json['Status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AppointmentID': appointmentId,
      'PatientID': patientId,
      'NamePatient': namePatient,
      'PhonePatient': phonePatient,
      'DoctorID': doctorId,
      'NameDoctor': nameDoctor,
      'PhoneDotor': phoneDoctor,
      'NameService': nameService,
      'NameServiceType': nameServiceType,
      'Clinic': clinic,
      'AppointmentDate': appointmentDate,
      'StartTime': startTime,
      'EndTime': endTime,
      'Status': status,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  ScheduleEntity toEntity() {
    return ScheduleEntity(
      appointmentId: appointmentId,
      patientId: patientId,
      namePatient: namePatient,
      phonePatient: phonePatient,
      doctorId: doctorId,
      nameDoctor: nameDoctor,
      phoneDoctor: phoneDoctor,
      nameService: nameService,
      nameServiceType: nameServiceType,
      clinic: clinic,
      appointmentDate: appointmentDate,
      startTime: startTime,
      endTime: endTime,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
