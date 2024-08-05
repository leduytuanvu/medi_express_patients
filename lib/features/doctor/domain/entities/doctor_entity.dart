class DoctorEntity {
  final int id;
  final String phoneNumber;
  final String name;
  final DateTime birthDate;
  final bool gender;
  final String email;
  final String? bhytCode;
  final String? healthStatus;
  final String role;
  final String? avatar;
  final bool? active;

  DoctorEntity({
    required this.id,
    required this.phoneNumber,
    required this.name,
    required this.birthDate,
    required this.gender,
    required this.email,
    this.bhytCode,
    this.healthStatus,
    required this.role,
    this.avatar,
    this.active,
  });
}
