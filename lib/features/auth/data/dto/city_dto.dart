import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';

class CityDto {
  final int id;
  final String cityName;
  final String createdAt;
  final String updatedAt;

  CityDto({
    required this.id,
    required this.cityName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CityDto.fromJson(Map<String, dynamic> json) {
    return CityDto(
      id: json['id'],
      cityName: json['CityName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CityName': cityName,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  CityEntity toEntity() {
    return CityEntity(
      id: id,
      name: cityName,
    );
  }
}
