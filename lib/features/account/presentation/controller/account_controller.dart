import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
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
  void onInit() async {
    // TODO: implement onInit
    await init();
    Log.info("==== ${authController.baseState.user.value}");
    authController.fullNameController.text =
        authController.baseState.user.value.name ?? '';
    authController.emailController.text =
        authController.baseState.user.value.email ?? '';
    authController.birthdateController.text =
        authController.baseState.user.value.birthDate!.toFormattedDate() ?? '';
    authController.genderController.text =
        authController.baseState.user.value.gender! ? 'Nam' : 'Nữ';
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
    final resultCity = await authController.getAllCityUsecase(NoParams());
    resultCity.fold(
      (failureCity) {
        Log.severe("$failureCity");
        showError(
          () => clearError(),
          failureCity.message,
          'Quay lại',
        );
      },
      (successCity) async {
        accountState.listAllCity.value = successCity;
        for (var elementCity in successCity) {
          if (elementCity.name == authController.baseState.user.value.city) {
            accountState.city.value = elementCity;
          }
        }
        final resultDistrict = await authController.getDistrictByCityUsecase(
            GetDistrictByCityParams(cityId: accountState.city.value.id));
        resultDistrict.fold(
          (failureDistrict) {
            showError(
              () => clearError(),
              failureDistrict.message,
              'Quay lại',
            );
          },
          (successDistrict) async {
            Log.info(successDistrict.toString());
            accountState.listAllDistrict.value = successDistrict;
            for (var elementDistrict in successDistrict) {
              if (elementDistrict.districtName ==
                  authController.baseState.user.value.district) {
                accountState.district.value = elementDistrict;
              }
            }
            final resultWard = await authController.getWardByDistrictUsecase(
              GetWardByDistrictParams(
                  districtId: accountState.district.value.id),
            );
            resultWard.fold(
              (failureWard) {
                showError(
                  () => clearError(),
                  failureWard.message,
                  'Quay lại',
                );
              },
              (successWard) async {
                Log.info(successWard.toString());
                accountState.listAllWard.value = successWard;
                for (var elementWard in successWard) {
                  if (elementWard.wardName ==
                      authController.baseState.user.value.ward) {
                    accountState.ward.value = elementWard;
                  }
                }
              },
            );
          },
        );
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
        for (var element in success) {
          if (element.name == authController.baseState.user.value.city) {
            accountState.city.value = element;
          }
        }
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
