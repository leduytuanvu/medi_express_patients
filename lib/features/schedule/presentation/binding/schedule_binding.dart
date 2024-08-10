import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/create_appointment_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_all_schedule_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_schedule_result_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_type_create_appointment_service_usecase.dart';
import 'package:medi_express_patients/features/schedule/presentation/controller/schedule_controller.dart';

class ScheduleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ScheduleController(
          getAllScheduleUsecase: Get.find<GetAllScheduleUsecase>(),
          getScheduleResultUsecase: Get.find<GetScheduleResultUsecase>(),
          createAppointmentUsecase: Get.find<CreateAppointmentUsecase>(),
          getTypeCreateAppointmentServiceUsecase:
              Get.find<GetTypeCreateAppointmentServiceUsecase>(),
          errorHandlingService: Get.find<ErrorHandlingService>(),
        ));
  }
}
