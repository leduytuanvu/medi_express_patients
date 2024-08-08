import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_all_information_doctor_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_by_name_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_information_detail_usecase.dart';
import 'package:medi_express_patients/features/doctor/presentation/controller/doctor_controller.dart';

class DoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorController(
          getAllInformationDoctorUsecase:
              Get.find<GetAllInformationDoctorUsecase>(),
          getDoctorInformationDetailUsecase:
              Get.find<GetDoctorInformationDetailUsecase>(),
          getDoctorByNameUsecase: Get.find<GetDoctorByNameUsecase>(),
          errorHandlingService: Get.find<ErrorHandlingService>(),
        ));
  }
}
