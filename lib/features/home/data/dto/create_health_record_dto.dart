class CreateHealthRecordDto {
  final int id;
  final int patientId;
  final String nameHealthRecord;
  final String filePath;
  final String description;
  final String createdAt;
  final String updatedAt;

  CreateHealthRecordDto({
    required this.id,
    required this.patientId,
    required this.nameHealthRecord,
    required this.filePath,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateHealthRecordDto.fromJson(Map<String, dynamic> json) {
    return CreateHealthRecordDto(
      id: json['id'],
      patientId: json['PatientID'],
      nameHealthRecord: json['NameHealthRecord'],
      filePath: json['FilePath'],
      description: json['Description'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId,
      'NameHealthRecord': nameHealthRecord,
      'FilePath': filePath,
      'Description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
