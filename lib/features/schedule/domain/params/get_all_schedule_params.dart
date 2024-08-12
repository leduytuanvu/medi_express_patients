import 'package:equatable/equatable.dart';

class GetAllScheduleParams extends Equatable {
  final String status;
  final int patientId;

  const GetAllScheduleParams({
    required this.status,
    required this.patientId,
  });

  @override
  List<Object?> get props => [
        status,
        patientId,
      ];
}
