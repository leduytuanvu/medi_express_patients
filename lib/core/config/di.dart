import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/enviroment.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_client.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:medi_express_patients/features/auth/data/datasources/remote/auth_api_service.dart';
import 'package:medi_express_patients/features/auth/data/datasources/remote/auth_remote_datasource.dart';
import 'package:medi_express_patients/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:medi_express_patients/features/auth/domain/repositories/auth_repository.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/create_medical_history_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_all_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_auth_from_local_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_district_by_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_ward_by_district_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/login_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/register_usecase.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';

Future<void> initDI(String environmentName) async {
  Get.put<ErrorHandlingService>(ErrorHandlingService());
  Get.put<Log>(Log());
  final environment = await Environment.load(environmentName);
  Get.put<Environment>(environment);
  Get.put(ApiClient(environment.apiBaseUrl));
  Get.put(const FlutterSecureStorage());
  Get.lazyPut(() => AuthApiService(Get.find<ApiClient>().client));
  Get.lazyPut<AuthLocalDatasource>(
      () => AuthLocalDatasource(Get.find<FlutterSecureStorage>()));
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
    ),
  );
  Get.put(
    MainController(errorHandlingService: Get.find<ErrorHandlingService>()),
  );

  // Get.lazyPut(() =>
  //     HomeController(errorHandlingService: Get.find<ErrorHandlingService>()));

  // Get.lazyPut(() =>
  //     ChatController(errorHandlingService: Get.find<ErrorHandlingService>()));
}
