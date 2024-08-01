import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';

class DistrictDto {
  final int id;
  final int cityId;
  final String districtName;
  final String createdAt;
  final String updatedAt;

  DistrictDto({
    required this.id,
    required this.cityId,
    required this.districtName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DistrictDto.fromJson(Map<String, dynamic> json) {
    return DistrictDto(
      id: json['id'],
      cityId: json['CityID'],
      districtName: json['DistrictName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CityID': cityId,
      'DistrictName': createdAt,
      'createdAt': updatedAt,
      'updatedAt': updatedAt,
    };
  }

  DistrictEntity toEntity() {
    return DistrictEntity(
      id: id,
      cityId: cityId,
      districtName: districtName,
    );
  }
}
