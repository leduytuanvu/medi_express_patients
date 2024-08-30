class HeightDetailEntity {
  int id;
  int patientId;
  String height;
  String createdAt;
  String updatedAt;

  HeightDetailEntity({
    this.id = 0,
    this.patientId = 0,
    this.height = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  String toString() {
    return 'HeightDetailEntity(id: $id, patientId: $patientId, height: $height, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
