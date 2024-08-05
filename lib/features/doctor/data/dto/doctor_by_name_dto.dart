import 'package:medi_express_patients/features/doctor/domain/entities/doctor_by_name_entity.dart';

class DoctorByNameDto {
  final int id;
  final String phoneNumber;
  final String name;
  final DateTime birthDate;
  final bool gender;
  final String email;
  final String avatar;

  DoctorByNameDto({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.email,
    required this.avatar,
  });

  factory DoctorByNameDto.fromJson(Map<String, dynamic> json) {
    return DoctorByNameDto(
      id: json['id'],
      phoneNumber: json['PhoneNumber'],
      name: json['Name'],
      birthDate: DateTime.parse(json['BirthDate']),
      gender: json['Gender'],
      email: json['Email'],
      avatar: json['Avatar'],
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
      'Avatar': avatar,
    };
  }

  DoctorByNameEntity toEntity() {
    return DoctorByNameEntity(
      id: id,
      phoneNumber: phoneNumber,
      name: name,
      birthDate: birthDate,
      gender: gender,
      email: email,
      avatar: avatar,
    );
  }
}
