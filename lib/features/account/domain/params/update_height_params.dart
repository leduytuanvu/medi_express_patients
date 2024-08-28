import 'package:equatable/equatable.dart';

class UpdateHeightParams extends Equatable {
  final int patientId;
  final double height;
  final String createAt;

  const UpdateHeightParams({
    required this.patientId,
    required this.height,
    required this.createAt,
  });

  @override
  List<Object?> get props => [
        patientId,
        height,
        createAt,
      ];
}
