class InformationDoctorEntity {
  final int id;
  final int doctorId;
  final String degree;
  final String name;
  final String avatar;
  final String? major;
  final String? specialistDoctor;
  final String currentWork;

  InformationDoctorEntity({
    required this.id,
    required this.doctorId,
    required this.degree,
    required this.name,
    required this.avatar,
    this.major,
    this.specialistDoctor,
    required this.currentWork,
  });
}
