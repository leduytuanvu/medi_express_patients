import 'package:get/get.dart';
import 'package:medi_express_patients/features/account/presentation/binding/account_binding.dart';
import 'package:medi_express_patients/features/account/presentation/page/account_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/blood_pressure_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/blood_sugar_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/change_password_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/health_index_measurement_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/health_index_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/heartbeat_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/height_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/helper_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/language_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/measurement_results_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/measuring_device_link_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/personal_information_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/settings_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/spo2_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/temp_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/ua_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/update_height_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/update_weight_page.dart';
import 'package:medi_express_patients/features/account/presentation/page/weight_page.dart';
import 'package:medi_express_patients/features/auth/presentation/binding/auth_binding.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/forgot_password/enter_password_forgot_password_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/forgot_password/enter_phone_number_forgot_password_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/forgot_password/enter_verify_code_forgot_password_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/intro/intro_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/login/login_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/register/enter_anamnesis_register_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/register/enter_information_register_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/register/enter_password_register_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/register/enter_phone_number_register_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/register/enter_verify_code_register_page.dart';
import 'package:medi_express_patients/features/chat/presentation/binding/chat_binding.dart';
import 'package:medi_express_patients/features/chat/presentation/page/chat_detail_page.dart';
import 'package:medi_express_patients/features/chat/presentation/page/chat_page.dart';
import 'package:medi_express_patients/features/doctor/presentation/binding/doctor_binding.dart';
import 'package:medi_express_patients/features/doctor/presentation/page/book_schedule_id_page.dart';
import 'package:medi_express_patients/features/doctor/presentation/page/doctor_detail_page.dart';
import 'package:medi_express_patients/features/doctor/presentation/page/doctor_page.dart';
import 'package:medi_express_patients/features/home/presentation/binding/home_binding.dart';
import 'package:medi_express_patients/features/home/presentation/page/diagnostic_imaging_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/health_record_detail_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/health_record_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/home_health_package_detail_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/home_health_package_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/home_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/medical_services_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/news_detail_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/news_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/notification_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/prescription_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/testing_page.dart';
import 'package:medi_express_patients/features/home/presentation/page/vaccination_page.dart';
import 'package:medi_express_patients/features/main/presentation/binding/main_binding.dart';
import 'package:medi_express_patients/features/main/presentation/page/main_page.dart';
import 'package:medi_express_patients/features/schedule/presentation/binding/schedule_binding.dart';
import 'package:medi_express_patients/features/schedule/presentation/page/book_schedule_page.dart';
import 'package:medi_express_patients/features/schedule/presentation/page/schedule_detail_page.dart';
import 'package:medi_express_patients/features/schedule/presentation/page/schedule_page.dart';
import 'package:medi_express_patients/routes/route_guard.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginPage(),
      binding: AuthBinding(),
      transition: Transition.noTransition,
    ),
    GetPage(
      name: AppRoutes.main,
      page: () => MainPage(),
      binding: MainBinding(),
      transition: Transition.noTransition,
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.enterPhoneNumberForgotPassword,
      page: () => EnterPhoneNumberForgotPasswordPage(),
      binding: AuthBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.intro,
      page: () => const IntroPage(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomePage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.healthRecordDetail,
      page: () => HealthRecordDetailPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.diagnosticImaging,
      page: () => DiagnosticImagingPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.homeHealthPackageDetail,
      page: () => HomeHealthPackageDetailPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.homeHealthPackage,
      page: () => HomeHealthPackagePage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.medicalServices,
      page: () => MedicalServicesPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.newsDetail,
      page: () => NewsDetailPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.news,
      page: () => NewsPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.prescription,
      page: () => PrescriptionPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.testing,
      page: () => TestingPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.vaccination,
      page: () => VaccinationPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.notification,
      page: () => NotificationPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.doctor,
      page: () => DoctorPage(),
      binding: DoctorBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.bookScheduleId,
      page: () => BookScheduleIdPage(),
      binding: DoctorBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.doctorDetail,
      page: () => DoctorDetailPage(),
      binding: DoctorBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.schedule,
      page: () => SchedulePage(),
      binding: ScheduleBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.scheduleDetail,
      page: () => ScheduleDetailPage(),
      binding: ScheduleBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.bookSchedule,
      page: () => BookSchedulePage(),
      binding: ScheduleBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.chat,
      page: () => ChatPage(),
      binding: ChatBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.chatDetail,
      page: () => ChatDetailPage(),
      binding: ChatBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.account,
      page: () => AccountPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.height,
      page: () => HeightPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.language,
      page: () => LanguagePage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.helper,
      page: () => HelperPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.spo2,
      page: () => Spo2Page(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.ua,
      page: () => UaPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.weight,
      page: () => WeightPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.bloodPressure,
      page: () => BloodPressurePage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.temp,
      page: () => TempPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.measuringDeviceLink,
      page: () => MeasuringDeviceLinkPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.heartbeat,
      page: () => HeartbeatPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.healthIndex,
      page: () => HealthIndexPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.healthIndexMeasurement,
      page: () => HealthIndexMeasurementPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.enterVerifyCodeForgotPassword,
      page: () => EnterVerifyCodeForgotPasswordPage(),
      binding: AuthBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.enterPasswordForgotPassword,
      page: () => EnterPasswordForgotPasswordPage(),
      binding: AuthBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.enterPhoneNumberRegister,
      page: () => EnterPhoneNumberRegisterPage(),
      binding: AuthBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.enterVerifyCodeRegister,
      page: () => EnterVerifyCodeRegisterPage(),
      binding: AuthBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.enterPasswordRegister,
      page: () => EnterPasswordRegisterPage(),
      binding: AuthBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.enterInformationRegister,
      page: () => EnterInformationRegisterPage(),
      binding: AuthBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.enterAnamnesisRegister,
      page: () => EnterAnamnesisRegisterPage(),
      binding: AuthBinding(),
      // middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.healthRecord,
      page: () => HealthRecordPage(),
      binding: HomeBinding(),
      middlewares: [RouteGuard()],
    ),
    // GetPage(
    //   name: AppRoutes.bottomBarNavigation,
    //   page: () => const BottomBarNavigationPage(),
    //   binding: BottomBarNavigationBinding(),
    //   // middlewares: [RouteGuard()],
    // ),

    GetPage(
      name: AppRoutes.personalInformation,
      page: () => PersonalInformationPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.updateHeight,
      page: () => UpdateHeightPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.updateWeight,
      page: () => UpdateWeightPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => ChangePasswordPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.bloodSugar,
      page: () => BloodSugarPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    GetPage(
      name: AppRoutes.measurementResults,
      page: () => MeasurementResultsPage(),
      binding: AccountBinding(),
      middlewares: [RouteGuard()],
    ),
    // GetPage(
    //   name: AppRoutes.persionalInformation,
    //   page: () => const PersionalInformationPage(),
    //   binding: BottomBarNavigationBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.ACCOUNT,
    //   page: () => const AccountPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.ADD_SCHEDULE,
    //   page: () => const AddSchedulePage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.CHANGE_PASSWORD,
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.CHAT,
    //   page: () => const ChatPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.CHAT_DETAIL,
    //   page: () => const ChatDetailPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.DOCTOR,
    //   page: () => const DoctorPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.DOCTOR_DETAIL,
    //   page: () => const DoctorDetailPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.FORGOT,
    //   page: () => const ForgotPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.FORGOT_PASSWORD,
    //   page: () => const EnterPhoneNumberPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.NEW_PASSWORD,
    //   page: () => const NewPasswordPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.VERIFY_CODE,
    //   page: () => const VerifyCodePage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.HOME,
    //   page: () => const HomePage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.ONBOARDING,
    //   page: () => const OnboardingPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.CREATE_PASSWORD,
    //   page: () => const CreatePasswordPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.HISTORY_OF_INFECTIOUS_DISEASES,
    //   page: () => const HistoryOfInfectiousDiseasesPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.INFORMATION,
    //   page: () => const InformationPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.REGISTER,
    //   page: () => const RegisterPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.SCHEDULE,
    //   page: () => const SchedulePage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.SCHEDULE_DETAIL,
    //   page: () => ScheduleDetailPage(
    //     itemSchedule: Get.arguments as ItemScheduleEntity,
    //   ),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.USER_INFORMATION,
    //   page: () => const UserInformationPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.USER_PARAMETER,
    //   page: () => const UserParameterPage(),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
    // GetPage(
    //   name: AppRoutes.USER_PARAMETER_DETAIL,
    //   page: () => UserParameterDetailPage(
    //     itemUserParameter: Get.arguments as ItemUserParameterEntity,
    //   ),
    //   binding: AuthBinding(),
    //   // middlewares: [RouteGuard()],
    // ),
  ];
}
