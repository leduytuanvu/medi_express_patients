class CreateAppointmentEntity {
  final int id;
  final int patientId;
  final int doctorId;
  final int serviceId;
  final int serviceTypeId;
  final String appointmentDate;
  final String startTime;
  final String endTime;
  final String status;
  final String conclusion;
  final String? createdAt;
  final String? updatedAt;

  CreateAppointmentEntity({
    this.id = -1,
    this.patientId = -1,
    this.doctorId = -1,
    this.serviceId = -1,
    this.serviceTypeId = -1,
    this.appointmentDate = '',
    this.startTime = '',
    this.endTime = '',
    this.status = '',
    this.conclusion = '',
    this.createdAt = '',
    this.updatedAt = '',
  });

  @override
  String toString() {
    return 'CreateAppointmentEntity(id: $id, patientId: $patientId, doctorId: $doctorId, serviceId: $serviceId, serviceTypeId: $serviceTypeId, appointmentDate: $appointmentDate, startTime: $startTime, endTime: $endTime, status: $status, conclusion: $conclusion, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
