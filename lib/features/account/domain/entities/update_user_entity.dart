class UpdateUserEntity {
  final String name;
  final String phoneNumber;
  final String email;
  final String avatar;
  final String bhytCode;
  final String healthStatus;
  final String birthDate;
  final bool gender;
  final String address;
  final int wardId;

  UpdateUserEntity({
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.avatar,
    required this.bhytCode,
    required this.healthStatus,
    required this.birthDate,
    required this.gender,
    required this.address,
    required this.wardId,
  });

  @override
  String toString() {
    return 'UpdateUserEntity(name: $name, phoneNumber: $phoneNumber, email: $email, avatar: $avatar, bhytCode: $bhytCode, healthStatus: $healthStatus, birthDate: $birthDate, gender: $gender, address: $address, wardId: $wardId)';
  }
}
