class DoctorByNameEntity {
  final int id;
  final String phoneNumber;
  final String name;
  final DateTime birthDate;
  final bool gender;
  final String email;
  final String avatar;

  DoctorByNameEntity({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.email,
    required this.avatar,
  });
}
