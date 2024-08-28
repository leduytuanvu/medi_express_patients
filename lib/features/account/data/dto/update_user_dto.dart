import 'package:medi_express_patients/features/account/domain/entities/update_user_entity.dart';

class UpdateUserDto {
  final String name;
  final String phoneNumber;
  final String email;
  final String avatar;
  final String bhytCode;
  final String healthStatus;
  final String birthDate;
  final bool gender;
  final String address;
  final int wardId;

  UpdateUserDto({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.avatar,
    required this.bhytCode,
    required this.healthStatus,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.wardId,
  });

  factory UpdateUserDto.fromJson(Map<String, dynamic> json) {
    return UpdateUserDto(
      name: json['name'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      email: json['email'] ?? '',
      avatar: json['avatar'] ?? '',
      bhytCode: json['bhytCode'] ?? '',
      healthStatus: json['healthStatus'] ?? '',
      birthDate: json['birthDate'] ?? '',
      gender: json['gender'] ?? false,
      address: json['address'] ?? '',
      wardId: json['wardId'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'avatar': avatar,
      'bhytCode': bhytCode,
      'healthStatus': healthStatus,
      'birthDate': birthDate,
      'gender': gender,
      'address': address,
      'wardId': wardId,
    };
  }

  UpdateUserEntity toEntity() {
    return UpdateUserEntity(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      avatar: avatar,
      bhytCode: bhytCode,
      healthStatus: healthStatus,
      birthDate: birthDate,
      gender: gender,
      address: address,
      wardId: wardId,
    );
  }
}
