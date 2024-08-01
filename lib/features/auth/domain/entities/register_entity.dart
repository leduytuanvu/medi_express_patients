class RegisterEntity {
  final int patientId;
  final String name;
  final String phoneNumber;
  final String birthdate;
  final String address;
  final String ward;
  final String district;
  final String city;

  RegisterEntity({
    required this.patientId,
    required this.phoneNumber,
    required this.name,
    required this.birthdate,
    required this.address,
    required this.ward,
    required this.district,
    required this.city,
  });
}
