import 'package:medi_express_patients/features/auth/domain/entities/user_entity.dart';

class UserDto {
  int? id;
  String? phoneNumber;
  String? name;
  String? birthDate;
  bool? gender;
  String? email;
  String? bhytCode;
  String? healthStatus;
  String? role;
  String? active;
  String? avatar;
  String? fullAddress;

  UserDto({
    this.id,
    this.phoneNumber,
    this.name,
    this.birthDate,
    this.gender,
    this.email,
    this.bhytCode,
    this.healthStatus,
    this.role,
    this.active,
    this.avatar,
    this.fullAddress,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'],
      phoneNumber: json['PhoneNumber'],
      name: json['Name'],
      birthDate: json['BirthDate'],
      gender: json['Gender'],
      email: json['Email'],
      bhytCode: json['BHYTCode'],
      healthStatus: json['HealthStatus'],
      role: json['Role'],
      active: json['Active'],
      avatar: json['Avatar'],
      fullAddress: json['fullAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PhoneNumber': phoneNumber,
      'Name': name,
      'BirthDate': birthDate,
      'Gender': gender,
      'Email': email,
      'BHYTCode': bhytCode,
      'HealthStatus': healthStatus,
      'Role': role,
      'Active': active,
      'fullAddress': fullAddress,
      'avatar': avatar,
    };
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id ?? -1,
      phoneNumber: phoneNumber ?? '',
      name: name ?? '',
      birthDate: birthDate ?? '',
      gender: gender ?? false,
      email: email ?? '',
      bhytCode: bhytCode ?? '',
      healthStatus: healthStatus ?? '',
      role: role ?? '',
      active: active ?? '',
      avatar: avatar ?? '',
      fullAddress: fullAddress ?? '',
    );
  }
}
