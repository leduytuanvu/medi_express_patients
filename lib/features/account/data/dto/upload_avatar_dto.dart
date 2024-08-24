import 'package:medi_express_patients/features/account/domain/entities/upload_avatar_entity.dart';

class UploadAvatarDto {
  final int id;
  final String? phoneNumber;
  final String? name;
  final String? birthDate;
  final bool? gender;
  final String? email;
  final String? password;
  final String? bhytCode;
  final String? healthStatus;
  final String? role;
  final String? avatar;
  final String? active;
  final String? createdAt;
  final String? updatedAt;

  UploadAvatarDto({
    required this.id,
    this.phoneNumber = '',
    this.name = '',
    this.birthDate = '',
    this.gender = true,
    this.email = '',
    this.password = '',
    this.bhytCode = '',
    this.healthStatus = '',
    this.role = '',
    this.avatar = '',
    this.active = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  factory UploadAvatarDto.fromJson(Map<String, dynamic> json) {
    return UploadAvatarDto(
      id: json['id'],
      phoneNumber: json['PhoneNumber'] ?? '',
      name: json['Name'] ?? '',
      birthDate: json['BirthDate'] ?? '',
      gender: json['Gender'] ?? '',
      email: json['Email'] ?? '',
      password: json['Password'] ?? '',
      bhytCode: json['BHYTCode'] ?? '',
      healthStatus: json['HealthStatus'] ?? '',
      role: json['Role'] ?? '',
      avatar: json['Avatar'] ?? '',
      active: json['Active'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PhoneNumber': phoneNumber ?? '',
      'Name': name ?? '',
      'BirthDate': birthDate ?? '',
      'Gender': gender ?? '',
      'Email': email ?? '',
      'Password': password ?? '',
      'BHYTCode': bhytCode ?? '',
      'HealthStatus': healthStatus ?? '',
      'Role': role ?? '',
      'Avatar': avatar ?? '',
      'Active': active ?? '',
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  UploadAvatarEntity toEntity() {
    return UploadAvatarEntity(
      id: id,
      phoneNumber: phoneNumber ?? '',
      name: name ?? '',
      birthDate: birthDate ?? '',
      gender: gender ?? true,
      email: email ?? '',
      password: password ?? '',
      bhytCode: bhytCode ?? '',
      healthStatus: healthStatus ?? '',
      role: role ?? '',
      avatar: avatar ?? '',
      active: active ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
