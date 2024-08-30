class TemperatureDetailEntity {
  int id;
  int patientId;
  String temperature;
  String createdAt;
  String updatedAt;

  TemperatureDetailEntity({
    this.id = 0,
    this.patientId = 0,
    this.temperature = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  String toString() {
    return 'TemperatureDetailEntity(id: $id, patientId: $patientId, temperature: $temperature, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
