import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String phoneNumber;
  final String name;
  final String address;
  final String email;
  final int wardId;
  final int gender;
  final String birthdate;
  final String bhytCode;
  final String password;
  final String role;

  const RegisterParams({
    required this.phoneNumber,
    required this.name,
    required this.address,
    required this.email,
    required this.wardId,
    required this.gender,
    required this.birthdate,
    required this.password,
    required this.bhytCode,
    required this.role,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        name,
        address,
        email,
        wardId,
        gender,
        birthdate,
        password,
        bhytCode,
        role,
      ];
}
