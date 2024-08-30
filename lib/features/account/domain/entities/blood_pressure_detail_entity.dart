class BloodPressureDetailEntity {
  int id;
  int patientId;
  String dystolicBloodPressure;
  String systolicBloodPressure;
  String createdAt;
  String updatedAt;

  BloodPressureDetailEntity({
    this.id = 0,
    this.patientId = 0,
    this.dystolicBloodPressure = '',
    this.systolicBloodPressure = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  String toString() {
    return 'BloodPressureDetailEntity(id: $id, patientId: $patientId, dystolicBloodPressure: $dystolicBloodPressure, $systolicBloodPressure, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
