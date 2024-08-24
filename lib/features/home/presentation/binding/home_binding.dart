import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_health_record_usecase.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_home_examination_package_usecase.dart';
import 'package:medi_express_patients/features/home/domain/usecases/upload_patient_usecase.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(
          getAllHealthRecordUsecase: Get.find<GetAllHealthRecordUsecase>(),
          uploadPatientUsecase: Get.find<UploadPatientUsecase>(),
          getAllHomeExaminationPackageUsecase:
              Get.find<GetAllHomeExaminationPackageUsecase>(),
          errorHandlingService: Get.find<ErrorHandlingService>(),
        ));
  }
}
