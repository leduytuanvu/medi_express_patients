import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/create_medical_history_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_all_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_district_by_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_ward_by_district_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/register_usecase.dart';
import 'package:medi_express_patients/features/doctor/presentation/controller/doctor_controller.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';
import 'package:medi_express_patients/features/schedule/presentation/controller/schedule_controller.dart';

class DoctorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DoctorController(
          errorHandlingService: Get.find<ErrorHandlingService>(),
        ));
  }
}
