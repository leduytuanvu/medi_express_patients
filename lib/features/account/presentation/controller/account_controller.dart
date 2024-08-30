import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/validators/email_validator.dart';
import 'package:medi_express_patients/features/account/domain/params/get_list_health_index_params.dart';
import 'package:medi_express_patients/features/account/domain/params/update_height_params.dart';
import 'package:medi_express_patients/features/account/domain/params/update_user_params.dart';
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
import 'package:medi_express_patients/features/account/presentation/state/account_state.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_district_by_city_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_ward_by_district_params.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';

class AccountController extends BaseController {
  final GetHealthMetrictsUsecase getHealthMetrictsUsecase;
  final UploadAvatarUsecase uploadAvatarUsecase;
  final UpdateUserUsecase updateUserUsecase;
  final UpdateHeightUsecase updateHeightUsecase;
  final UpdateWeightUsecase updateWeightUsecase;
  final GetListHeightUsecase getListHeightUsecase;
  final GetListAcidUricUsecase getListAcidUricUsecase;
  final GetListSpo2Usecase getListSpo2Usecase;
  final GetListBloodPressureUsecase getListBloodPressureUsecase;
  final GetListBloodSugarUsecase getListBloodSugarUsecase;
  final GetListHeartRateUsecase getListHeartRateUsecase;
  final GetListTemperatureUsecase getListTemperatureUsecase;
  final GetListWeightUsecase getListWeightUsecase;
  AccountController({
    required this.getListHeightUsecase,
    required this.getHealthMetrictsUsecase,
    required this.getListAcidUricUsecase,
    required this.getListSpo2Usecase,
    required this.getListBloodPressureUsecase,
    required this.getListBloodSugarUsecase,
    required this.getListHeartRateUsecase,
    required this.getListTemperatureUsecase,
    required this.getListWeightUsecase,
    required this.uploadAvatarUsecase,
    required this.updateUserUsecase,
    required this.updateHeightUsecase,
    required this.updateWeightUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  final AccountState accountState = AccountState();
  final AuthController authController = Get.find<AuthController>();

  final valueTextFieldController = TextEditingController();
  final dateTextFieldController = TextEditingController();
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

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        authController.showLoading();
        accountState.imageFile.value = File(pickedFile.path);
        final result = await uploadAvatarUsecase(File(pickedFile.path));
        result.fold(
          (failure) {
            Log.severe("$failure");
            authController.showError(
              () => authController.clearError(),
              failure.message,
              'Quay lại',
            );
          },
          (success) async {
            Log.severe("$success");
            final resultGetUserInformation =
                await authController.getUserInformationUsecase(NoParams());
            resultGetUserInformation.fold(
              (failureGetUserFromServer) {
                authController.showError(
                  () => authController.clearError(),
                  failureGetUserFromServer.message,
                  'Quay lại',
                );
              },
              (successGetUserFromServer) async {
                Log.info(
                    "successGetUserFromServer: ${successGetUserFromServer}");
                authController.setUser(successGetUserFromServer);
              },
            );
            clearError();
          },
        );
        authController.hideLoading();
        // await uploadImage(File(pickedFile.path));
      }
    } catch (e) {
      Log.info("e: ${e}");
      // Handle any errors that occur during image selection
      Get.snackbar('Error', 'Failed to pick image: $e');
    }
  }

  // Future<void> uploadImage(File file) async {
  //   try {
  //     Dio dio = Dio();
  //
  //     FormData formData = FormData.fromMap({
  //       "file": await MultipartFile.fromFile(file.path, filename: "upload.jpg"),
  //     });
  //
  //     Response response = await dio.post(
  //       "https://example.com/api/upload", // Replace with your upload URL
  //       data: formData,
  //     );
  //
  //     if (response.statusCode == 200) {
  //       // Handle successful upload
  //       Get.snackbar('Success', 'Image uploaded successfully');
  //     } else {
  //       // Handle failed upload
  //       Get.snackbar('Error', 'Image upload failed: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     // Handle any errors that occur during the upload
  //     Get.snackbar('Error', 'Image upload error: $e');
  //   }
  // }

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
    accountState.selectedGender.value =
        authController.baseState.user.value.gender! ? 'Nam' : 'Nữ';
    authController.cityController.text =
        authController.baseState.user.value.fullAddress!.city ?? '';
    authController.districtController.text =
        authController.baseState.user.value.fullAddress!.district ?? '';
    authController.wardController.text =
        authController.baseState.user.value.fullAddress!.ward ?? '';
    authController.addressController.text =
        authController.baseState.user.value.fullAddress!.address ?? '';
    authController.bhytController.text =
        authController.baseState.user.value.bhytCode ?? '';
    Log.info("++++++ ${authController.baseState.user.value.toString()}");
    super.onInit();
    // await getHealthMetricts();
    Log.info("init account controller");
  }

  Future<void> init() async {
    showLoading();
    final resultCity = await authController.getAllCityUsecase(NoParams());
    resultCity.fold(
      (failureCity) {
        Log.severe("1 $failureCity");
        showError(
          () => clearError(),
          failureCity.message,
          'Quay lại',
        );
      },
      (successCity) async {
        accountState.listAllCity.value = successCity;
        for (var elementCity in successCity) {
          if (elementCity.name ==
              authController.baseState.user.value.fullAddress!.district) {
            accountState.city.value = elementCity;
          }
        }
        final resultDistrict = await authController.getDistrictByCityUsecase(
            GetDistrictByCityParams(cityId: accountState.city.value!.id));
        resultDistrict.fold(
          (failureDistrict) {
            Log.severe("2 $failureDistrict");
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
                  authController.baseState.user.value.fullAddress!.city) {
                accountState.district.value = elementDistrict;
              }
            }
            final resultWard = await authController.getWardByDistrictUsecase(
              GetWardByDistrictParams(
                  districtId: accountState.district.value!.id),
            );
            resultWard.fold(
              (failureWard) {
                Log.severe("3 $failureWard");
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
                      authController.baseState.user.value.fullAddress!.ward) {
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
          if (element.name ==
              authController.baseState.user.value.fullAddress!.city) {
            accountState.city.value = element;
          }
        }
        Log.severe("$success");
        clearError();
      },
    );
    hideLoading();
  }

  Future<void> getListHeight() async {
    authController.showLoading();
    final result = await getListHeightUsecase(
      GetListHealthIndexParams(start: "", end: "", offset: "", limit: ""),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("$success");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getListWeight() async {
    authController.showLoading();
    final result = await getListWeightUsecase(
      GetListHealthIndexParams(start: "", end: "", offset: "", limit: ""),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("$success");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getListTemperature() async {
    authController.showLoading();
    final result = await getListTemperatureUsecase(
      GetListHealthIndexParams(start: "", end: "", offset: "", limit: ""),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("$success");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getListHeartRate() async {
    authController.showLoading();
    final result = await getListHeartRateUsecase(
      GetListHealthIndexParams(start: "", end: "", offset: "", limit: ""),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("$success");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getListBloodSugar() async {
    authController.showLoading();
    final result = await getListBloodSugarUsecase(
      GetListHealthIndexParams(start: "", end: "", offset: "", limit: ""),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("$success");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getListBloodPressure() async {
    authController.showLoading();
    final result = await getListBloodPressureUsecase(
      GetListHealthIndexParams(start: "", end: "", offset: "", limit: ""),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("$success");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getListSpo2() async {
    authController.showLoading();
    final result = await getListSpo2Usecase(
      GetListHealthIndexParams(start: "", end: "", offset: "", limit: ""),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("$success");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  Future<void> getListAcidUric() async {
    authController.showLoading();
    final result = await getListAcidUricUsecase(
      GetListHealthIndexParams(start: "", end: "", offset: "", limit: ""),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        authController.showError(
          () => authController.clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.severe("$success");
        authController.clearError();
      },
    );
    authController.hideLoading();
  }

  // Future<void> connectDevice6In1() async {
  //   showLoading();
  //   CommunicateMediExpress().bleInitListen(
  //     nameDevice: 'bluetoothbp',
  //     macAddressDevice: '',
  //   );
  //   hideLoading();
  // }

  Future<void> updateHeight(BuildContext context) async {
    var check = true;
    if (dateTextFieldController.text.trim().isEmpty) {
      check = false;
      accountState.errorDateInput.value = 'Ngày đo không được để trống';
    } else {
      accountState.errorDateInput.value = '';
    }
    if (valueTextFieldController.text.trim().isEmpty) {
      check = false;
      accountState.errorValueInput.value = 'Chiều cao không được để trống';
    } else {
      accountState.errorValueInput.value = '';
    }
    if (check) {
      authController.showLoading();
      Log.info("date time: ${dateTextFieldController.text}");
      DateFormat originalFormat = DateFormat('dd/MM/yyyy');
      DateFormat targetFormat = DateFormat('yyyy-MM-dd');

      DateTime dateTime = originalFormat.parse(dateTextFieldController.text);

      String formattedDate = targetFormat.format(dateTime);
      Log.info("message");
      final result = await updateHeightUsecase(
        UpdateHeightParams(
          patientId: authController.baseState.user.value.id,
          height: double.parse(valueTextFieldController.text),
          createAt: formattedDate,
        ),
      );
      result.fold(
        (failure) {
          Log.severe("$failure");
          authController.showError(
            () => authController.clearError(),
            failure.message,
            'Quay lại',
          );
        },
        (success) async {
          Log.info("dateeeeee: ${dateTextFieldController.text}");
          // var heightEntity = HeightEntity(
          //     value: valueTextFieldController.text,
          //     createdAt: dateTextFieldController.text);
          accountState.healthMetricts.value.height!.value.value =
              valueTextFieldController.text;
          Log.severe("$success");
          await getHealthMetricts();
          context.backScreen();
          authController.clearError();
        },
      );
      authController.hideLoading();
    }
  }

  Future<void> updateWeight(BuildContext context) async {
    var check = true;
    if (dateTextFieldController.text.trim().isEmpty) {
      check = false;
      accountState.errorDateInput.value = 'Ngày đo không được để trống';
    } else {
      accountState.errorDateInput.value = '';
    }
    if (valueTextFieldController.text.trim().isEmpty) {
      check = false;
      accountState.errorValueInput.value = 'Cân nặng không được để trống';
    } else {
      accountState.errorValueInput.value = '';
    }
    if (check) {
      authController.showLoading();
      Log.info("date time: ${dateTextFieldController.text}");
      DateFormat originalFormat = DateFormat('dd/MM/yyyy');
      DateFormat targetFormat = DateFormat('yyyy-MM-dd');

      DateTime dateTime = originalFormat.parse(dateTextFieldController.text);

      String formattedDate = targetFormat.format(dateTime);
      Log.info("message");
      final result = await updateWeightUsecase(
        UpdateHeightParams(
          patientId: authController.baseState.user.value.id,
          height: double.parse(valueTextFieldController.text),
          createAt: formattedDate,
        ),
      );
      result.fold(
        (failure) {
          Log.severe("$failure");
          authController.showError(
            () => authController.clearError(),
            failure.message,
            'Quay lại',
          );
        },
        (success) {
          accountState.healthMetricts.value.weight!.value.value =
              valueTextFieldController.text;
          Log.severe("$success");
          context.backScreen();
          authController.clearError();
        },
      );
      authController.hideLoading();
    }
  }

  // Future<void> getDistrictByCity(int cityId) async {
  //   authController.showLoading();
  //   final result = await authController
  //       .getDistrictByCityUsecase(GetDistrictByCityParams(cityId: cityId));
  //   result.fold(
  //     (failure) {
  //       Log.severe("$failure");
  //       authController.showError(
  //         () => authController.clearError(),
  //         failure.message,
  //         'Quay lại',
  //       );
  //     },
  //     (success) {
  //       accountState.listAllDistrict.value = success;
  //       Log.severe("$success");
  //       authController.clearError();
  //     },
  //   );
  //   authController.hideLoading();
  // }
  //
  // Future<void> getWardByDistrict(int districtId) async {
  //   authController.showLoading();
  //   final result = await authController.getWardByDistrictUsecase(
  //       GetWardByDistrictParams(districtId: districtId));
  //   result.fold(
  //     (failure) {
  //       Log.severe("$failure");
  //       authController.showError(
  //         () => authController.clearError(),
  //         failure.message,
  //         'Quay lại',
  //       );
  //     },
  //     (success) {
  //       accountState.listAllWard.value = success;
  //       Log.severe("$success");
  //       authController.clearError();
  //     },
  //   );
  //   authController.hideLoading();
  // }

  Future<void> getHealthMetricts() async {
    showLoading();
    final result = await getHealthMetrictsUsecase(
        authController.baseState.user.value.id.toString());
    result.fold(
      (failure) {
        Log.info("gettttttttt: $failure");
        Log.severe("-1-1-1 $failure");
        showError(
          () => clearError(),
          failure.message,
          'Quay lại',
        );
      },
      (success) {
        Log.info("gettttttttt: $success");
        accountState.healthMetricts.value = success;
        // accountState.listAllCity.value = success;
        // for (var element in success) {
        //   if (element.name == authController.baseState.user.value.city) {
        //     accountState.city.value = element;
        //   }
        // }
        Log.severe("111 ${success.toString()}");
        // clearError();
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

  Future<void> updateInformation() async {
    authController.showLoading();
    var check = true;
    if (authController.fullNameController.value.text.trim().isEmpty) {
      check = false;
      authController.authState.errorFullName.value =
          "Họ tên không được để trống";
    } else {
      authController.authState.errorFullName.value = "";
    }
    if (authController.emailController.text.trim().isEmpty) {
      check = false;
      authController.authState.errorEmail.value = "Email không đươc để trống";
    } else if (!EmailValidator.validate(
        authController.emailController.text.trim())) {
      check = false;
      authController.authState.errorEmail.value =
          "Định dạng email không hợp lệ";
    } else {
      authController.authState.errorEmail.value = "";
    }
    if (authController.birthdateController.text.trim().isEmpty) {
      check = false;
      authController.authState.errorBirthdate.value =
          "Ngày sinh không đươc để trống";
    } else {
      authController.authState.errorBirthdate.value = "";
    }
    if (authController.birthdateController.text.trim().isEmpty) {
      check = false;
      authController.authState.errorBirthdate.value =
          "Ngày sinh không đươc để trống";
    } else {
      authController.authState.errorBirthdate.value = "";
    }
    if (accountState.city.value!.name.isEmpty) {
      check = false;
      authController.authState.errorCity.value =
          "Tỉnh/thành phố không được để trống";
    } else {
      authController.authState.errorCity.value = "";
    }
    if (accountState.district.value == null) {
      check = false;
      authController.authState.errorDistrict.value =
          "Quận/huyện không được để trống";
    } else if (accountState.district.value!.districtName.isEmpty) {
      check = false;
      authController.authState.errorDistrict.value =
          "Quận/huyện không được để trống";
    } else {
      authController.authState.errorDistrict.value = "";
    }
    if (accountState.ward.value == null) {
      check = false;
      authController.authState.errorWard.value =
          "Phường/xã không được để trống";
    } else if (accountState.ward.value!.wardName.isEmpty) {
      check = false;
      authController.authState.errorWard.value =
          "Phường/xã không được để trống";
    } else {
      authController.authState.errorWard.value = "";
    }
    if (authController.addressController.text.isEmpty) {
      check = false;
      authController.authState.errorAddress.value =
          "Địa chỉ cụ thể không được để trống";
    } else {
      authController.authState.errorAddress.value = "";
    }
    if (authController.bhytController.text.isEmpty) {
      check = false;
      authController.authState.errorBhyt.value = "Sổ BHYT không được để trống";
    } else {
      authController.authState.errorBhyt.value = "";
    }
    if (check) {
      Log.info("birthday: ${authController.birthdateController.text}");
      Log.info("address: ${authController.addressController.text}");
      var gender = accountState.selectedGender.value == "Nam" ? 1 : 0;
      final result = await updateUserUsecase(
        UpdateUserParams(
          gender: gender,
          address: authController.addressController.text,
          email: authController.emailController.text,
          wardId: accountState.ward.value!.id,
          name: authController.fullNameController.text,
          birthdate: authController.birthdateController.text.toIsoFormat(),
          bhytCode: authController.bhytController.text,
        ),
      );
      result.fold(
        (failure) {
          Log.severe("??????????????  $failure");
          showError(
            () => clearError(),
            failure.message,
            'Quay lại',
          );
        },
        (success) async {
          final resultCity = await authController.getAllCityUsecase(NoParams());
          resultCity.fold(
            (failureCity) {
              Log.severe("1 $failureCity");
              showError(
                () => clearError(),
                failureCity.message,
                'Quay lại',
              );
            },
            (successCity) async {
              accountState.listAllCity.value = successCity;
              for (var elementCity in successCity) {
                if (elementCity.name == accountState.city.value!.name) {
                  accountState.city.value = elementCity;
                }
              }
              Log.info(
                  "cituuuuuuuuuuuuuuuuuuuuuuuu: ${accountState.city.value!.name}");
              final resultDistrict = await authController
                  .getDistrictByCityUsecase(GetDistrictByCityParams(
                      cityId: accountState.city.value!.id));
              resultDistrict.fold(
                (failureDistrict) {
                  Log.severe("2 $failureDistrict");
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
                        accountState.district.value!.districtName) {
                      accountState.district.value = elementDistrict;
                    }
                  }
                  final resultWard =
                      await authController.getWardByDistrictUsecase(
                    GetWardByDistrictParams(
                        districtId: accountState.district.value!.id),
                  );
                  resultWard.fold(
                    (failureWard) {
                      Log.severe("3 $failureWard");
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
                            accountState.ward.value!.wardName) {
                          accountState.ward.value = elementWard;
                        }
                      }
                    },
                  );
                },
              );
            },
          );

          Log.severe("?????????????? $success");
          authController.fullNameController.text = success.name;
          authController.emailController.text = success.email;
          authController.birthdateController.text =
              success.birthDate.toFormattedDate();
          authController.genderController.text = success.gender ? 'Nam' : 'Nữ';
          authController.addressController.text = success.address;
          authController.bhytController.text = success.bhytCode;

          // authController.baseState.user.value.name = success.name;
          // authController.baseState.user.value.email = success.email;
          // authController.baseState.user.value.birthDate = success.birthDate;
          // authController.baseState.user.value.gender = success.gender;
          // authController.baseState.user.value.fullAddress = success.name;
          // authController.baseState.user.value.bhytCode = success.bhytCode;

          authController.baseState.user.update((user) {
            if (user != null) {
              user.name = success.name;
              user.email = success.email;
              user.birthDate = success.birthDate;
              user.gender = success.gender;
              user.fullAddress =
                  "${success.address}, ${accountState.ward.value!.wardName}, ${accountState.district.value!.districtName}, ${accountState.city.value!.name}";
              user.bhytCode = success.bhytCode;
            }
          });

          Log.info(
              "city: ${accountState.city.value!.name}, district: ${accountState.district.value!.districtName}, ward: ${accountState.ward.value!.wardName}, ");

          clearError();
        },
      );
    }
    authController.hideLoading();
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

  // Future<void> initial() async {
  //   var user = authController.baseState.user.value;
  //   if (user.name!.isNotEmpty) {
  //     authController.fullNameController.text = user.name!;
  //   }
  //   if (user.email!.isNotEmpty) {
  //     authController.emailController.text = user.email!;
  //   }
  //   if (user.birthDate!.isNotEmpty) {
  //     authController.birthdateController.text = user.birthDate!;
  //   }
  //   if (user.birthDate!.isNotEmpty) {
  //     authController.birthdateController.text = user.birthDate!;
  //   }
  //   authController.genderController.text = user.gender.toString()!;
  //   if (user.city!.isNotEmpty) {
  //     authController.cityController.text = user.city!;
  //   }
  //   if (user.district!.isNotEmpty) {
  //     authController.districtController.text = user.district!;
  //   }
  //   if (user.ward!.isNotEmpty) {
  //     authController.wardController.text = user.ward!;
  //   }
  //   if (user.street!.isNotEmpty) {
  //     authController.addressController.text = user.street!;
  //   }
  //   if (user.bhytCode!.isNotEmpty) {
  //     authController.bhytController.text = user.bhytCode!;
  //   }
  // }

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
