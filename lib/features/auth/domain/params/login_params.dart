import 'package:equatable/equatable.dart';

class LoginParams extends Equatable {
  final String phoneNumber;
  final String password;

  const LoginParams({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [phoneNumber, password];
}
