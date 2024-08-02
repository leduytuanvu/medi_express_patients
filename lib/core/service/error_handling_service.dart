import 'package:get/get.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';

class ErrorHandlingService {
  void handleException(Failure failure) {
    // Check if failure.message is null
    final BaseController baseController = Get.find<BaseController>();
    final message = failure.message;
    baseController.showError(
      () {
        // context.backScreen();
        baseController.clearError();
      },
      failure.message,
      'Quay lại',
    );
  }
}
