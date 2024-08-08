import 'package:medi_express_patients/features/home/domain/entities/health_record_entity.dart';

class HealthRecordDto {
  final int id;
  final int patientID;
  final String nameHealthRecord;
  final String filePath;
  final String description;
  final String createdAt;

  HealthRecordDto({
    required this.id,
    required this.patientID,
    required this.nameHealthRecord,
    required this.filePath,
    required this.description,
    required this.createdAt,
  });

  factory HealthRecordDto.fromJson(Map<String, dynamic> json) {
    return HealthRecordDto(
      id: json['id'],
      patientID: json['PatientID'],
      nameHealthRecord: json['NameHealthRecord'],
      filePath: json['FilePath'],
      description: json['Description'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientID,
      'NameHealthRecord': nameHealthRecord,
      'FilePath': filePath,
      'Description': description,
      'createdAt': createdAt,
    };
  }

  HealthRecordEntity toEntity() {
    return HealthRecordEntity(
      id: id,
      patientID: patientID,
      nameHealthRecord: nameHealthRecord,
      filePath: filePath,
      description: description,
      createdAt: createdAt,
    );
  }
}
