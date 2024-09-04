import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/service/notification_service.dart';
import 'package:medi_express_patients/core/usecases/no_params.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/validators/email_validator.dart';
import 'package:medi_express_patients/core/utils/validators/password_validator.dart';
import 'package:medi_express_patients/core/utils/validators/phone_validator.dart';
import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';
import 'package:medi_express_patients/features/auth/domain/params/change_password_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/create_medical_history_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/forgot_password_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_district_by_city_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_ward_by_district_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/login_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/register_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/save_auth_to_local_params.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/check_phone_number_exists_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/create_medical_history_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_all_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_auth_from_local_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_district_by_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_language_from_local_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_user_information_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_ward_by_district_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/register_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/save_auth_to_local_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/save_language_usecase.dart';
import 'package:medi_express_patients/features/auth/presentation/state/auth_state.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../domain/usecases/login_usecase.dart';

class AuthController extends BaseController {
  final AuthState authState = AuthState();
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final ForgotPasswordUsecase forgotPasswordUsecase;
  final GetAllCityUsecase getAllCityUsecase;
  final GetDistrictByCityUsecase getDistrictByCityUsecase;
  final GetWardByDistrictUsecase getWardByDistrictUsecase;
  final CreateMedicalHistoryUsecase createMedicalHistoryUsecase;
  final GetAuthFromLocalUsecase getAuthFromLocalUsecase;
  final GetLanguageFromLocalUsecase getLanguageFromLocalUsecase;
  final SaveAuthToLocalUsecase saveAuthToLocalUsecase;
  final SaveLanguageUsecase saveLanguageUsecase;
  final CheckPhoneNumberExistsUsecase checkPhoneNumberExistsUsecase;
  final GetUserInformationUsecase getUserInformationUsecase;

  final phoneController = TextEditingController();
  final verifyCodeController = TextEditingController();
  final passwordLoginController = TextEditingController();
  final passwordRegisterController = TextEditingController();
  final rePasswordRegisterController = TextEditingController();
  final passwordForgotPasswordController = TextEditingController();
  final rePasswordForgotPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final birthdateController = TextEditingController();
  final genderController = TextEditingController();
  final cityController = TextEditingController();
  final districtController = TextEditingController();
  final wardController = TextEditingController();
  final addressController = TextEditingController();
  final bhytController = TextEditingController();
  final anotherController = TextEditingController();

  final oldChangePasswordController = TextEditingController();
  final newChangePasswordController = TextEditingController();
  final reNewChangePasswordController = TextEditingController();

  Timer? _timer;

  AuthController({
    required this.loginUsecase,
    required this.saveLanguageUsecase,
    required this.getLanguageFromLocalUsecase,
    required this.forgotPasswordUsecase,
    required this.registerUsecase,
    required this.changePasswordUsecase,
    required this.getAllCityUsecase,
    required this.getDistrictByCityUsecase,
    required this.getWardByDistrictUsecase,
    required this.createMedicalHistoryUsecase,
    required this.getAuthFromLocalUsecase,
    required this.saveAuthToLocalUsecase,
    required this.checkPhoneNumberExistsUsecase,
    required this.getUserInformationUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  void startTimeout() {
    _timer?.cancel();
    authState.timeoutConfirmVerifyCode.value = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (authState.timeoutConfirmVerifyCode.value > 0) {
        authState.timeoutConfirmVerifyCode.value--;
      } else {
        timer.cancel();
        onTimeout();
      }
    });
  }

  void onTimeout() {
    Log.info('Verification code timeout');
  }

  Future<void> initial() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Log.info("Loading initial data...");
      final resultGetLanguage = await getLanguageFromLocalUsecase(NoParams());
      resultGetLanguage.fold((failureGetLanguage) {
        Log.info("................... fail $failureGetLanguage");
        baseState.locale.value = baseState.listLocale[0];
        Get.updateLocale(baseState.locale.value);
        setAuth(
          AuthEntity(
            accessToken: '',
            refreshToken: '',
            expiresIn: -1,
            firstTimeOpenApp: 'false',
          ),
        );
      }, (successGetLanguage) async {
        Log.info("................... success $successGetLanguage");
        if (successGetLanguage.isEmpty) {
          baseState.locale.value = baseState.listLocale[0];
        } else {
          for (var item in baseState.listLocale) {
            if (item.languageCode == successGetLanguage) {
              baseState.locale.value = item;
              break;
            }
          }
        }
        Get.updateLocale(baseState.locale.value);
        final result = await getAuthFromLocalUsecase(NoParams());
        result.fold(
          (failure) {
            setAuth(
              AuthEntity(
                accessToken: '',
                refreshToken: '',
                expiresIn: -1,
                firstTimeOpenApp: 'false',
              ),
            );
          },
          (success) async {
            if (success.accessToken.isNotEmpty) {
              final resultGetUserFromLocal =
                  await getUserInformationUsecase(NoParams());
              resultGetUserFromLocal.fold(
                (failureGetUserFromServer) {
                  setAuth(
                    AuthEntity(
                      accessToken: '',
                      refreshToken: '',
                      expiresIn: -1,
                      firstTimeOpenApp: 'false',
                    ),
                  );
                },
                (successGetUserFromServer) async {
                  setUser(successGetUserFromServer);
                  setAuth(success);
                  final ChatController chatController =
                      Get.find<ChatController>();
                  chatController.connectSocket();
                },
              );
            } else {
              setAuth(success);
            }
          },
        );
        await Future.delayed(Duration(seconds: 3));
        FlutterNativeSplash.remove();
      });
    });
  }

  @override
  void onInit() {
    super.onInit();
    initial();
  }

  @override
  void onClose() {
    Log.info("onClose");
    phoneController.dispose();
    verifyCodeController.dispose();
    passwordLoginController.dispose();
    passwordRegisterController.dispose();
    rePasswordRegisterController.dispose();
    passwordForgotPasswordController.dispose();
    rePasswordForgotPasswordController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    birthdateController.dispose();
    genderController.dispose();
    cityController.dispose();
    districtController.dispose();
    wardController.dispose();
    addressController.dispose();
    bhytController.dispose();
    anotherController.dispose();
    _timer?.cancel();
    super.onClose();
  }

  Future<void> sendOtpForgotPassword(BuildContext context) async {
    try {
      showLoading();
      if (phoneController.text.trim().isEmpty) {
        authState.errorPhoneForgotPassword.value =
            'phone_number_cannot_be_blank'.tr;
      } else if (!PhoneValidator.validate(phoneController.text.trim())) {
        authState.errorPhoneForgotPassword.value =
            'invalid_phone_number_format'.tr;
      } else {
        final result = await checkPhoneNumberExistsUsecase(
          phoneController.text,
        );
        result.fold(
          (failure) {
            Log.severe("$failure");
            showError(
              () => clearError(),
              failure.message,
              'come_back'.tr,
            );
          },
          (success) async {
            Log.info(success.toString());
            if (success) {
              Log.info('Thành cồng');
              authState.errorPhoneForgotPassword.value = '';
              verifyCodeController.text = '';
              authState.errorVerifyCodeForgotPassword.value = '';
              context.toNamedScreen(
                AppRoutes.enterVerifyCodeForgotPassword,
              );
              final random = Random();
              final verifyCode = 100000 + random.nextInt(900000);
              authState.verifyCode.value = verifyCode;
              NotificationService().showNotification(
                id: verifyCode,
                title: "Medi Express",
                body: "Verify Code $verifyCode",
              );
              startTimeout();
            } else {
              showError(
                () => clearError(),
                'phone_number_not_registered'.tr,
                'come_back'.tr,
              );
            }
          },
        );
      }
    } catch (e) {
      showError(
        () => clearError(),
        e.toString(),
        'come_back'.tr,
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> sendOtpRegister(BuildContext context) async {
    try {
      showLoading();
      if (phoneController.text.trim().isEmpty) {
        authState.errorPhoneRegister.value = 'phone_number_cannot_be_blank'.tr;
      } else if (!PhoneValidator.validate(phoneController.text.trim())) {
        authState.errorPhoneRegister.value = 'invalid_phone_number_format'.tr;
      } else {
        final result = await checkPhoneNumberExistsUsecase(
          phoneController.text,
        );
        result.fold(
          (failure) {
            Log.severe("$failure");
            showError(
              () => clearError(),
              failure.message,
              'come_back'.tr,
            );
          },
          (success) {
            if (success) {
              showError(
                () => clearError(),
                'phone_number_has_been_registered'.tr,
                'come_back'.tr,
              );
            } else {
              authState.errorPhoneRegister.value = '';
              verifyCodeController.text = '';
              authState.errorVerifyCodeRegister.value = '';
              context.toNamedScreen(
                AppRoutes.enterVerifyCodeRegister,
              );
              final random = Random();
              final verifyCode = 100000 + random.nextInt(900000);
              authState.verifyCode.value = verifyCode;
              NotificationService().showNotification(
                id: verifyCode,
                title: 'Medi Express',
                body: 'Verify Code $verifyCode',
              );
              startTimeout();
            }
          },
        );
      }
    } catch (e) {
      showError(
        () => clearError(),
        e.toString(),
        'come_back'.tr,
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> verifyOtpForgotPassword(BuildContext context) async {
    try {
      showLoading();
      if (verifyCodeController.text.trim().isEmpty) {
        authState.errorVerifyCodeForgotPassword.value =
            'please_enter_verification_code'.tr;
      } else if (verifyCodeController.text.trim().length != 6) {
        authState.errorVerifyCodeForgotPassword.value =
            'invalid_verification_code'.tr;
      } else {
        authState.errorVerifyCodeForgotPassword.value = '';
        authState.errorPasswordForgotPassword.value = '';
        authState.errorRePasswordForgotPassword.value = '';
        passwordForgotPasswordController.text = '';
        rePasswordForgotPasswordController.text = '';
        if (authState.timeoutConfirmVerifyCode.value > 0) {
          if (verifyCodeController.text ==
              authState.verifyCode.value.toString()) {
            context.toNamedScreen(
              AppRoutes.enterPasswordForgotPassword,
            );
          } else {
            authState.errorVerifyCodeForgotPassword.value =
                'incorrect_verification_code'.tr;
          }
        } else {
          authState.errorVerifyCodeForgotPassword.value =
              'authentication_time_out_please_resend_code'.tr;
        }
      }
    } catch (e) {
      showError(
        () => clearError(),
        e.toString(),
        'come_back'.tr,
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> verifyOtpRegister(BuildContext context) async {
    try {
      showLoading();
      if (verifyCodeController.text.trim().isEmpty) {
        authState.errorVerifyCodeRegister.value =
            'please_enter_verification_code'.tr;
      } else if (verifyCodeController.text.trim().length != 6) {
        authState.errorVerifyCodeRegister.value =
            'invalid_verification_code'.tr;
      } else {
        authState.errorVerifyCodeRegister.value = '';
        authState.errorPasswordRegister.value = '';
        authState.errorRePasswordRegister.value = '';
        passwordRegisterController.text = '';
        rePasswordRegisterController.text = '';
        if (authState.timeoutConfirmVerifyCode.value > 0) {
          if (verifyCodeController.text ==
              authState.verifyCode.value.toString()) {
            context.toNamedScreen(
              AppRoutes.enterPasswordRegister,
            );
          } else {
            authState.errorVerifyCodeRegister.value =
                'incorrect_verification_code'.tr;
          }
        } else {
          authState.errorVerifyCodeRegister.value =
              'authentication_time_out_please_resend_code'.tr;
        }
      }
    } catch (e) {
      showError(
        () => clearError(),
        e.toString(),
        'come_back'.tr,
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> saveLanguage(BuildContext context) async {
    showLoading();
    var check = false;
    final result =
        await saveLanguageUsecase(baseState.locale.value.languageCode);
    result.fold(
      (failure) {},
      (success) {
        check = success;
      },
    );
    if (check == true) {
      Get.updateLocale(baseState.locale.value);
      await Future.delayed(Duration(milliseconds: 300));
      context.backScreen();
    } else {
      showError(
        () => clearError(),
        "language_installation_failed".tr,
        'come_back'.tr,
      );
    }
    hideLoading();
  }

  Future<void> resendOtp(BuildContext context) async {
    try {
      showLoading();
      verifyCodeController.text = '';
      final random = Random();
      final verifyCode = 100000 + random.nextInt(900000);
      authState.verifyCode.value = verifyCode;
      authState.errorVerifyCodeForgotPassword.value = '';
      authState.errorVerifyCodeRegister.value = '';
      NotificationService().showNotification(
        id: verifyCode,
        title: 'Medi Express',
        body: 'Verify Code $verifyCode',
      );
      startTimeout();
    } catch (e) {
      showError(
        () => clearError(),
        e.toString(),
        'come_back'.tr,
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> getAllCity() async {
    showLoading();
    final result = await getAllCityUsecase(NoParams());
    result.fold(
      (failure) {
        Log.severe("$failure");
        showError(
          () => clearError(),
          failure.message,
          'come_back'.tr,
        );
      },
      (success) {
        authState.listAllCity.value = success;
        Log.severe("$success");
        clearError();
      },
    );
    hideLoading();
  }

  Future<void> getDistrictByCity(int cityId) async {
    showLoading();
    final result =
        await getDistrictByCityUsecase(GetDistrictByCityParams(cityId: cityId));
    result.fold(
      (failure) {
        Log.severe("$failure");
        showError(
          () => clearError(),
          failure.message,
          'come_back'.tr,
        );
      },
      (success) {
        authState.listAllDistrict.value = success;
        Log.severe("$success");
        clearError();
      },
    );
    hideLoading();
  }

  Future<void> getWardByDistrict(int districtId) async {
    showLoading();
    final result = await getWardByDistrictUsecase(
        GetWardByDistrictParams(districtId: districtId));
    result.fold(
      (failure) {
        Log.severe("$failure");
        showError(
          () => clearError(),
          failure.message,
          'come_back'.tr,
        );
      },
      (success) {
        authState.listAllWard.value = success;
        Log.severe("$success");
        clearError();
      },
    );
    hideLoading();
  }

  Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status == PermissionStatus.granted) {
      // Permission granted
      print("Notification Permission granted");
    } else if (status == PermissionStatus.denied) {
      // Permission denied
      print("Notification Permission denied");
    } else if (status == PermissionStatus.permanentlyDenied) {
      // The user opted not to grant permission and chose to never ask again.
      // Open the app settings to let the user manually enable it.
      openAppSettings();
    }
  }

  Future<void> login(BuildContext context) async {
    bool isError = false;
    if (phoneController.text.trim().isEmpty) {
      isError = true;
      authState.errorPhoneLogin.value = 'phone_number_cannot_be_blank'.tr;
    } else if (!PhoneValidator.validate(phoneController.text.trim())) {
      isError = true;
      authState.errorPhoneLogin.value = 'invalid_phone_number_format'.tr;
    } else {
      authState.errorPhoneLogin.value = '';
    }
    if (passwordLoginController.text.trim().isEmpty) {
      isError = true;
      authState.errorPasswordLogin.value = 'password_cannot_be_blank'.tr;
    } else if (passwordLoginController.text.trim().length < 8) {
      isError = true;
      authState.errorPasswordLogin.value =
          'password_must_be_longer_than_8_characters'.tr;
    } else {
      authState.errorPasswordLogin.value = '';
    }

    if (!isError) {
      showLoading();
      final result = await loginUsecase(
        LoginParams(
          phoneNumber: phoneController.text,
          password: passwordLoginController.text,
        ),
      );
      result.fold(
        (failureLogin) {
          Log.severe("$failureLogin");
          showError(
            () => clearError(),
            failureLogin.message,
            'come_back'.tr,
          );
        },
        (successLogin) async {
          final ChatController chatController = Get.find<ChatController>();
          chatController.connectSocket(accessToken: successLogin.accessToken);
          final result = await getUserInformationUsecase(NoParams());
          result.fold(
            (failureGetUserInformation) {
              Log.severe("$failureGetUserInformation");
              showError(
                () => clearError(),
                failureGetUserInformation.message,
                'come_back'.tr,
              );
            },
            (successGetUserInformation) {
              setUser(successGetUserInformation);
              successLogin.firstTimeOpenApp = "false";
              setAuth(successLogin);
            },
          );
        },
      );
      hideLoading();
    }
  }

  Future<void> logout(BuildContext context) async {
    showConfirm(() async {
      clearConfirm();
      showLoading();
      await Future.delayed(Duration(seconds: 1));
      var auth = AuthEntity(
        accessToken: '',
        expiresIn: -1,
        refreshToken: '',
        firstTimeOpenApp: 'false',
      );
      final result = await saveAuthToLocalUsecase(
        SaveAuthToLocalParams(auth: auth),
      );
      result.fold(
        (failure) {
          Log.severe("$failure");
          showError(
            () => clearError(),
            failure.message,
            'come_back'.tr,
          );
        },
        (success) {
          setAuth(auth);
          final MainController mainController = Get.find<MainController>();
          mainController.changePage(0);
        },
      );

      setAuth(auth);
      hideLoading();
    }, 'log_out_of_account'.tr, 'agree'.tr);
  }

  Future<void> enterInformation(BuildContext context) async {
    bool isError = false;
    if (fullNameController.text.trim().isEmpty) {
      isError = true;
      authState.errorFullName.value = 'full_name_cannot_be_left_blank'.tr;
    } else {
      authState.errorFullName.value = '';
    }

    if (!EmailValidator.validate(emailController.text.trim())) {
      isError = true;
      authState.errorEmail.value = 'invalid_email_format'.tr;
    } else {
      authState.errorEmail.value = '';
    }

    if (birthdateController.text.trim().isEmpty) {
      isError = true;
      authState.errorBirthdate.value = 'date_of_birth_cannot_be_left_blank'.tr;
    } else {
      authState.errorBirthdate.value = '';
    }

    if (genderController.text.trim().isEmpty) {
      isError = true;
      authState.errorGender.value = 'gender_cannot_be_left_blank'.tr;
    } else {
      authState.errorGender.value = '';
    }

    if (cityController.text.trim().isEmpty) {
      isError = true;
      authState.errorCity.value = 'province_city_cannot_be_left_blank'.tr;
    } else {
      authState.errorCity.value = '';
    }

    if (districtController.text.trim().isEmpty) {
      isError = true;
      authState.errorDistrict.value = 'district_cannot_be_left_blank'.tr;
    } else {
      authState.errorDistrict.value = '';
    }

    if (wardController.text.trim().isEmpty) {
      isError = true;
      authState.errorWard.value = 'ward_commune_cannot_be_left_blank'.tr;
    } else {
      authState.errorWard.value = '';
    }

    if (addressController.text.trim().isEmpty) {
      isError = true;
      authState.errorAddress.value = 'specific_address_cannot_be_left_blank'.tr;
    } else {
      authState.errorAddress.value = '';
    }

    if (bhytController.text.trim().isEmpty) {
      isError = true;
      authState.errorBhyt.value =
          'health_insurance_book_cannot_be_left_blank'.tr;
    } else {
      authState.errorBhyt.value = '';
    }

    if (!isError) {
      authState.hypertension.value = false;
      authState.diabetes.value = false;
      authState.heartDisease.value = false;
      authState.stroke.value = false;
      authState.asthma.value = false;
      authState.epilepsy.value = false;
      authState.copd.value = false;
      authState.palpitations.value = false;
      authState.otherMedicalHistory.value = '';
      context.toNamedScreen(AppRoutes.enterAnamnesisRegister);
    }
  }

  Future<void> verifyCode(Function() processWhenSuccess) async {
    bool isError = false;
    if (verifyCodeController.text.trim().isEmpty) {
      isError = true;
      authState.errorVerifyCodeForgotPassword.value =
          'please_enter_verification_code'.tr;
      authState.errorVerifyCodeRegister.value =
          'please_enter_verification_code'.tr;
    } else if (verifyCodeController.text.trim().length < 6) {
      isError = true;
      authState.errorVerifyCodeForgotPassword.value =
          'the_verification_code_must_be_6_digits_long'.tr;
      authState.errorVerifyCodeRegister.value =
          'the_verification_code_must_be_6_digits_long'.tr;
    } else if (verifyCodeController.text.trim() != "123456") {
      isError = true;
      authState.errorVerifyCodeForgotPassword.value =
          'incorrect_verification_code'.tr;
      authState.errorVerifyCodeRegister.value =
          'the_verification_code_must_be_6_digits_long'.tr;
    } else {
      authState.errorVerifyCodeForgotPassword.value = '';
      authState.errorVerifyCodeRegister.value = '';
    }

    if (!isError) {
      // try {
      //   if (authState.timeoutConfirmVerifyCode.value == 0) {
      //     globalController
      //         .setWarning('Hết thời gian xác thực, vui lòng gửi lại mã');
      //   } else {
      //     globalController.showLoading();
      //     Log.info("verificationId end: ${authState.verificationId.value}");
      //     Log.info("verifyCodeController.text: ${verifyCodeController.text}");
      //     final credential = PhoneAuthProvider.credential(
      //       verificationId: authState.verificationId.value,
      //       smsCode: verifyCodeController.text,
      //     );
      //     await FirebaseAuth.instance.signInWithCredential(credential);
      //     processWhenSuccess();
      //     // context.navigateTo(AppRoutes.enterPasswordForgotPassword);
      //     globalController.hideLoading();
      //   }
      // } catch (e) {
      //   if (e.toString().contains('firebase_auth/channel-error')) {
      //     globalController.setWarning('Mã xác thực không đúng!');
      //   } else if (e
      //       .toString()
      //       .contains('firebase_auth/invalid-verification-code')) {
      //     globalController.setWarning('Mã xác thực không đúng!');
      //   } else {
      //     globalController.setWarning(e.toString());
      //   }
      //   globalController.hideLoading();
      // }
    }
  }

  Future<void> forgotPassword(BuildContext context) async {
    var check = true;

    if (!PasswordValidator.validate(
        passwordForgotPasswordController.text.trim())) {
      check = false;
      authState.errorPasswordForgotPassword.value =
          'password_must_contain_at_least_1_uppercase_letter_at_least_1_lowercase_letter_at_least_1_special_character_at_least_1_number_and_must_be_8_characters_or_longer'
              .tr;
    } else {
      authState.errorPasswordForgotPassword.value = '';
    }

    if (PasswordValidator.validate(
        passwordForgotPasswordController.text.trim())) {
      if (rePasswordForgotPasswordController.text.trim() !=
          passwordForgotPasswordController.text.trim()) {
        check = false;
        authState.errorRePasswordForgotPassword.value =
            'passwords_do_not_match'.tr;
      } else {
        authState.errorRePasswordForgotPassword.value = '';
      }
    }

    if (check) {
      showLoading();
      final result = await forgotPasswordUsecase(
        ForgotPasswordParams(
          phoneNumber: phoneController.text,
          password: passwordForgotPasswordController.text,
        ),
      );
      result.fold(
        (failure) {
          Log.info("fail");
          showError(
            () => clearError(),
            failure.message,
            'come_back'.tr,
          );
        },
        (success) {
          Log.info("success");
          showWarning(
            () {
              Log.info("go to login");
              // context.offAllNamedScreen(AppRoutes.login);
              clearWarning();
              context.backToFirstScreen();
            },
            'password_changed_successfully'.tr,
            'sign_in_now'.tr,
          );
          Log.severe("$success");
          // clearError();
        },
      );
      hideLoading();
    }
  }

  Future<void> register(BuildContext context) async {
    showLoading();
    Log.info(authState.wardId.value.toString());
    Log.info(authState.genderId.value.toString());
    final inputFormat = DateFormat('dd/MM/yyyy');
    final date = inputFormat.parse(birthdateController.text);

    // Create a DateFormat for the output format
    final outputFormat = DateFormat('yyyy-MM-dd');
    final newDateStr = outputFormat.format(date);
    final result = await registerUsecase(
      RegisterParams(
        phoneNumber: phoneController.text,
        name: fullNameController.text,
        email: emailController.text,
        address: addressController.text,
        wardId: authState.wardId.value,
        gender: authState.genderId.value,
        birthdate: newDateStr,
        bhytCode: bhytController.text,
        password: passwordRegisterController.text,
        role: 'Patient',
      ),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        showError(
          () => clearError(),
          failure.message,
          'come_back'.tr,
        );
      },
      (success) async {
        final result = await createMedicalHistoryUsecase(
          CreateMedicalHistoryParams(
            patientId: success.patientId,
            hypertension: authState.hypertension.value,
            diabetes: authState.diabetes.value,
            heartDisease: authState.heartDisease.value,
            stroke: authState.stroke.value,
            asthma: authState.asthma.value,
            epilepsy: authState.epilepsy.value,
            copd: authState.copd.value,
            palpitations: authState.palpitations.value,
            otherMedicalHistory: anotherController.text,
          ),
        );
        Log.info(result.toString());
        result.fold(
          (failure) {
            Log.severe("$failure");
            showError(
              () => clearError(),
              failure.message,
              'come_back'.tr,
            );
          },
          (success) {
            authState.city.value = null;
            authState.district.value = null;
            authState.ward.value = null;
            authState.selectedGender.value = '';
            authState.listAllWard.value = [];
            authState.listAllDistrict.value = [];
            getAllCity();
            showWarning(
              () {
                Log.info("go to login");

                context.backToFirstScreen();
                clearWarning();
              },
              'account_created_successfully'.tr,
              'sign_in_now'.tr,
            );
          },
        );
        Log.severe("$success");
        clearError();
      },
    );
    hideLoading();
  }

  Future<void> changePassword(BuildContext context) async {
    var check = true;

    if (!PasswordValidator.validate(oldChangePasswordController.text.trim())) {
      check = false;
      authState.errorOldPasswordChangePassword.value =
          'Mật khẩu phải có it nhất 1 chữ cái viết hoa, 1 chữ cái viết thường, 1 kí tự đặc biệt, 1 chữ số, phải có độ dài từ 8 kí tự trở lên';
    } else {
      authState.errorOldPasswordChangePassword.value = '';
    }

    if (!PasswordValidator.validate(newChangePasswordController.text.trim())) {
      check = false;
      authState.errorNewPasswordChangePassword.value =
          'Mật khẩu phải có it nhất 1 chữ cái viết hoa, 1 chữ cái viết thường, 1 kí tự đặc biệt, 1 chữ số, phải có độ dài từ 8 kí tự trở lên';
    } else {
      authState.errorNewPasswordChangePassword.value = '';
      if (reNewChangePasswordController.text.trim() !=
          newChangePasswordController.text.trim()) {
        check = false;
        authState.errorReNewPasswordChangePassword.value =
            'passwords_do_not_match'.tr;
      } else {
        authState.errorReNewPasswordChangePassword.value = '';
      }
    }

    if (check) {
      showLoading();
      final result = await changePasswordUsecase(
        ChangePasswordParams(
          oldPassword: oldChangePasswordController.text,
          newPassword: newChangePasswordController.text,
        ),
      );
      result.fold(
        (failure) {
          showError(
            () => clearError(),
            failure.message,
            'come_back'.tr,
          );
        },
        (success) {
          Log.info("success: $success");
          if (success.code == 1) {
            showWarning(
              () async {
                var auth = AuthEntity(
                  accessToken: '',
                  expiresIn: -1,
                  refreshToken: '',
                  firstTimeOpenApp: 'false',
                );
                context.backScreen();
                final result2 = await saveAuthToLocalUsecase(
                  SaveAuthToLocalParams(auth: auth),
                );
                result2.fold(
                  (failure2) {
                    Log.severe("$failure2");
                    showError(
                      () => clearError(),
                      failure2.message,
                      'come_back'.tr,
                    );
                  },
                  (success2) {
                    setAuth(auth);
                    final MainController mainController =
                        Get.find<MainController>();
                    mainController.changePage(0);
                    clearWarning();
                  },
                );
              },
              'password_changed_successfully'.tr,
              'sign_in_now'.tr,
            );
          } else {
            showWarning(
              () {
                Log.info("go to login");
                // context.offAllNamedScreen(AppRoutes.login);
                clearWarning();
              },
              success.message,
              'close'.tr,
            );
          }
        },
      );
      hideLoading();
    }
  }
}
