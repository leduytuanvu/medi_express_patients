import 'package:equatable/equatable.dart';

class ForgotPasswordParams extends Equatable {
  final String phoneNumber;
  final String password;

  const ForgotPasswordParams({
    required this.phoneNumber,
    required this.password,
  });

  @override
  List<Object?> get props => [phoneNumber, password];
}
