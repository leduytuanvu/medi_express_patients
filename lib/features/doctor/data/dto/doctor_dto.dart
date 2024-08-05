import 'package:medi_express_patients/features/doctor/domain/entities/doctor_entity.dart';

class DoctorDto {
  final int id;
  final String phoneNumber;
  final String name;
  final DateTime birthDate;
  final bool gender;
  final String email;
  final String? bhytCode;
  final String? healthStatus;
  final String role;
  final String? avatar;
  final bool? active;

  DoctorDto({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.email,
    this.bhytCode,
    this.healthStatus,
    required this.role,
    this.avatar,
    this.active,
  });

  factory DoctorDto.fromJson(Map<String, dynamic> json) {
    return DoctorDto(
      id: json['id'],
      phoneNumber: json['PhoneNumber'],
      name: json['Name'],
      birthDate: DateTime.parse(json['BirthDate']),
      gender: json['Gender'],
      email: json['Email'],
      bhytCode: json['BHYTCode'],
      healthStatus: json['HealthStatus'],
      role: json['Role'],
      avatar: json['Avatar'],
      active: json['Active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PhoneNumber': phoneNumber,
      'Name': name,
      'BirthDate': birthDate.toIso8601String(),
      'Gender': gender,
      'Email': email,
      'BHYTCode': bhytCode,
      'HealthStatus': healthStatus,
      'Role': role,
      'Avatar': avatar,
      'Active': active,
    };
  }

  DoctorEntity toEntity() {
    return DoctorEntity(
      id: id,
      phoneNumber: phoneNumber,
      name: name,
      birthDate: birthDate,
      gender: gender,
      email: email,
      bhytCode: bhytCode,
      healthStatus: healthStatus,
      role: role,
      avatar: avatar,
      active: active,
    );
  }
}