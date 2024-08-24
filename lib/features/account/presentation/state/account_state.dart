import 'dart:io';

import 'package:get/get.dart';
import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';

class AccountState extends BaseState {
  var listAllCity = <CityEntity>[].obs;
  var listAllDistrict = <DistrictEntity>[].obs;
  var listAllWard = <WardEntity>[].obs;

  var city = Rxn<CityEntity>();
  var district = Rxn<DistrictEntity>();
  var ward = Rxn<WardEntity>();
  var selectedGender = ''.obs;

  var imageFile = Rx<File?>(null);

  var healthMetricts = HealthMetricsEntity(
    patientId: -1,
    blood: null,
    height: null,
    weight: null,
    acidUric: HealthMetricEntity(
      createdAt: '',
      value: '',
    ),
    bloodPressure: HealthMetricEntity(
      value: '',
      createdAt: '',
    ),
    bloodSugar: BloodSugarEntity(
      createdAt: '',
      bloodSugarAfterMeal: '',
      bloodSugarBeforeMeal: '',
    ),
    heartRate: HealthMetricEntity(
      createdAt: '',
      value: '',
    ),
    spO2: HealthMetricEntity(
      value: '',
      createdAt: '',
    ),
    temperature: HealthMetricEntity(
      createdAt: '',
      value: '',
    ),
  ).obs;
}
