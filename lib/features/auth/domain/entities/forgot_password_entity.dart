class ForgotPasswordEntity {
  final String phoneNumber;
  final String name;
  final String birthdate;
  final bool gender;
  final String? email;
  final String password;
  final String bhytCode;
  final String healthStatus;
  final String role;
  final String? avatar;
  final String createdAt;
  final String updatedAt;

  ForgotPasswordEntity({
    required this.phoneNumber,
    required this.name,
    required this.birthdate,
    required this.gender,
    required this.email,
    required this.password,
    required this.bhytCode,
    required this.healthStatus,
    required this.role,
    required this.avatar,
    required this.createdAt,
    required this.updatedAt,
  });
}
