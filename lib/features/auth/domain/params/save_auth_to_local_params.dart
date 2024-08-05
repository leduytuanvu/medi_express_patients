import 'package:equatable/equatable.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';

class SaveAuthToLocalParams extends Equatable {
  final AuthEntity auth;

  const SaveAuthToLocalParams({
    required this.auth,
  });

  @override
  List<Object?> get props => [auth];
}
