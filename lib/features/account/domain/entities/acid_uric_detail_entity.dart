class AcidUricDetailEntity {
  int id;
  int patientId;
  String acidUric;
  String createdAt;
  String updatedAt;

  AcidUricDetailEntity({
    this.id = 0,
    this.patientId = 0,
    this.acidUric = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  String toString() {
    return 'AcidUricDetailEntity(id: $id, patientId: $patientId, acidUric: $acidUric, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
