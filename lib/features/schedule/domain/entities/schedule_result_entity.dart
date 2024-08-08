class ScheduleResultEntity {
  final int id;
  final int appointmentId;
  final String diagnosis;
  final String clinicalIndication;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ScheduleResultEntity({
    this.id = -1,
    this.appointmentId = -1,
    this.diagnosis = '',
    this.clinicalIndication = '',
    this.createdAt,
    this.updatedAt,
  });

  // Factory constructor to provide default values
  factory ScheduleResultEntity.withDefaults({
    int id = -1,
    int appointmentId = -1,
    String diagnosis = '',
    String clinicalIndication = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScheduleResultEntity(
      id: id,
      appointmentId: appointmentId,
      diagnosis: diagnosis,
      clinicalIndication: clinicalIndication,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  @override
  String toString() {
    return 'ScheduleResultEntity(id: $id, appointmentId: $appointmentId, diagnosis: $diagnosis, clinicalIndication: $clinicalIndication, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
