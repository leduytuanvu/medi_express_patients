import 'package:medi_express_patients/features/home/domain/entities/home_examination_package_entity.dart';

class HomeExaminationPackageDto {
  final int id;
  final String serviceName;
  final String priceTag;
  final String description;
  final String duration;
  final String filePath;
  final String createdAt;
  final String updatedAt;

  HomeExaminationPackageDto({
    required this.id,
    required this.serviceName,
    required this.priceTag,
    required this.description,
    required this.duration,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory HomeExaminationPackageDto.fromJson(Map<String, dynamic> json) {
    return HomeExaminationPackageDto(
      id: json['id'] ?? -1,
      serviceName: json['ServiceName'] ?? '',
      priceTag: json['PriceTag'] ?? '',
      description: json['Description'] ?? '',
      duration: json['Duration'] ?? '',
      filePath: json['FilePath'] ??
          'https://firebasestorage.googleapis.com/v0/b/medi-express-54e27.appspot.com/o/services%2Feb97e45c-dc20-4eba-ae2b-ef285226f60e-package_exam_service.jpg?alt=media&token=e8ad7fca-d56d-41ef-866e-81fcdca516c8',
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ServiceName': serviceName,
      'PriceTag': priceTag,
      'Description': description,
      'Duration': duration,
      'FilePath': filePath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  HomeExaminationPackageEntity toEntity() {
    return HomeExaminationPackageEntity(
      id: id,
      serviceName: serviceName,
      priceTag: priceTag,
      description: description,
      duration: duration,
      filePath: filePath,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
