import 'package:medi_express_patients/features/auth/domain/entities/create_medical_history_entity.dart';

class CreateMedicalHistoryDto {
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
  final String updatedAt;
  final String createdAt;

  CreateMedicalHistoryDto({
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
    required this.createdAt,
    required this.updatedAt,
  });

  factory CreateMedicalHistoryDto.fromJson(Map<String, dynamic> json) {
    return CreateMedicalHistoryDto(
      id: json['id'],
      patientId: json['PatientID'],
      hypertension: json['Hypertension'],
      diabetes: json['Diabetes'],
      heartDisease: json['HeartDisease'],
      stroke: json['Stroke'],
      asthma: json['Asthma'],
      epilepsy: json['Epilepsy'],
      copd: json['COPD'],
      palpitations: json['Palpitations'],
      otherMedicalHistory: json['OtherMedicalHistory'],
      createdAt: json['updatedAt'],
      updatedAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'PatientID': patientId,
      'Hypertension': hypertension,
      'Diabetes': diabetes,
      'HeartDisease': heartDisease,
      'Stroke': stroke,
      'Asthma': asthma,
      'Epilepsy': epilepsy,
      'COPD': copd,
      'Palpitations': palpitations,
      'OtherMedicalHistory': otherMedicalHistory,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
    };
  }

  CreateMedicalHistoryEntity toEntity() {
    return CreateMedicalHistoryEntity(
      id: id,
      patientId: patientId,
      hypertension: hypertension,
      diabetes: diabetes,
      heartDisease: heartDisease,
      stroke: stroke,
      asthma: asthma,
      epilepsy: epilepsy,
      copd: copd,
      palpitations: palpitations,
      otherMedicalHistory: otherMedicalHistory,
    );
  }
}
