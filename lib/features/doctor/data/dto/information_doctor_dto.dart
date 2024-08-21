import 'package:medi_express_patients/features/doctor/domain/entities/information_doctor_entity.dart';

class InformationDoctorDto {
  final int id;
  final int doctorId;
  final String? degree;
  final String? name;
  final String? avatar;
  final String? major;
  final String? specialistDoctor;
  final String? currentWork;

  InformationDoctorDto({
    required this.id,
    required this.doctorId,
    this.degree,
    this.name,
    this.avatar,
    this.major,
    this.specialistDoctor,
    this.currentWork,
  });

  factory InformationDoctorDto.fromJson(Map<String, dynamic> json) {
    return InformationDoctorDto(
      id: json['id'],
      doctorId: json['doctorId'],
      degree: json['Degree'] ?? '',
      name: json['Name'] ?? '',
      avatar: json['Avatar'] ?? '',
      major: json['Major'] ?? '',
      specialistDoctor: json['SpecialistDoctor'] ?? '',
      currentWork: json['CurrentWork'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'doctorId': doctorId,
      'Degree': degree ?? '',
      'Name': name ?? '',
      'Avatar': avatar ?? '',
      'Major': major ?? '',
      'SpecialistDoctor': specialistDoctor ?? '',
      'CurrentWork': currentWork ?? '',
    };
  }

  InformationDoctorEntity toEntity() {
    return InformationDoctorEntity(
      id: id,
      doctorId: doctorId,
      degree: degree ?? '',
      name: name ?? '',
      avatar: avatar ?? '',
      major: major ?? '',
      specialistDoctor: specialistDoctor ?? '',
      currentWork: currentWork ?? '',
    );
  }
}
