class WeightDetailEntity {
  int id;
  int patientId;
  String weight;
  String createdAt;
  String updatedAt;

  WeightDetailEntity({
    this.id = 0,
    this.patientId = 0,
    this.weight = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  String toString() {
    return 'WeightDetailEntity(id: $id, patientId: $patientId, weight: $weight, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
