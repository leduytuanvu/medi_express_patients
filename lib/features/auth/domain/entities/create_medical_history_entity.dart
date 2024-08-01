class CreateMedicalHistoryEntity {
  final int id;
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

  CreateMedicalHistoryEntity({
    required this.id,
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
}
