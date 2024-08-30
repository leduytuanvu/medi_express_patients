import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';

class HealthMetricsDto {
  final int patientId;
  final AcidUricDto? acidUric;
  final BloodPressureDto? bloodPressure;
  final BloodSugarDto? bloodSugar;
  final HeartRateDto? heartRate;
  final Spo2Dto? spO2;
  final TemperatureDto? temperature;
  final BloodDto? blood;
  final HeightDto? height;
  final WeightDto? weight;

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
      patientId: json['patientId'] ?? 0,
      acidUric: json['acidUric'] != null
          ? AcidUricDto.fromJson(json['acidUric'])
          : null,
      bloodPressure: json['bloodPressure'] != null
          ? BloodPressureDto.fromJson(json['bloodPressure'])
          : null,
      bloodSugar: json['bloodSugar'] != null
          ? BloodSugarDto.fromJson(json['bloodSugar'])
          : null,
      heartRate: json['heartRate'] != null
          ? HeartRateDto.fromJson(json['heartRate'])
          : null,
      spO2: json['spO2'] != null ? Spo2Dto.fromJson(json['spO2']) : null,
      temperature: json['temperature'] != null
          ? TemperatureDto.fromJson(json['temperature'])
          : null,
      blood: json['blood'] != null ? BloodDto.fromJson(json['blood']) : null,
      height:
          json['height'] != null ? HeightDto.fromJson(json['height']) : null,
      weight:
          json['weight'] != null ? WeightDto.fromJson(json['weight']) : null,
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
      'blood': blood?.toJson(),
      'height': height?.toJson(),
      'weight': weight?.toJson(),
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
      blood: blood?.toEntity(),
      height: height?.toEntity(),
      weight: weight?.toEntity(),
    );
  }

  @override
  String toString() {
    return 'HealthMetricsDto(patientId: $patientId, acidUric: $acidUric, bloodPressure: $bloodPressure, bloodSugar: $bloodSugar, heartRate: $heartRate, spO2: $spO2, temperature: $temperature, blood: $blood, height: $height, weight: $weight)';
  }
}

class AcidUricDto {
  final String? acidUric;
  final String? createdAt;

  AcidUricDto({
    this.acidUric,
    this.createdAt,
  });

  factory AcidUricDto.fromJson(Map<String, dynamic> json) {
    return AcidUricDto(
      acidUric: json['AcidUric'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AcidUric': acidUric ?? '',
      'createdAt': createdAt ?? '',
    };
  }

  AcidUricEntity toEntity() {
    return AcidUricEntity(
      acidUric: acidUric ?? '',
      createdAt: createdAt ?? '',
    );
  }

  @override
  String toString() {
    return 'AcidUricDto(acidUric: $acidUric, createdAt: $createdAt)';
  }
}

class BloodPressureDto {
  final String? dystolicBloodPressure;
  final String? systolicBloodPressure;
  final String? createdAt;

  BloodPressureDto({
    this.dystolicBloodPressure,
    this.systolicBloodPressure,
    this.createdAt,
  });

  factory BloodPressureDto.fromJson(Map<String, dynamic> json) {
    return BloodPressureDto(
      dystolicBloodPressure: json['DystolicBloodPressure'] ?? '',
      systolicBloodPressure: json['SystolicBloodPressure'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DystolicBloodPressure': dystolicBloodPressure ?? '',
      'SystolicBloodPressure': systolicBloodPressure ?? '',
      'createdAt': createdAt ?? '',
    };
  }

  BloodPressureEntity toEntity() {
    return BloodPressureEntity(
      dystolicBloodPressure: dystolicBloodPressure ?? '',
      systolicBloodPressure: systolicBloodPressure ?? '',
      createdAt: createdAt ?? '',
    );
  }

  @override
  String toString() {
    return 'BloodPressureDto(dystolicBloodPressure: $dystolicBloodPressure, systolicBloodPressure: $systolicBloodPressure, createdAt: $createdAt)';
  }
}

class BloodSugarDto {
  final String? bloodSugarAfterMeal;
  final String? bloodSugarBeforeMeal;
  final String? createdAt;

  BloodSugarDto({
    this.bloodSugarAfterMeal,
    this.bloodSugarBeforeMeal,
    this.createdAt,
  });

  factory BloodSugarDto.fromJson(Map<String, dynamic> json) {
    return BloodSugarDto(
      bloodSugarAfterMeal: json['BloodSugarAfterMeal'] ?? '',
      bloodSugarBeforeMeal: json['BloodSugarBeforeMeal'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BloodSugarAfterMeal': bloodSugarAfterMeal ?? '',
      'BloodSugarBeforeMeal': bloodSugarBeforeMeal ?? '',
      'createdAt': createdAt ?? '',
    };
  }

  BloodSugarEntity toEntity() {
    return BloodSugarEntity(
      bloodSugarAfterMeal: bloodSugarAfterMeal ?? '',
      bloodSugarBeforeMeal: bloodSugarBeforeMeal ?? '',
      createdAt: createdAt ?? '',
    );
  }

  @override
  String toString() {
    return 'BloodSugarDto(bloodSugarAfterMeal: $bloodSugarAfterMeal, bloodSugarBeforeMeal: $bloodSugarBeforeMeal, createdAt: $createdAt)';
  }
}

class BloodDto {
  final int? id;
  final int? patientId;
  final String? bloodGroup;
  final String? createAt;
  final String? updateAt;

  BloodDto({
    this.id,
    this.patientId,
    this.bloodGroup,
    this.createAt,
    this.updateAt,
  });

  factory BloodDto.fromJson(Map<String, dynamic> json) {
    return BloodDto(
      id: json['id'] ?? -1,
      patientId: json['PatientID'] ?? -1,
      bloodGroup: json['BloodGroup'] ?? '',
      createAt: json['createAt'] ?? '',
      updateAt: json['updateAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? -1,
      'PatientID': patientId ?? -1,
      'BloodGroup': bloodGroup ?? '',
      'createAt': createAt ?? '',
      'updateAt': updateAt ?? '',
    };
  }

  BloodEntity toEntity() {
    return BloodEntity(
      id: id ?? -1,
      patientId: patientId ?? -1,
      bloodGroup: bloodGroup ?? '',
      createAt: createAt ?? '',
      updateAt: updateAt ?? '',
    );
  }

  @override
  String toString() {
    return 'BloodDto(id: $id, patientId: $patientId, bloodGroup: $bloodGroup, createAt: $createAt, updateAt: $updateAt)';
  }
}

class HeartRateDto {
  final String? heartRate;
  final String? createdAt;

  HeartRateDto({
    this.heartRate,
    this.createdAt,
  });

  factory HeartRateDto.fromJson(Map<String, dynamic> json) {
    return HeartRateDto(
      heartRate: json['HeartRate'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'HeartRate': heartRate ?? '',
      'createdAt': createdAt ?? '',
    };
  }

  HeartRateEntity toEntity() {
    return HeartRateEntity(
      value: heartRate ?? '',
      createdAt: createdAt ?? '',
    );
  }

  @override
  String toString() {
    return 'HeartRateDto(heartRate: $heartRate, createdAt: $createdAt)';
  }
}

class Spo2Dto {
  final String? spO2;
  final String? createdAt;

  Spo2Dto({
    this.spO2,
    this.createdAt,
  });

  factory Spo2Dto.fromJson(Map<String, dynamic> json) {
    return Spo2Dto(
      spO2: json['SpO2'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'SpO2': spO2 ?? '',
      'createdAt': createdAt ?? '',
    };
  }

  Spo2Entity toEntity() {
    return Spo2Entity(
      value: spO2 ?? '',
      createdAt: createdAt ?? '',
    );
  }

  @override
  String toString() {
    return 'Spo2Dto(spO2: $spO2, createdAt: $createdAt)';
  }
}

class TemperatureDto {
  final String? temperatureDto;
  final String? createdAt;

  TemperatureDto({
    this.temperatureDto,
    this.createdAt,
  });

  factory TemperatureDto.fromJson(Map<String, dynamic> json) {
    return TemperatureDto(
      temperatureDto: json['Temperature'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Temperature': temperatureDto ?? '',
      'createdAt': createdAt ?? '',
    };
  }

  TemperatureEntity toEntity() {
    return TemperatureEntity(
      value: temperatureDto ?? '',
      createdAt: createdAt ?? '',
    );
  }

  @override
  String toString() {
    return 'TemperatureDto(temperatureDto: $temperatureDto, createdAt: $createdAt)';
  }
}

class HeightDto {
  final String? height;
  final String? createdAt;

  HeightDto({
    this.height,
    this.createdAt,
  });

  factory HeightDto.fromJson(Map<String, dynamic> json) {
    return HeightDto(
      height: json['Height'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Height': height ?? '',
      'createdAt': createdAt ?? '',
    };
  }

  HeightEntity toEntity() {
    return HeightEntity(
      value: height ??
          '', // height is a String here, but we convert it to Rx<String> in the constructor
      createdAt: createdAt ?? '', // Same for createdAt
    );
  }

  @override
  String toString() {
    return 'HeightDto(height: $height, createdAt: $createdAt)';
  }
}

class WeightDto {
  final String? weight;
  final String? createdAt;

  WeightDto({
    this.weight,
    this.createdAt,
  });

  factory WeightDto.fromJson(Map<String, dynamic> json) {
    return WeightDto(
      weight: json['Weight'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Weight': weight ?? '',
      'createdAt': createdAt ?? '',
    };
  }

  WeightEntity toEntity() {
    return WeightEntity(
      value: weight ?? '',
      createdAt: createdAt ?? '',
    );
  }

  @override
  String toString() {
    return 'WeightDto(weight: $weight, createdAt: $createdAt)';
  }
}
