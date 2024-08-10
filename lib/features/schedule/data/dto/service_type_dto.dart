import 'package:medi_express_patients/features/schedule/domain/entities/service_type_entity.dart';

class ServiceTypeDto {
  final int id;
  final String serviceTypeName;
  final String description;
  final String createdAt;
  final String updatedAt;

  ServiceTypeDto({
    required this.id,
    required this.serviceTypeName,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ServiceTypeDto.fromJson(Map<String, dynamic> json) {
    return ServiceTypeDto(
      id: json['id'] ?? 0,
      serviceTypeName: json['ServiceTypeName'] ?? '',
      description: json['Description'] ?? '',
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ServiceTypeName': serviceTypeName,
      'Description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  ServiceTypeEntity toEntity() {
    return ServiceTypeEntity(
      id: id,
      serviceTypeName: serviceTypeName,
      description: description,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
