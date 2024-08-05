class InformationDoctorEntity {
  final int id;
  final int doctorId;
  final String degree;
  final String? major;
  final String? specialistDoctor;
  final String currentWork;
  final DateTime createdAt;
  final DateTime updatedAt;

  InformationDoctorEntity({
    required this.id,
    required this.doctorId,
    required this.degree,
    this.major,
    this.specialistDoctor,
    required this.currentWork,
    required this.createdAt,
    required this.updatedAt,
  });
}
