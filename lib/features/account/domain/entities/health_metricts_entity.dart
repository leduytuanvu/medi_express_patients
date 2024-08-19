class HealthMetricsEntity {
  final int patientId;
  final HealthMetricEntity? acidUric;
  final HealthMetricEntity? bloodPressure;
  final BloodSugarEntity? bloodSugar;
  final HealthMetricEntity? heartRate;
  final HealthMetricEntity? spO2;
  final HealthMetricEntity? temperature;
  final dynamic blood; // This can be of any type, so using dynamic
  final dynamic height; // This can be of any type, so using dynamic
  final dynamic weight; // This can be of any type, so using dynamic

  HealthMetricsEntity({
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
}

class HealthMetricEntity {
  final String value;
  final String createdAt;

  HealthMetricEntity({
    required this.value,
    required this.createdAt,
  });
}

class BloodSugarEntity {
  final String bloodSugarAfterMeal;
  final String bloodSugarBeforeMeal;
  final String createdAt;

  BloodSugarEntity({
    required this.bloodSugarAfterMeal,
    required this.bloodSugarBeforeMeal,
    required this.createdAt,
  });
}
