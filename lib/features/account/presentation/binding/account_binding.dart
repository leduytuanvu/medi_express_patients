import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_health_metricts_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/upload_avatar_usecase.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';

class AccountBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AccountController(
          getHealthMetrictsUsecase: Get.find<GetHealthMetrictsUsecase>(),
          uploadAvatarUsecase: Get.find<UploadAvatarUsecase>(),
          errorHandlingService: Get.find<ErrorHandlingService>(),
        ));
  }
}
