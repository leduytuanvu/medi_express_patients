import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/enviroment.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_client.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/storage/local_storage.dart';
import 'package:medi_express_patients/features/account/data/datasource/local/account_local_datasource.dart';
import 'package:medi_express_patients/features/account/data/datasource/remote/account_api_service.dart';
import 'package:medi_express_patients/features/account/data/datasource/remote/account_remote_datasource.dart';
import 'package:medi_express_patients/features/account/data/repositories/account_repository_impl.dart';
import 'package:medi_express_patients/features/account/domain/repositories/account_repository.dart';
import 'package:medi_express_patients/features/account/domain/usecases/get_health_metricts_usecase.dart';
import 'package:medi_express_patients/features/account/domain/usecases/upload_avatar_usecase.dart';
import 'package:medi_express_patients/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:medi_express_patients/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:medi_express_patients/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:medi_express_patients/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:medi_express_patients/features/auth/domain/repositories/auth_repository.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/check_phone_number_exists_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/create_medical_history_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_all_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_auth_from_local_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_district_by_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_user_information_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_ward_by_district_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/login_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/register_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/save_auth_to_local_usecase.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/chat/data/datasource/local/chat_local_datasource.dart';
import 'package:medi_express_patients/features/chat/data/datasource/remote/chat_api_service.dart';
import 'package:medi_express_patients/features/chat/data/datasource/remote/chat_remote_datasource.dart';
import 'package:medi_express_patients/features/chat/data/repositories/chat_repositoty_impl.dart';
import 'package:medi_express_patients/features/chat/domain/repositories/chat_repository.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/create_message_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_conversation_usecase.dart';
import 'package:medi_express_patients/features/chat/domain/usecases/get_all_message_usecase.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/local/doctor_local_datasource.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/remote/doctor_api_service.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/remote/doctor_remote_datasource.dart';
import 'package:medi_express_patients/features/doctor/data/repositories/doctor_repository_impl.dart';
import 'package:medi_express_patients/features/doctor/domain/repositories/doctor_repository.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_all_information_doctor_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_by_name_usecase.dart';
import 'package:medi_express_patients/features/doctor/domain/usecases/get_doctor_information_detail_usecase.dart';
import 'package:medi_express_patients/features/home/data/datasources/local/home_local_datasource.dart';
import 'package:medi_express_patients/features/home/data/datasources/remote/home_api_service.dart';
import 'package:medi_express_patients/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:medi_express_patients/features/home/data/repositories/home_repository_impl.dart';
import 'package:medi_express_patients/features/home/domain/repositories/home_repository.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_health_record_usecase.dart';
import 'package:medi_express_patients/features/home/domain/usecases/get_all_home_examination_package_usecase.dart';
import 'package:medi_express_patients/features/home/domain/usecases/upload_patient_usecase.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';
import 'package:medi_express_patients/features/schedule/data/datasources/local/schedule_local_datasource.dart';
import 'package:medi_express_patients/features/schedule/data/datasources/remote/schedule_api_service.dart';
import 'package:medi_express_patients/features/schedule/data/datasources/remote/schedule_remote_datasource.dart';
import 'package:medi_express_patients/features/schedule/data/repositories/schedule_repository_impl.dart';
import 'package:medi_express_patients/features/schedule/domain/repositories/schedule_repository.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/create_appointment_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_all_schedule_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_schedule_result_usecase.dart';
import 'package:medi_express_patients/features/schedule/domain/usecases/get_type_create_appointment_service_usecase.dart';

Future<void> initDI(String environmentName) async {
  Get.put<ErrorHandlingService>(ErrorHandlingService());
  Get.put<Log>(Log());
  final environment = await Environment.load(environmentName);
  Get.put<Environment>(environment);
  Get.put(ApiClient(environment.apiBaseUrl));
  final localStorage = LocalStorage();
  await localStorage.init(); // Ensure SharedPreferences is ready
  Get.put<LocalStorage>(localStorage); // Now it's safe to use LocalStorage

  /// Auth
  Get.lazyPut(() => AuthApiService(Get.find<ApiClient>().client));
  Get.lazyPut<AuthLocalDatasource>(
      () => AuthLocalDatasource(Get.find<LocalStorage>()));
  Get.lazyPut<AuthRemoteDatasource>(
      () => AuthRemoteDatasource(Get.find<AuthApiService>()));
  Get.lazyPut(() => AuthRepositoryImpl(
        Get.find<AuthLocalDatasource>(),
        Get.find<AuthRemoteDatasource>(),
      ));
  Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(
        Get.find<AuthLocalDatasource>(),
        Get.find<AuthRemoteDatasource>(),
      ));
  Get.lazyPut(() => LoginUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => RegisterUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => ChangePasswordUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => ForgotPasswordUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => GetAllCityUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => GetDistrictByCityUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => GetWardByDistrictUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => CreateMedicalHistoryUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => GetAuthFromLocalUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => SaveAuthToLocalUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => CheckPhoneNumberExistsUsecase(Get.find<AuthRepository>()));
  Get.lazyPut(() => GetUserInformationUsecase(Get.find<AuthRepository>()));
  Get.put(
    AuthController(
      loginUsecase: Get.find<LoginUsecase>(),
      changePasswordUsecase: Get.find<ChangePasswordUsecase>(),
      registerUsecase: Get.find<RegisterUsecase>(),
      forgotPasswordUsecase: Get.find<ForgotPasswordUsecase>(),
      getAllCityUsecase: Get.find<GetAllCityUsecase>(),
      errorHandlingService: Get.find<ErrorHandlingService>(),
      getDistrictByCityUsecase: Get.find<GetDistrictByCityUsecase>(),
      getWardByDistrictUsecase: Get.find<GetWardByDistrictUsecase>(),
      createMedicalHistoryUsecase: Get.find<CreateMedicalHistoryUsecase>(),
      getAuthFromLocalUsecase: Get.find<GetAuthFromLocalUsecase>(),
      saveAuthToLocalUsecase: Get.find<SaveAuthToLocalUsecase>(),
      checkPhoneNumberExistsUsecase: Get.find<CheckPhoneNumberExistsUsecase>(),
      getUserInformationUsecase: Get.find<GetUserInformationUsecase>(),
    ),
  );

  /// Chat
  Get.lazyPut(() => ChatApiService(Get.find<ApiClient>().client));
  Get.lazyPut<ChatLocalDatasource>(
      () => ChatLocalDatasource(Get.find<LocalStorage>()));
  Get.lazyPut<ChatRemoteDatasource>(
      () => ChatRemoteDatasource(Get.find<ChatApiService>()));
  Get.lazyPut(() => ChatRepositoryImpl(
        Get.find<ChatLocalDatasource>(),
        Get.find<ChatRemoteDatasource>(),
      ));
  Get.lazyPut<ChatRepository>(() => ChatRepositoryImpl(
        Get.find<ChatLocalDatasource>(),
        Get.find<ChatRemoteDatasource>(),
      ));
  Get.lazyPut(() => GetAllMessageUsecase(Get.find<ChatRepository>()));
  Get.lazyPut(() => GetAllConversationUsecase(Get.find<ChatRepository>()));
  Get.lazyPut(() => CreateConversationUsecase(Get.find<ChatRepository>()));
  Get.lazyPut(() => CreateMessageUsecase(Get.find<ChatRepository>()));
  Get.put<ChatController>(ChatController(
    getAllConversationUsecase: Get.find<GetAllConversationUsecase>(),
    getAllMessageUsecase: Get.find<GetAllMessageUsecase>(),
    createMessageUsecase: Get.find<CreateMessageUsecase>(),
    createConversationUsecase: Get.find<CreateConversationUsecase>(),
    errorHandlingService: Get.find<ErrorHandlingService>(),
    // Add other necessary dependencies here if required
  ));

  /// Main
  Get.put(
    MainController(errorHandlingService: Get.find<ErrorHandlingService>()),
  );

  /// Doctor
  Get.lazyPut(() => DoctorApiService(Get.find<ApiClient>().client));
  Get.lazyPut<DoctorLocalDatasource>(
      () => DoctorLocalDatasource(Get.find<LocalStorage>()));
  Get.lazyPut<DoctorRemoteDatasource>(
      () => DoctorRemoteDatasource(Get.find<DoctorApiService>()));
  Get.lazyPut(() => DoctorRepositoryImpl(
        Get.find<DoctorLocalDatasource>(),
        Get.find<DoctorRemoteDatasource>(),
      ));
  Get.lazyPut<DoctorRepository>(() => DoctorRepositoryImpl(
        Get.find<DoctorLocalDatasource>(),
        Get.find<DoctorRemoteDatasource>(),
      ));
  Get.lazyPut(
      () => GetAllInformationDoctorUsecase(Get.find<DoctorRepository>()));
  Get.lazyPut(
      () => GetDoctorInformationDetailUsecase(Get.find<DoctorRepository>()));
  Get.lazyPut(() => GetDoctorByNameUsecase(Get.find<DoctorRepository>()));

  /// Schedule
  Get.lazyPut(() => ScheduleApiService(Get.find<ApiClient>().client));
  Get.lazyPut<ScheduleLocalDatasource>(
      () => ScheduleLocalDatasource(Get.find<LocalStorage>()));
  Get.lazyPut<ScheduleRemoteDatasource>(
      () => ScheduleRemoteDatasource(Get.find<ScheduleApiService>()));
  Get.lazyPut(() => ScheduleRepositoryImpl(
        Get.find<ScheduleLocalDatasource>(),
        Get.find<ScheduleRemoteDatasource>(),
      ));
  Get.lazyPut<ScheduleRepository>(() => ScheduleRepositoryImpl(
        Get.find<ScheduleLocalDatasource>(),
        Get.find<ScheduleRemoteDatasource>(),
      ));
  Get.lazyPut(() => GetAllScheduleUsecase(Get.find<ScheduleRepository>()));
  Get.lazyPut(() => GetScheduleResultUsecase(Get.find<ScheduleRepository>()));
  Get.lazyPut(() => CreateAppointmentUsecase(Get.find<ScheduleRepository>()));
  Get.lazyPut(() =>
      GetTypeCreateAppointmentServiceUsecase(Get.find<ScheduleRepository>()));

  // Home
  Get.lazyPut(() => HomeApiService(Get.find<ApiClient>().client));
  Get.lazyPut<HomeLocalDatasource>(
      () => HomeLocalDatasource(Get.find<LocalStorage>()));
  Get.lazyPut<HomeRemoteDatasource>(
      () => HomeRemoteDatasource(Get.find<HomeApiService>()));
  Get.lazyPut(() => HomeRepositoryImpl(
        Get.find<HomeLocalDatasource>(),
        Get.find<HomeRemoteDatasource>(),
      ));
  Get.lazyPut<HomeRepository>(() => HomeRepositoryImpl(
        Get.find<HomeLocalDatasource>(),
        Get.find<HomeRemoteDatasource>(),
      ));
  Get.lazyPut(() => GetAllHealthRecordUsecase(Get.find<HomeRepository>()));
  Get.lazyPut(() => UploadPatientUsecase(Get.find<HomeRepository>()));
  Get.lazyPut(
      () => GetAllHomeExaminationPackageUsecase(Get.find<HomeRepository>()));

  // Account
  Get.lazyPut(() => AccountApiService(Get.find<ApiClient>().client));
  Get.lazyPut<AccountLocalDatasource>(
      () => AccountLocalDatasource(Get.find<LocalStorage>()));
  Get.lazyPut<AccountRemoteDatasource>(
      () => AccountRemoteDatasource(Get.find<AccountApiService>()));
  Get.lazyPut(() => AccountRepositoryImpl(
        Get.find<AccountLocalDatasource>(),
        Get.find<AccountRemoteDatasource>(),
      ));
  Get.lazyPut<AccountRepository>(() => AccountRepositoryImpl(
        Get.find<AccountLocalDatasource>(),
        Get.find<AccountRemoteDatasource>(),
      ));
  Get.lazyPut(() => GetHealthMetrictsUsecase(Get.find<AccountRepository>()));
  Get.lazyPut(() => UploadAvatarUsecase(Get.find<AccountRepository>()));
}
