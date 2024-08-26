class UserEntity {
  int id;
  String phoneNumber;
  String? name;
  String? birthDate;
  bool? gender;
  String? email;
  String? bhytCode;
  String? healthStatus;
  String? role;
  String? active;
  String? fullAddress;
  String? avatar;

  UserEntity({
    this.id = -1,
    this.phoneNumber = '',
    this.name = '',
    this.birthDate = '',
    this.gender = false,
    this.email = '',
    this.bhytCode = '',
    this.healthStatus = '',
    this.role = '',
    this.active = '',
    this.fullAddress = '',
    this.avatar = '',
  });

  @override
  String toString() {
    return '========= $id, $phoneNumber, $avatar, $name, $birthDate, $gender, $email, $bhytCode, $healthStatus, $role, $active, $fullAddress';
  }
}
