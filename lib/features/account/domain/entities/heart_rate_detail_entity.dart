class HeartRateDetailEntity {
  int id;
  int patientId;
  String heartRate;
  String createdAt;
  String updatedAt;

  HeartRateDetailEntity({
    this.id = 0,
    this.patientId = 0,
    this.heartRate = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  String toString() {
    return 'HeartRateDetailEntity(id: $id, patientId: $patientId, heartRate: $heartRate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
