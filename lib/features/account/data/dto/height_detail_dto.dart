import 'package:medi_express_patients/features/account/domain/entities/height_detail_entity.dart';

class HeightDetailDto {
  final int id;
  final int patientId;
  final String height;
  final String createdAt;
  final String updatedAt;

  HeightDetailDto({
    required this.id,
    required this.patientId,
    required this.height,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HeightDetailDto.fromJson(Map<String, dynamic> json) {
    return HeightDetailDto(
      id: json['id'] ?? '',
      patientId: json['PatientID'] ?? '',
      height: json['Height'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId ?? '',
      'Height': height.toString() ?? 0,
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  HeightDetailEntity toEntity() {
    return HeightDetailEntity(
      id: id,
      patientId: patientId ?? 0,
      height: height ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
