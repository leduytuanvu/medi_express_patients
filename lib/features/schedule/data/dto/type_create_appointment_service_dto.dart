import 'package:medi_express_patients/features/schedule/domain/entities/type_create_appointment_service_entity.dart';

class TypeCreateAppointmentServiceDto {
  final int id;
  final String? serviceName;
  final String? priceTag;
  final String? description;
  final String? duration;
  final String? createdAt;
  final String? updatedAt;

  TypeCreateAppointmentServiceDto({
    required this.id,
    required this.serviceName,
    required this.priceTag,
    required this.description,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TypeCreateAppointmentServiceDto.fromJson(Map<String, dynamic> json) {
    return TypeCreateAppointmentServiceDto(
      id: json['id'] ?? -1,
      serviceName: json['ServiceName'] ?? '',
      priceTag: json['PriceTag'] ?? '',
      description: json['Description'] ?? '',
      duration: json['Duration'] ?? '',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? -1,
      'ServiceName': serviceName ?? '',
      'PriceTag': priceTag ?? '',
      'Description': description ?? '',
      'Duration': duration ?? '',
      'createdAt': createdAt ?? '',
      'updatedAt': updatedAt ?? '',
    };
  }

  TypeCreateAppointmentServiceEntity toEntity() {
    return TypeCreateAppointmentServiceEntity(
      id: id,
      serviceName: serviceName ?? '',
      priceTag: priceTag ?? '',
      description: description ?? '',
      duration: duration ?? '',
      createdAt: createdAt ?? '',
      updatedAt: updatedAt ?? '',
    );
  }
}
