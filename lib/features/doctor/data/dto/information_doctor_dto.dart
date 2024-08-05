import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';

class InformationDoctorDto {
  final int id;
  final int doctorId;
  final String degree;
  final String? major;
  final String? specialistDoctor;
  final String currentWork;
  final DateTime createdAt;
  final DateTime updatedAt;

  InformationDoctorDto({
    required this.id,
    required this.doctorId,
    required this.degree,
    this.major,
    this.specialistDoctor,
    required this.currentWork,
    required this.createdAt,
    required this.updatedAt,
  });

  factory InformationDoctorDto.fromJson(Map<String, dynamic> json) {
    return InformationDoctorDto(
      id: json['id'],
      doctorId: json['DoctorID'],
      degree: json['Degree'],
      major: json['Major'],
      specialistDoctor: json['SpecialistDoctor'],
      currentWork: json['CurrentWork'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'DoctorID': doctorId,
      'Degree': degree,
      'Major': major,
      'SpecialistDoctor': specialistDoctor,
      'CurrentWork': currentWork,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  InformationDoctorEntity toEntity() {
    return InformationDoctorEntity(
      id: id,
      doctorId: doctorId,
      degree: degree,
      major: major,
      specialistDoctor: specialistDoctor,
      currentWork: currentWork,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
