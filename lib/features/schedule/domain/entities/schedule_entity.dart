class ScheduleEntity {
  final int appointmentId;
  final int patientId;
  final String namePatient;
  final String phonePatient;
  final int doctorId;
  final String nameDoctor;
  final String phoneDoctor;
  final String nameService;
  final String nameServiceType;
  final String clinic;
  final String appointmentDate;
  final String startTime;
  final String endTime;
  final String status;
  final String createdAt;
  final String updatedAt;

  ScheduleEntity({
    required this.appointmentId,
    required this.patientId,
    required this.namePatient,
    required this.phonePatient,
    required this.doctorId,
    required this.nameDoctor,
    required this.phoneDoctor,
    required this.nameService,
    required this.nameServiceType,
    required this.clinic,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  String toString() {
    return 'ScheduleEntity(appointmentId: $appointmentId, patientId: $patientId, namePatient: $namePatient, phonePatient: $phonePatient, doctorId: $doctorId, nameDoctor: $nameDoctor, phoneDoctor: $phoneDoctor, nameService: $nameService, nameServiceType: $nameServiceType, clinic: $clinic, appointmentDate: $appointmentDate, startTime: $startTime, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
