import 'package:medi_express_patients/features/home/data/dto/create_health_record_dto.dart';

class CreateHealthRecordEntity {
  final int id;
  final int patientId;
  final String nameHealthRecord;
  final String filePath;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  CreateHealthRecordEntity({
    required this.id,
    required this.patientId,
    required this.nameHealthRecord,
    required this.filePath,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateHealthRecordEntity.fromDto(CreateHealthRecordDto dto) {
    return CreateHealthRecordEntity(
      id: dto.id,
      patientId: dto.patientId,
      nameHealthRecord: dto.nameHealthRecord,
      filePath: dto.filePath,
      description: dto.description,
      createdAt: DateTime.parse(dto.createdAt),
      updatedAt: DateTime.parse(dto.updatedAt),
    );
  }
}
