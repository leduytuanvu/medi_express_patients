import 'package:get/get.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';

class AccountState extends BaseState {
  var listAllCity = <CityEntity>[].obs;
  var listAllDistrict = <DistrictEntity>[].obs;
  var listAllWard = <WardEntity>[].obs;
  var city = CityEntity(id: -1, name: '').obs;
  var ward = WardEntity(
    id: -1,
    districtId: -1,
    wardName: '',
  ).obs;
  var district = DistrictEntity(
    id: -1,
    cityId: -1,
    districtName: '',
  ).obs;
}
