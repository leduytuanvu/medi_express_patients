import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/check_phone_number_exists_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/create_medical_history_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_all_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_auth_from_local_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_district_by_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_language_from_local_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_user_information_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_ward_by_district_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/register_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/save_auth_to_local_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/save_language_usecase.dart';

import '../../domain/usecases/login_usecase.dart';
import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController(
          loginUsecase: Get.find<LoginUsecase>(),
          saveLanguageUsecase: Get.find<SaveLanguageUsecase>(),
          getLanguageFromLocalUsecase: Get.find<GetLanguageFromLocalUsecase>(),
          forgotPasswordUsecase: Get.find<ForgotPasswordUsecase>(),
          registerUsecase: Get.find<RegisterUsecase>(),
          changePasswordUsecase: Get.find<ChangePasswordUsecase>(),
          getAllCityUsecase: Get.find<GetAllCityUsecase>(),
          errorHandlingService: Get.find<ErrorHandlingService>(),
          getDistrictByCityUsecase: Get.find<GetDistrictByCityUsecase>(),
          getWardByDistrictUsecase: Get.find<GetWardByDistrictUsecase>(),
          createMedicalHistoryUsecase: Get.find<CreateMedicalHistoryUsecase>(),
          getAuthFromLocalUsecase: Get.find<GetAuthFromLocalUsecase>(),
          saveAuthToLocalUsecase: Get.find<SaveAuthToLocalUsecase>(),
          checkPhoneNumberExistsUsecase:
              Get.find<CheckPhoneNumberExistsUsecase>(),
          getUserInformationUsecase: Get.find<GetUserInformationUsecase>(),
        ));
  }
}
