class UploadPatientEntity {
  final int id;
  final int patientID;
  final String? nameHealthRecord;
  final String? filePath;
  final String? createDate;
  final String? description;
  final String? updatedAt;
  final String? createdAt;

  UploadPatientEntity({
    required this.id,
    required this.patientID,
    this.nameHealthRecord,
    this.filePath,
    this.createDate,
    this.description,
    this.updatedAt,
    this.createdAt,
  });

  @override
  String toString() {
    return 'UploadPatientEntity(id: $id, patientID: $patientID, nameHealthRecord: $nameHealthRecord, filePath: $filePath, createDate: $createDate, description: $description, updatedAt: $updatedAt, createdAt: $createdAt)';
  }
}
