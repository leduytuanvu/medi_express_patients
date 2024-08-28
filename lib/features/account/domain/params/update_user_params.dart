import 'package:equatable/equatable.dart';

class UpdateUserParams extends Equatable {
  final int gender;
  final String address;
  final String email;
  final int wardId;
  final String name;
  final String birthdate;
  final String bhytCode;

  const UpdateUserParams({
    required this.gender,
    required this.address,
    required this.email,
    required this.wardId,
    required this.name,
    required this.birthdate,
    required this.bhytCode,
  });

  @override
  List<Object?> get props => [
        gender,
        address,
        email,
        wardId,
        name,
        birthdate,
        bhytCode,
      ];
}
