import 'dart:io';

import 'package:get/get.dart';
import 'package:medi_express_patients/features/account/domain/entities/acid_uric_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/blood_pressure_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/blood_sugar_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/health_metricts_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/heart_rate_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/height_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/spo2_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/temperature_detail_entity.dart';
import 'package:medi_express_patients/features/account/domain/entities/weight_detail_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';

enum TypeMeasuringDeviceLink {
  homeKit6In1,
  skinTest,
  lungMeasurement,
}

class AccountState extends BaseState {
  var listAllCity = <CityEntity>[].obs;
  var listAllDistrict = <DistrictEntity>[].obs;
  var listAllWard = <WardEntity>[].obs;

  var city = Rxn<CityEntity>();
  var district = Rxn<DistrictEntity>();
  var ward = Rxn<WardEntity>();
  var selectedGender = ''.obs;

  var errorDateInput = ''.obs;
  var errorValueInput = ''.obs;

  var selectedTypeMeasuringDeviceLink = TypeMeasuringDeviceLink.homeKit6In1.obs;

  var imageFile = Rx<File?>(null);

  var healthMetricts = HealthMetricsEntity(
    patientId: -1,
    blood: null,
    height: null,
    weight: null,
    acidUric: AcidUricEntity(
      createdAt: '',
      acidUric: '',
    ),
    bloodPressure: BloodPressureEntity(
      dystolicBloodPressure: '',
      systolicBloodPressure: '',
      createdAt: '',
    ),
    bloodSugar: BloodSugarEntity(
      createdAt: '',
      bloodSugarAfterMeal: '',
      bloodSugarBeforeMeal: '',
    ),
    heartRate: HeartRateEntity(
      createdAt: '',
      value: '',
    ),
    spO2: Spo2Entity(
      value: '',
      createdAt: '',
    ),
    temperature: TemperatureEntity(
      createdAt: '',
      value: '',
    ),
  ).obs;

  var listHeightDetail = <HeightDetailEntity>[].obs;
  var listWeightDetail = <WeightDetailEntity>[].obs;
  var listTemptDetail = <TemperatureDetailEntity>[].obs;
  var listHeartbeatDetail = <HeartRateDetailEntity>[].obs;
  var listBloodPressureDetail = <BloodPressureDetailEntity>[].obs;
  var listBloodSugarDetail = <BloodSugarDetailEntity>[].obs;
  var listSpo2Detail = <Spo2DetailEntity>[].obs;
  var listAcidUricDetail = <AcidUricDetailEntity>[].obs;
}
