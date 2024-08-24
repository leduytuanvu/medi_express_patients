class UploadAvatarEntity {
  final int id;
  final String? phoneNumber;
  final String? name;
  final String? birthDate;
  final bool? gender;
  final String? email;
  final String? password;
  final String? bhytCode;
  final String? healthStatus;
  final String? role;
  final String? avatar;
  final String? active;
  final String? createdAt;
  final String? updatedAt;

  UploadAvatarEntity({
    required this.id,
    this.phoneNumber,
    this.name,
    this.birthDate,
    this.gender,
    this.email,
    this.password,
    this.bhytCode,
    this.healthStatus,
    this.role,
    this.avatar,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  @override
  String toString() {
    return 'UploadAvatarEntity(id: $id, phoneNumber: $phoneNumber, name: $name, birthDate: $birthDate, gender: $gender, email: $email, password: $password, bhytCode: $bhytCode, healthStatus: $healthStatus, role: $role, avatar: $avatar, active: $active, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
