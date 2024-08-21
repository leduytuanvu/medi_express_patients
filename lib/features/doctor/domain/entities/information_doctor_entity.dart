class InformationDoctorEntity {
  final int id;
  final int doctorId;
  final String? degree;
  final String? name;
  final String? avatar;
  final String? major;
  final String? specialistDoctor;
  final String? currentWork;

  InformationDoctorEntity({
    required this.id,
    required this.doctorId,
    this.degree,
    this.name,
    this.avatar,
    this.major,
    this.specialistDoctor,
    this.currentWork,
  });
}
