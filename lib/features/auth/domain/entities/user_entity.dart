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
  String? street;
  String? ward;
  String? district;
  String? city;


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
    this.street = '',
    this.ward = '',
    this.district = '',
    this.city = '',
  });

  @override
  String toString() {
    return '========= $id, $phoneNumber, $name, $birthDate, $gender, $email, $bhytCode, $healthStatus, $role, $active, $street, $ward, $district, $ward';
  }
}
