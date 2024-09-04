import 'package:get/get.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';

class ErrorHandlingService {
  void handleException(Failure failure) {
    // Check if failure.message is null
    final AuthController authController = Get.find<AuthController>();
    final message = failure.message;
    authController.showError(
      () {
        // context.backScreen();
        authController.clearError();
      },
      failure.message,
      'come_back'.tr,
    );
  }
}
