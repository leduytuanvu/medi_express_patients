import 'package:equatable/equatable.dart';

class CreateMedicalHistoryParams extends Equatable {
  final int patientId;
  final bool hypertension;
  final bool diabetes;
  final bool heartDisease;
  final bool stroke;
  final bool asthma;
  final bool epilepsy;
  final bool copd;
  final bool palpitations;
  final String otherMedicalHistory;

  const CreateMedicalHistoryParams({
    required this.patientId,
    required this.hypertension,
    required this.diabetes,
    required this.heartDisease,
    required this.stroke,
    required this.asthma,
    required this.epilepsy,
    required this.copd,
    required this.palpitations,
    required this.otherMedicalHistory,
  });

  @override
  List<Object?> get props => [
        patientId,
        hypertension,
        diabetes,
        heartDisease,
        stroke,
        asthma,
        epilepsy,
        copd,
        palpitations,
        otherMedicalHistory,
      ];
}
