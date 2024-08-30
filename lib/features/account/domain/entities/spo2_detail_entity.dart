class Spo2DetailEntity {
  int id;
  int patientId;
  String spo2;
  String createdAt;
  String updatedAt;

  Spo2DetailEntity({
    this.id = 0,
    this.patientId = 0,
    this.spo2 = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  String toString() {
    return 'Spo2DetailEntity(id: $id, patientId: $patientId, spo2: $spo2, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
