import 'package:medi_express_patients/features/auth/domain/entities/register_entity.dart';

class RegisterDto {
  final int id;
  final String name;
  final String phoneNumber;
  final String birthdate;
  final String address;
  final String ward;
  final String district;
  final String city;

  RegisterDto({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.birthdate,
    required this.address,
    required this.ward,
    required this.district,
    required this.city,
  });

  factory RegisterDto.fromJson(Map<String, dynamic> json) {
    return RegisterDto(
      id: json['id'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      birthdate: json['birthdate'],
      address: json['address'],
      ward: json['ward'],
      district: json['district'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'birthdate': birthdate,
      'address': address,
      'ward': ward,
      'district': district,
      'city': city,
    };
  }

  RegisterEntity toEntity() {
    return RegisterEntity(
      patientId: id,
      phoneNumber: phoneNumber,
      name: name,
      birthdate: birthdate,
      address: address,
      ward: ward,
      district: district,
      city: city,
    );
  }
}
