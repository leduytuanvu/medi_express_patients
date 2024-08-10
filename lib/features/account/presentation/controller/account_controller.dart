import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/features/account/presentation/state/account_state.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_district_by_city_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_ward_by_district_params.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';

class AccountController extends BaseController {
  AccountController({
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AccountState accountState = AccountState();
  final AuthController authController = Get.find<AuthController>();

  // final phoneController = TextEditingController();
  // final verifyCodeController = TextEditingController();
  // final passwordLoginController = TextEditingController();
  // final passwordRegisterController = TextEditingController();
  // final rePasswordRegisterController = TextEditingController();
  // final passwordForgotPasswordController = TextEditingController();
  // final rePasswordForgotPasswordController = TextEditingController();
  // final fullNameController = TextEditingController();
  // final emailController = TextEditingController();
  // final birthdateController = TextEditingController();
  // final genderController = TextEditingController();
  // final cityController = TextEditingController();
  // final districtController = TextEditingController();
  // final wardController = TextEditingController();
  // final addressController = TextEditingController();
  // final bhytController = TextEditingController();
  // final anotherController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    authController.fullNameController.text =
        authController.baseState.user.value.name ?? '';
    authController.emailController.text =
        authController.baseState.user.value.email ?? '';
    authController.birthdateController.text =
        authController.baseState.user.value.birthDate ?? '';
    authController.genderController.text =
        authController.baseState.user.value.gender.toString() ?? '';
    authController.cityController.text =
        authController.baseState.user.value.city ?? '';
    authController.districtController.text =
        authController.baseState.user.value.district ?? '';
    authController.wardController.text =
        authController.baseState.user.value.ward ?? '';
    authController.addressController.text =
        authController.baseState.user.value.street ?? '';
    authController.bhytController.text =
        authController.baseState.user.value.bhytCode ?? '';
    Log.info("++++++ ${authController.baseState.user.value.toString()}");
    super.onInit();
    Log.info("init account controller");
  }

  Future<void> init() async {
    showLoading();
    final result = await authController.getAllCityUsecase(NoParams());
    result.fold(
      (failure) {
        Log.severe("$failure");
        showError(
          () => clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        accountState.listAllCity.value = success;

        clearError();
      },
    );
    hideLoading();
  }

  Future<void> getAllCity() async {
    showLoading();
    final result = await authController.getAllCityUsecase(NoParams());
    result.fold(
      (failure) {
        Log.severe("$failure");
        showError(
          () => clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        accountState.listAllCity.value = success;
        Log.severe("$success");
        clearError();
      },
    );
    hideLoading();
  }

  Future<void> getDistrictByCity(int cityId) async {
    showLoading();
    final result = await authController
        .getDistrictByCityUsecase(GetDistrictByCityParams(cityId: cityId));
    result.fold(
      (failure) {
        Log.severe("$failure");
        showError(
          () => clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        accountState.listAllDistrict.value = success;
        Log.severe("$success");
        clearError();
      },
    );
    hideLoading();
  }

  Future<void> getWardByDistrict(int districtId) async {
    showLoading();
    final result = await authController.getWardByDistrictUsecase(
        GetWardByDistrictParams(districtId: districtId));
    result.fold(
      (failure) {
        Log.severe("$failure");
        showError(
          () => clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        accountState.listAllWard.value = success;
        Log.severe("$success");
        clearError();
      },
    );
    hideLoading();
  }

  Future<void> initial() async {
    var user = authController.baseState.user.value;
    if (user.name!.isNotEmpty) {
      authController.fullNameController.text = user.name!;
    }
    if (user.email!.isNotEmpty) {
      authController.emailController.text = user.email!;
    }
    if (user.birthDate!.isNotEmpty) {
      authController.birthdateController.text = user.birthDate!;
    }
    if (user.birthDate!.isNotEmpty) {
      authController.birthdateController.text = user.birthDate!;
    }
    authController.genderController.text = user.gender.toString()!;
    if (user.city!.isNotEmpty) {
      authController.cityController.text = user.city!;
    }
    if (user.district!.isNotEmpty) {
      authController.districtController.text = user.district!;
    }
    if (user.ward!.isNotEmpty) {
      authController.wardController.text = user.ward!;
    }
    if (user.street!.isNotEmpty) {
      authController.addressController.text = user.street!;
    }
    if (user.bhytCode!.isNotEmpty) {
      authController.bhytController.text = user.bhytCode!;
    }
  }

  // Future<void> changePassword() async {
  //   WidgetsBinding.instance.addPostFrameCallback((_) async {
  //     Log.info("Loading initial data...");
  //     final result = await getAuthFromLocalUsecase(NoParams());
  //     result.fold(
  //           (failure) {},
  //           (success) async {
  //         final resultGetUserFromLocal =
  //         await getUserInformationUsecase(NoParams());
  //         resultGetUserFromLocal.fold(
  //               (failureGetUserFromServer) {},
  //               (successGetUserFromServer) async {
  //             setUser(successGetUserFromServer);
  //             setAuth(success);
  //           },
  //         );
  //       },
  //     );
  //     FlutterNativeSplash.remove();
  //   });
  // }
}
