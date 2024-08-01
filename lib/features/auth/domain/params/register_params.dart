import 'package:equatable/equatable.dart';

class RegisterParams extends Equatable {
  final String phoneNumber;
  final String name;
  final String address;
  final int wardId;
  final int gender;
  final String birthdate;
  final String password;
  final String role;

  const RegisterParams({
    required this.phoneNumber,
    required this.name,
    required this.address,
    required this.wardId,
    required this.gender,
    required this.birthdate,
    required this.password,
    required this.role,
  });

  @override
  List<Object?> get props => [
        phoneNumber,
        name,
        address,
        wardId,
        gender,
        birthdate,
        password,
        role,
      ];
}
