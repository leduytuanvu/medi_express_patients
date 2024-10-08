import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
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
import 'package:medi_express_patients/features/account/presentation/page/account_page.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_message_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_message_usecase.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';
import 'package:medi_express_patients/features/chat/presentation/page/chat_page.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/create_appointment_id_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_all_information_doctor_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_by_name_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_information_detail_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_type_create_appointment_service_usecase.dart';
import 'package:medi_express_patients/features/doctor/presentation/controller/doctor_controller.dart';
import 'package:medi_express_patients/features/doctor/presentation/page/doctor_page.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_health_record_usecase.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_home_examination_package_usecase.dart';
import 'package:medi_express_patients/features/home/domain/usecases/upload_patient_usecase.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/features/home/presentation/page/home_page.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/create_appointment_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_all_schedule_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_schedule_result_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_type_create_appointment_service_usecase.dart';
import 'package:medi_express_patients/features/schedule/presentation/controller/schedule_controller.dart';
import 'package:medi_express_patients/features/schedule/presentation/page/schedule_page.dart';

class MainPage extends BaseStatelessWidget {
  MainPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    final MainController mainController = Get.find<MainController>();
    // final ChatController chatController = Get.find<ChatController>();
    // chatController.connectSocket();
    return Scaffold(
      backgroundColor: Colors.white,
      body: PageView(
        controller: mainController.pageController,
        onPageChanged: (index) {
          mainController.changePage(index);
        },
        children: [
          GetBuilder<HomeController>(
            init: HomeController(
              getAllHealthRecordUsecase: Get.find<GetAllHealthRecordUsecase>(),
              uploadPatientUsecase: Get.find<UploadPatientUsecase>(),
              getAllHomeExaminationPackageUsecase:
                  Get.find<GetAllHomeExaminationPackageUsecase>(),
              errorHandlingService: ErrorHandlingService(),
            ),
            builder: (controller) => HomePage(),
          ),
          GetBuilder<DoctorController>(
            init: DoctorController(
              getAllInformationDoctorUsecase:
                  Get.find<GetAllInformationDoctorUsecase>(),
              getDoctorByNameUsecase: Get.find<GetDoctorByNameUsecase>(),
              getDoctorInformationDetailUsecase:
                  Get.find<GetDoctorInformationDetailUsecase>(),
              getTypeCreateAppointmentServiceUsecase:
                  Get.find<GetTypeCreateAppointmentServiceIdUsecase>(),
              createAppointmentUsecase: Get.find<CreateAppointmentIdUsecase>(),
              errorHandlingService: ErrorHandlingService(),
            ),
            builder: (controller) => DoctorPage(),
          ),
          GetBuilder<ScheduleController>(
            init: ScheduleController(
                getAllScheduleUsecase: Get.find<GetAllScheduleUsecase>(),
                createAppointmentUsecase: Get.find<CreateAppointmentUsecase>(),
                getTypeCreateAppointmentServiceUsecase:
                    Get.find<GetTypeCreateAppointmentServiceUsecase>(),
                getScheduleResultUsecase: Get.find<GetScheduleResultUsecase>(),
                errorHandlingService: ErrorHandlingService()),
            builder: (controller) => SchedulePage(),
          ),
          GetBuilder<ChatController>(
            init: ChatController(
                getAllConversationUsecase:
                    Get.find<GetAllConversationUsecase>(),
                getAllMessageUsecase: Get.find<GetAllMessageUsecase>(),
                createMessageUsecase: Get.find<CreateMessageUsecase>(),
                createConversationUsecase:
                    Get.find<CreateConversationUsecase>(),
                errorHandlingService: ErrorHandlingService()),
            builder: (controller) => ChatPage(),
          ),
          GetBuilder<AccountController>(
            init: AccountController(
              getHealthMetrictsUsecase: Get.find<GetHealthMetrictsUsecase>(),
              getListHeightUsecase: Get.find<GetListHeightUsecase>(),
              getListAcidUricUsecase: Get.find<GetListAcidUricUsecase>(),
              getListWeightUsecase: Get.find<GetListWeightUsecase>(),
              getListTemperatureUsecase: Get.find<GetListTemperatureUsecase>(),
              getListHeartRateUsecase: Get.find<GetListHeartRateUsecase>(),
              getListBloodSugarUsecase: Get.find<GetListBloodSugarUsecase>(),
              getListBloodPressureUsecase:
                  Get.find<GetListBloodPressureUsecase>(),
              getListSpo2Usecase: Get.find<GetListSpo2Usecase>(),
              uploadAvatarUsecase: Get.find<UploadAvatarUsecase>(),
              updateUserUsecase: Get.find<UpdateUserUsecase>(),
              updateWeightUsecase: Get.find<UpdateWeightUsecase>(),
              updateHeightUsecase: Get.find<UpdateHeightUsecase>(),
              errorHandlingService: ErrorHandlingService(),
            ),
            builder: (controller) => AccountPage(),
          ),
        ],
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: mainController.mainState.currentIndex.value,
          onTap: (index) {
            mainController.changePage(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.home,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 0
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'home'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.doctor,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 1
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'doctor'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.calender,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 2
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'schedule'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.chat,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 3
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'chat'.tr,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                Assets.svg.account,
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  mainController.mainState.currentIndex.value == 4
                      ? const Color(0xfffcf4375)
                      : Colors.grey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'account'.tr,
            ),
          ],
          backgroundColor: Colors.white,
          selectedItemColor:
              const Color(0xfffcf4375), // Color for selected item
          unselectedItemColor: Colors.grey, // Color for unselected items
          selectedLabelStyle: const TextStyle(
            fontSize: 14.0, // Text size for selected item
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 14.0, // Text size for unselected item
          ),
          type: BottomNavigationBarType
              .fixed, // Use fixed to avoid animation on tap
        );
      }),
    );
  }
}
