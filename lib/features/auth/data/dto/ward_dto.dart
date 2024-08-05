import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';

class WardDto {
  final int id;
  final int districtId;
  final String wardName;
  final String createdAt;
  final String updatedAt;

  WardDto({
    required this.id,
    required this.districtId,
    required this.wardName,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WardDto.fromJson(Map<String, dynamic> json) {
    return WardDto(
      id: json['id'],
      districtId: json['DistrictID'],
      wardName: json['WardName'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'DistrictID': districtId,
      'WardName': wardName,
      'createdAt': updatedAt,
      'updatedAt': updatedAt,
    };
  }

  WardEntity toEntity() {
    return WardEntity(
      id: id,
      districtId: districtId,
      wardName: wardName,
    );
  }
}
