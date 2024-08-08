class HealthRecordEntity {
  final int id;
  final int patientID;
  final String nameHealthRecord;
  final String filePath;
  final String description;
  final String createdAt;

  HealthRecordEntity({
    required this.id,
    required this.patientID,
    required this.nameHealthRecord,
    required this.filePath,
    required this.description,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'HealthRecordEntity{id: $id, patientID: $patientID, nameHealthRecord: $nameHealthRecord, filePath: $filePath, description: $description, createdAt: $createdAt';
  }
}
