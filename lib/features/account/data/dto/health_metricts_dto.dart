import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';

class HealthMetricsDto {
  final int patientId;
  final HealthMetricDto? acidUric;
  final HealthMetricDto? bloodPressure;
  final BloodSugarDto? bloodSugar;
  final HealthMetricDto? heartRate;
  final HealthMetricDto? spO2;
  final HealthMetricDto? temperature;
  final dynamic blood; // This can be of any type, so using dynamic
  final dynamic height; // This can be of any type, so using dynamic
  final dynamic weight; // This can be of any type, so using dynamic

  HealthMetricsDto({
    required this.patientId,
    this.acidUric,
    this.bloodPressure,
    this.bloodSugar,
    this.heartRate,
    this.spO2,
    this.temperature,
    this.blood,
    this.height,
    this.weight,
  });

  factory HealthMetricsDto.fromJson(Map<String, dynamic> json) {
    return HealthMetricsDto(
      patientId: json['patientId'],
      acidUric: json['acidUric'] != null
          ? HealthMetricDto.fromJson(json['acidUric'])
          : null,
      bloodPressure: json['bloodPressure'] != null
          ? HealthMetricDto.fromJson(json['bloodPressure'])
          : null,
      bloodSugar: json['bloodSugar'] != null
          ? BloodSugarDto.fromJson(json['bloodSugar'])
          : null,
      heartRate: json['heartRate'] != null
          ? HealthMetricDto.fromJson(json['heartRate'])
          : null,
      spO2:
          json['spO2'] != null ? HealthMetricDto.fromJson(json['spO2']) : null,
      temperature: json['temperature'] != null
          ? HealthMetricDto.fromJson(json['temperature'])
          : null,
      blood: json[
          'blood'], // Dynamic types should be handled according to the expected data type
      height: json[
          'height'], // Dynamic types should be handled according to the expected data type
      weight: json[
          'weight'], // Dynamic types should be handled according to the expected data type
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'patientId': patientId,
      'acidUric': acidUric?.toJson(),
      'bloodPressure': bloodPressure?.toJson(),
      'bloodSugar': bloodSugar?.toJson(),
      'heartRate': heartRate?.toJson(),
      'spO2': spO2?.toJson(),
      'temperature': temperature?.toJson(),
      'blood': blood,
      'height': height,
      'weight': weight,
    };
  }

  HealthMetricsEntity toEntity() {
    return HealthMetricsEntity(
      patientId: patientId,
      acidUric: acidUric?.toEntity(),
      bloodPressure: bloodPressure?.toEntity(),
      bloodSugar: bloodSugar?.toEntity(),
      heartRate: heartRate?.toEntity(),
      spO2: spO2?.toEntity(),
      temperature: temperature?.toEntity(),
      blood: blood,
      height: height,
      weight: weight,
    );
  }
}

class HealthMetricDto {
  final String value;
  final String createdAt;

  HealthMetricDto({
    required this.value,
    required this.createdAt,
  });

  factory HealthMetricDto.fromJson(Map<String, dynamic> json) {
    return HealthMetricDto(
      value: json.values.first,
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'createdAt': createdAt,
    };
  }

  HealthMetricEntity toEntity() {
    return HealthMetricEntity(
      value: value,
      createdAt: createdAt,
    );
  }
}

class BloodSugarDto {
  final String bloodSugarAfterMeal;
  final String bloodSugarBeforeMeal;
  final String createdAt;

  BloodSugarDto({
    required this.bloodSugarAfterMeal,
    required this.bloodSugarBeforeMeal,
    required this.createdAt,
  });

  factory BloodSugarDto.fromJson(Map<String, dynamic> json) {
    return BloodSugarDto(
      bloodSugarAfterMeal: json['BloodSugarAfterMeal'],
      bloodSugarBeforeMeal: json['BloodSugarBeforeMeal'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BloodSugarAfterMeal': bloodSugarAfterMeal,
      'BloodSugarBeforeMeal': bloodSugarBeforeMeal,
      'createdAt': createdAt,
    };
  }

  BloodSugarEntity toEntity() {
    return BloodSugarEntity(
      bloodSugarAfterMeal: bloodSugarAfterMeal,
      bloodSugarBeforeMeal: bloodSugarBeforeMeal,
      createdAt: createdAt,
    );
  }
}
