import 'package:get/get.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';

class AuthState extends BaseState {
  var verificationId = ''.obs;
  var errorPhoneLogin = ''.obs;
  var errorPhoneForgotPassword = ''.obs;
  var errorPhoneRegister = ''.obs;
  var errorVerifyCodeForgotPassword = ''.obs;
  var errorVerifyCodeRegister = ''.obs;
  var errorPasswordLogin = ''.obs;
  var errorPasswordRegister = ''.obs;
  var errorPasswordForgotPassword = ''.obs;
  var errorRePasswordForgotPassword = ''.obs;
  var errorRePasswordRegister = ''.obs;
  var errorFullName = ''.obs;
  var errorEmail = ''.obs;
  var errorBirthdate = ''.obs;
  var errorGender = ''.obs;
  var errorCity = ''.obs;
  var errorDistrict = ''.obs;
  var errorWard = ''.obs;
  var errorAddress = ''.obs;
  var errorBhyt = ''.obs;

  var listAllCity = <CityEntity>[].obs;
  var listAllDistrict = <DistrictEntity>[].obs;
  var listAllWard = <WardEntity>[].obs;
  var listGender = <String>['Nữ', 'Nam'].obs;

  var hypertension = false.obs;
  var diabetes = false.obs;
  var heartDisease = false.obs;
  var stroke = false.obs;
  var asthma = false.obs;
  var epilepsy = false.obs;
  var copd = false.obs;
  var palpitations = false.obs;
  var otherMedicalHistory = ''.obs;
  var timeoutConfirmVerifyCode = 30.obs;
  var wardId = 0.obs;
  var genderId = 0.obs;
  var verifyCode = 0.obs;
}
