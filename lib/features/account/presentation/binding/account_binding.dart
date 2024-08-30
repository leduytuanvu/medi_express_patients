import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_health_metricts_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_list_acid_uric_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_list_blood_pressure_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_list_blood_sugar_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_list_heart_rate_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_list_height_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_list_spo2_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_list_temperature_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_list_weight_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/update_height_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/update_user_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/update_weight_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/upload_avatar_usecase.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController(
          uploadAvatarUsecase: Get.find<UploadAvatarUsecase>(),
          getHealthMetrictsUsecase: Get.find<GetHealthMetrictsUsecase>(),
          getListHeightUsecase: Get.find<GetListHeightUsecase>(),
          getListAcidUricUsecase: Get.find<GetListAcidUricUsecase>(),
          getListWeightUsecase: Get.find<GetListWeightUsecase>(),
          getListTemperatureUsecase: Get.find<GetListTemperatureUsecase>(),
          getListHeartRateUsecase: Get.find<GetListHeartRateUsecase>(),
          getListBloodSugarUsecase: Get.find<GetListBloodSugarUsecase>(),
          getListBloodPressureUsecase: Get.find<GetListBloodPressureUsecase>(),
          getListSpo2Usecase: Get.find<GetListSpo2Usecase>(),
          updateUserUsecase: Get.find<UpdateUserUsecase>(),
          updateHeightUsecase: Get.find<UpdateHeightUsecase>(),
          updateWeightUsecase: Get.find<UpdateWeightUsecase>(),
          errorHandlingService: Get.find<ErrorHandlingService>(),
        ));
  }
}
