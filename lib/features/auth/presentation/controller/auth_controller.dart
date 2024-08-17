import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
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
import 'package:medi_express_patients/features/auth/domain/usecases/get_user_information_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_ward_by_district_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/register_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/save_auth_to_local_usecase.dart';
import 'package:medi_express_patients/features/auth/presentation/state/auth_state.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
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
  final SaveAuthToLocalUsecase saveAuthToLocalUsecase;
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
            'Số điện thoại không được để trống';
      } else if (!PhoneValidator.validate(phoneController.text.trim())) {
        authState.errorPhoneForgotPassword.value =
            'Định dạng số điện thoại không hợp lệ';
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
              'Quay lại',
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
                'Số điện thoại chưa được đăng kí',
                'Quay lại',
              );
            }
          },
        );
      }
    } catch (e) {
      showError(
        () => clearError(),
        e.toString(),
        'Quay lại',
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> sendOtpRegister(BuildContext context) async {
    try {
      showLoading();
      if (phoneController.text.trim().isEmpty) {
        authState.errorPhoneRegister.value =
            'Số điện thoại không được để trống';
      } else if (!PhoneValidator.validate(phoneController.text.trim())) {
        authState.errorPhoneRegister.value =
            'Định dạng số điện thoại không hợp lệ';
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
              'Quay lại',
            );
          },
          (success) {
            if (success) {
              showError(
                () => clearError(),
                'Số điện thoại đã được đăng kí',
                'Quay lại',
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
        'Quay lại',
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
            'Vui lòng nhập mã xác thực';
      } else if (verifyCodeController.text.trim().length != 6) {
        authState.errorVerifyCodeForgotPassword.value =
            'Mã xác thực không hợp lệ';
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
                'Mã xác thực không chính xác';
          }
        } else {
          authState.errorVerifyCodeForgotPassword.value =
              'Hết thời gian xác thực vui lòng gửi lại mã';
        }
      }
    } catch (e) {
      showError(
        () => clearError(),
        e.toString(),
        'Quay lại',
      );
    } finally {
      hideLoading();
    }
  }

  Future<void> verifyOtpRegister(BuildContext context) async {
    try {
      showLoading();
      if (verifyCodeController.text.trim().isEmpty) {
        authState.errorVerifyCodeRegister.value = 'Vui lòng nhập mã xác thực';
      } else if (verifyCodeController.text.trim().length != 6) {
        authState.errorVerifyCodeRegister.value = 'Mã xác thực không hợp lệ';
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
                'Mã xác thực không chính xác';
          }
        } else {
          authState.errorVerifyCodeRegister.value =
              'Hết thời gian xác thực vui lòng gửi lại mã';
        }
      }
    } catch (e) {
      showError(
        () => clearError(),
        e.toString(),
        'Quay lại',
      );
    } finally {
      hideLoading();
    }
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
        'Quay lại',
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
          'Quay lại',
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
          'Quay lại',
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
          'Quay lại',
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
      authState.errorPhoneLogin.value = 'Số điện thoại không được để trống';
    } else if (!PhoneValidator.validate(phoneController.text.trim())) {
      isError = true;
      authState.errorPhoneLogin.value = 'Định dạng số điện thoại không hợp lệ';
    } else {
      authState.errorPhoneLogin.value = '';
    }
    if (passwordLoginController.text.trim().isEmpty) {
      isError = true;
      authState.errorPasswordLogin.value = 'Mật khẩu không được để trống';
    } else if (passwordLoginController.text.trim().length < 8) {
      isError = true;
      authState.errorPasswordLogin.value =
          'Mật khẩu phải có độ dài lớn hơn 8 kí tự';
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
            'Quay lại',
          );
        },
        (successLogin) async {
          final result = await getUserInformationUsecase(NoParams());
          result.fold(
            (failureGetUserInformation) {
              Log.severe("$failureGetUserInformation");
              showError(
                () => clearError(),
                failureGetUserInformation.message,
                'Quay lại',
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
            'Quay lại',
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
    }, 'Đăng xuất tài khoản', 'Đồng ý');
  }

  Future<void> enterInformation(BuildContext context) async {
    bool isError = false;
    if (fullNameController.text.trim().isEmpty) {
      isError = true;
      authState.errorFullName.value = 'Họ tên không được để trống';
    } else {
      authState.errorFullName.value = '';
    }

    if (!EmailValidator.validate(emailController.text.trim())) {
      isError = true;
      authState.errorEmail.value = 'Định dạng email không hợp lệ';
    } else {
      authState.errorEmail.value = '';
    }

    if (birthdateController.text.trim().isEmpty) {
      isError = true;
      authState.errorBirthdate.value = 'Ngày sinh không được để trống';
    } else {
      authState.errorBirthdate.value = '';
    }

    if (genderController.text.trim().isEmpty) {
      isError = true;
      authState.errorGender.value = 'Giới tính không được để trống';
    } else {
      authState.errorGender.value = '';
    }

    if (cityController.text.trim().isEmpty) {
      isError = true;
      authState.errorCity.value = 'Tỉnh/Thành phố không được để trống';
    } else {
      authState.errorCity.value = '';
    }

    if (districtController.text.trim().isEmpty) {
      isError = true;
      authState.errorDistrict.value = 'Quận/Huyện không được để trống';
    } else {
      authState.errorDistrict.value = '';
    }

    if (wardController.text.trim().isEmpty) {
      isError = true;
      authState.errorWard.value = 'Phường/Xã không được để trống';
    } else {
      authState.errorWard.value = '';
    }

    if (addressController.text.trim().isEmpty) {
      isError = true;
      authState.errorAddress.value = 'Đại chỉ cụ thể không được để trống';
    } else {
      authState.errorAddress.value = '';
    }

    if (bhytController.text.trim().isEmpty) {
      isError = true;
      authState.errorBhyt.value = 'Sổ bảo hiểm y tế không được để trống';
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
          'Vui lòng điền mã xác thực';
      authState.errorVerifyCodeRegister.value = 'Vui lòng điền mã xác thực';
    } else if (verifyCodeController.text.trim().length < 6) {
      isError = true;
      authState.errorVerifyCodeForgotPassword.value =
          'Mã xác thực phải có 6 chữ số';
      authState.errorVerifyCodeRegister.value = 'Mã xác thực phải có 6 chữ số';
    } else if (verifyCodeController.text.trim() != "123456") {
      isError = true;
      authState.errorVerifyCodeForgotPassword.value =
          'Mã xác thực không chính xác';
      authState.errorVerifyCodeRegister.value = 'Mã xác thực phải có 6 chữ số';
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
          'Mật khẩu phải có it nhất 1 chữ cái viết hoa, phải có ít nhất 1 chữ cái viết thường, phải có ít nhất một kí tự đặc biệt, phải có ít nhất 1 chữ số, phải có độ dài từ 8 kí tự trở lên';
    } else {
      authState.errorPasswordForgotPassword.value = '';
    }

    if (PasswordValidator.validate(
        passwordForgotPasswordController.text.trim())) {
      if (rePasswordForgotPasswordController.text.trim() !=
          passwordForgotPasswordController.text.trim()) {
        check = false;
        authState.errorRePasswordForgotPassword.value =
            'Mật khẩu không trùng khớp';
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
            'Quay lại',
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
            'Thay đổi mật khẩu thành công',
            'Đăng nhập ngay',
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
    final result = await registerUsecase(
      RegisterParams(
        phoneNumber: phoneController.text,
        name: fullNameController.text,
        email: emailController.text,
        address: addressController.text,
        wardId: authState.wardId.value,
        gender: authState.genderId.value,
        birthdate: birthdateController.text,
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
          'Quay lại',
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
              'Quay lại',
            );
          },
          (success) {
            showWarning(
              () {
                Log.info("go to login");
                context.backToFirstScreen();
                clearWarning();
              },
              'Tạo tài khoản thành công',
              'Đăng nhập ngay',
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
            'Mật khẩu không trùng khớp';
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
            'Quay lại',
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
                      'Quay lại',
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
              'Thay đổi mật khẩu thành công',
              'Đăng nhập ngay',
            );
          } else {
            showWarning(
              () {
                Log.info("go to login");
                // context.offAllNamedScreen(AppRoutes.login);
                clearWarning();
              },
              success.message,
              'Đóng',
            );
          }
        },
      );
      hideLoading();
    }
  }
}
