import 'package:medi_express_patients/features/home/domain/entities/upload_patient_entity.dart';

class UploadPatientDto {
  final int id;
  final int patientID;
  final String? nameHealthRecord;
  final String? filePath;
  final String? createDate;
  final String? description;
  final String? updatedAt;
  final String? createdAt;

  UploadPatientDto({
    required this.id,
    required this.patientID,
    this.nameHealthRecord,
    this.filePath,
    this.createDate,
    this.description,
    this.updatedAt,
    this.createdAt,
  });

  factory UploadPatientDto.fromJson(Map<String, dynamic> json) {
    return UploadPatientDto(
      id: json['id'] ?? -1,
      patientID: json['PatientID'] ?? -1,
      nameHealthRecord: json['NameHealthRecord'] ?? '',
      filePath: json['FilePath'] ?? '',
      createDate: json['CreateDate'] ?? '',
      description: json['Description'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? -1,
      'PatientID': patientID ?? -1,
      'NameHealthRecord': nameHealthRecord ?? '',
      'FilePath': filePath ?? '',
      'CreateDate': createDate ?? '',
      'Description': description ?? '',
      'updatedAt': updatedAt ?? '',
      'createdAt': createdAt ?? '',
    };
  }

  UploadPatientEntity toEntity() {
    return UploadPatientEntity(
      id: id ?? -1,
      patientID: patientID ?? -1,
      nameHealthRecord: nameHealthRecord ?? '',
      filePath: filePath ?? '',
      createDate: createDate ?? '',
      description: description ?? '',
      updatedAt: updatedAt ?? '',
      createdAt: createdAt ?? '',
    );
  }
}
