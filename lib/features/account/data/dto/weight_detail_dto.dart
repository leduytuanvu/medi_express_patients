import 'package:medi_express_patients/features/account/domain/entities/weight_detail_entity.dart';

class WeightDetailDto {
  final int id;
  final int patientId;
  final String weight;
  final String createdAt;
  final String updatedAt;

  WeightDetailDto({
    required this.id,
    required this.patientId,
    required this.weight,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WeightDetailDto.fromJson(Map<String, dynamic> json) {
    return WeightDetailDto(
      id: json['id'] ?? '',
      patientId: json['PatientID'] ?? '',
      weight: json['Weight'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId ?? '',
      'Weight': weight.toString() ?? 0,
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  WeightDetailEntity toEntity() {
    return WeightDetailEntity(
      id: id,
      patientId: patientId ?? 0,
      weight: weight ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
