import 'package:medi_express_patients/features/auth/domain/entities/forgot_password_entity.dart';

class ForgotPasswordDto {
  final int id;
  final String phoneNumber;
  final String name;
  final String birthdate;
  final bool gender;
  final String? email;
  final String password;
  final String bhytCode;
  final String healthStatus;
  final String role;
  final String? avatar;
  final String createdAt;
  final String updatedAt;

  ForgotPasswordDto({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.birthdate,
    required this.gender,
    required this.email,
    required this.password,
    required this.bhytCode,
    required this.healthStatus,
    required this.role,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ForgotPasswordDto.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordDto(
      id: json['id'],
      phoneNumber: json['PhoneNumber'],
      name: json['Name'],
      birthdate: json['BirthDate'],
      gender: json['Gender'],
      email: json['Email'],
      password: json['Password'],
      bhytCode: json['BHYTCode'],
      healthStatus: json['HealthStatus'],
      role: json['Role'],
      avatar: json['Avatar'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PhoneNumber': phoneNumber,
      'Name': name,
      'BirthDate': birthdate,
      'Gender': gender,
      'Email': email,
      'Password': password,
      'BHYTCode': bhytCode,
      'HealthStatus': healthStatus,
      'Role': role,
      'Avatar': avatar,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  ForgotPasswordEntity toEntity() {
    return ForgotPasswordEntity(
      phoneNumber: phoneNumber,
      name: name,
      birthdate: birthdate,
      gender: gender,
      email: email,
      password: password,
      bhytCode: bhytCode,
      healthStatus: healthStatus,
      role: role,
      avatar: avatar,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
