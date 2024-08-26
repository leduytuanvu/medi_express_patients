class HealthMetricsEntity {
  final int patientId;
  final AcidUricEntity? acidUric;
  final BloodPressureEntity? bloodPressure;
  final BloodSugarEntity? bloodSugar;
  final HeartRateEntity? heartRate;
  final Spo2Entity? spO2;
  final TemperatureEntity? temperature;
  final BloodEntity? blood;
  final HeightEntity? height;
  final WeightEntity? weight;

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

  @override
  String toString() {
    return 'HealthMetricsEntity(patientId: $patientId, acidUric: $acidUric, bloodPressure: $bloodPressure, bloodSugar: $bloodSugar, heartRate: $heartRate, spO2: $spO2, temperature: $temperature, blood: $blood, height: $height, weight: $weight)';
  }
}

class AcidUricEntity {
  final String acidUric;
  final String createdAt;

  AcidUricEntity({
    required this.acidUric,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'AcidUricEntity(acidUric: $acidUric, createdAt: $createdAt)';
  }
}

class BloodPressureEntity {
  final String dystolicBloodPressure;
  final String systolicBloodPressure;
  final String createdAt;

  BloodPressureEntity({
    required this.dystolicBloodPressure,
    required this.systolicBloodPressure,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'BloodPressureEntity(dystolicBloodPressure: $dystolicBloodPressure, systolicBloodPressure: $systolicBloodPressure, createdAt: $createdAt)';
  }
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

  @override
  String toString() {
    return 'BloodSugarEntity(bloodSugarAfterMeal: $bloodSugarAfterMeal, bloodSugarBeforeMeal: $bloodSugarBeforeMeal, createdAt: $createdAt)';
  }
}

class BloodEntity {
  final int id;
  final int patientId;
  final String bloodGroup;
  final String createAt;
  final String updateAt;

  BloodEntity({
    required this.id,
    required this.patientId,
    required this.bloodGroup,
    required this.createAt,
    required this.updateAt,
  });

  @override
  String toString() {
    return 'BloodEntity(id: $id, patientId: $patientId, bloodGroup: $bloodGroup, createAt: $createAt, updateAt: $updateAt)';
  }
}

class HeartRateEntity {
  final String value;
  final String createdAt;

  HeartRateEntity({
    required this.value,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'HeartRateEntity(value: $value, createdAt: $createdAt)';
  }
}

class Spo2Entity {
  final String value;
  final String createdAt;

  Spo2Entity({
    required this.value,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Spo2Entity(value: $value, createdAt: $createdAt)';
  }
}

class TemperatureEntity {
  final String value;
  final String createdAt;

  TemperatureEntity({
    required this.value,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'TemperatureEntity(value: $value, createdAt: $createdAt)';
  }
}

class HeightEntity {
  final String value;
  final String createdAt;

  HeightEntity({
    required this.value,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'HeightEntity(value: $value, createdAt: $createdAt)';
  }
}

class WeightEntity {
  final String value;
  final String createdAt;

  WeightEntity({
    required this.value,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'WeightEntity(value: $value, createdAt: $createdAt)';
  }
}
