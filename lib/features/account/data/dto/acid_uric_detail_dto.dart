import 'package:medi_express_patients/features/account/domain/entities/acid_uric_detail_entity.dart';

class AcidUricDetailDto {
  final int id;
  final int patientId;
  final String acidUric;
  final String createdAt;
  final String updatedAt;

  AcidUricDetailDto({
    required this.id,
    required this.patientId,
    required this.acidUric,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AcidUricDetailDto.fromJson(Map<String, dynamic> json) {
    return AcidUricDetailDto(
      id: json['id'] ?? '',
      patientId: json['PatientID'] ?? '',
      acidUric: json['AcidUric'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId ?? '',
      'AcidUric': acidUric.toString() ?? 0,
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  AcidUricDetailEntity toEntity() {
    return AcidUricDetailEntity(
      id: id,
      patientId: patientId ?? 0,
      acidUric: acidUric ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
