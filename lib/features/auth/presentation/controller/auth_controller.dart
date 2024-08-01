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
import 'package:medi_express_patients/features/auth/domain/params/change_password_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/create_medical_history_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/forgot_password_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_district_by_city_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/get_ward_by_district_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/login_params.dart';
import 'package:medi_express_patients/features/auth/domain/params/register_params.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/create_medical_history_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/forgot_password_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_all_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_district_by_city_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/get_ward_by_district_usecase.dart';
import 'package:medi_express_patients/features/auth/domain/usecases/register_usecase.dart';
import 'package:medi_express_patients/features/base/presentation/controller/base_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';
import '../../domain/usecases/login_usecase.dart';
import '../state/auth_state.dart';

class AuthController extends BaseController {
  @override
  final AuthState state = AuthState();
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final ChangePasswordUsecase changePasswordUsecase;
  final ForgotPasswordUsecase forgotPasswordUsecase;
  final GetAllCityUsecase getAllCityUsecase;
  final GetDistrictByCityUsecase getDistrictByCityUsecase;
  final GetWardByDistrictUsecase getWardByDistrictUsecase;
  final CreateMedicalHistoryUsecase createMedicalHistoryUsecase;

  final TextEditingController phoneController = TextEditingController();
  final TextEditingController verifyCodeController = TextEditingController();
  final TextEditingController passwordLoginController = TextEditingController();
  final TextEditingController passwordRegisterController =
      TextEditingController();
  final TextEditingController rePasswordRegisterController =
      TextEditingController();
  final TextEditingController passwordForgotPasswordController =
      TextEditingController();
  final TextEditingController rePasswordForgotPasswordController =
      TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdateController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController wardController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController bhytController = TextEditingController();
  final TextEditingController anotherController = TextEditingController();

  Timer? _timer;

  void startTimeout() {
    // Reset the timer if it already exists
    _timer?.cancel();
    state.timeoutConfirmVerifyCode.value = 30; // Reset the countdown value
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timeoutConfirmVerifyCode.value > 0) {
        state.timeoutConfirmVerifyCode.value--;
      } else {
        timer.cancel();
        // Handle timeout logic here
        onTimeout();
      }
    });
  }

  // Function to handle timeout
  void onTimeout() {
    // Add your timeout handling logic here
    print('Verification code timeout');
  }

  AuthController({
    required this.loginUsecase,
    required this.forgotPasswordUsecase,
    required this.registerUsecase,
    required this.changePasswordUsecase,
    required this.getAllCityUsecase,
    required this.getDistrictByCityUsecase,
    required this.getWardByDistrictUsecase,
    required this.createMedicalHistoryUsecase,
    required ErrorHandlingService errorHandlingService,
  }) : super(errorHandlingService);

  Future<void> initial() async {
    // Log.info("Loading initial data...");
    // final GlobalController globalController = Get.find<GlobalController>();

    // final isTheFirstTimeOpenApp =
    //     await getIsTheFirstTimeOpenAppUsecase(NoParams());
    // isTheFirstTimeOpenApp.fold(
    //   (failure) {
    //     globalController.state.isTheFirstTimeOpenApp.value = '';
    //     Log.severe("$failure");
    //     handleFailure(failure);
    //   },
    //   (success) async {
    //     if (success.isEmpty) {
    //       globalController.state.isTheFirstTimeOpenApp.value = '';
    //       Log.severe("is the first time empty");
    //       // context.navigateTo(AppRoutes.login);
    //     } else {
    //       globalController.state.isTheFirstTimeOpenApp.value = success;
    //       Log.severe("is the first time not empty: $success");
    //       // Get.offAllNamed('/bottom_bar_navigation');
    //       // context.navigateTo(AppRoutes.bottomBarNavigation);
    //       final accessToken = await getAccessTokenUsecase(NoParams());
    //       accessToken.fold(
    //         (failure) {
    //           globalController.state.accessToken.value = '';
    //           Log.severe("$failure");
    //           handleFailure(failure);
    //         },
    //         (success) {
    //           if (success.isEmpty) {
    //             globalController.state.accessToken.value = '';
    //             Log.severe("access token empty");
    //             // context.navigateTo(AppRoutes.login);
    //           } else {
    //             globalController.state.accessToken.value = success;
    //             Log.severe("access token ne: $success");
    //             // Get.offAllNamed('/bottom_bar_navigation');
    //             // context.navigateTo(AppRoutes.bottomBarNavigation);
    //           }
    //           clearError();
    //         },
    //       );
    //     }
    //     clearError();
    // //   },
    // );

    FlutterNativeSplash.remove();

    // final refreshToken = await getRefreshTokenUsecase(NoParams());
    // accessToken.fold(
    //   (failure) {
    //     Log.severe("$failure");
    //     handleFailure(failure);
    //   },
    //   (success) {
    //     if (success.isEmpty) {
    //       Get.offAllNamed(AppRoutes.login);
    //     } else {
    //       Get.offAllNamed(AppRoutes.bottomBarNavigation);
    //     }
    //     Log.severe("access token ne: $success");
    //     clearError();
    //   },
    // );

    // final exprireIn = await getExprireInUsecase(NoParams());
    // accessToken.fold(
    //   (failure) {
    //     Log.severe("$failure");
    //     handleFailure(failure);
    //   },
    //   (success) {
    //     if (success.isEmpty) {
    //       Get.offAllNamed(AppRoutes.login);
    //     } else {
    //       Get.offAllNamed(AppRoutes.bottomBarNavigation);
    //     }
    //     Log.severe("access token ne: $success");
    //     clearError();
    //   },
    // );
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    // phoneController.dispose();
    // verifyCodeController.dispose();
    // passwordLoginController.dispose();
    // passwordRegisterController.dispose();
    // rePasswordRegisterController.dispose();
    // passwordForgotPasswordController.dispose();
    // rePasswordForgotPasswordController.dispose();
    // _timer?.cancel();
    super.onClose();
  }

  Future<void> sendOtpForgotPassword(BuildContext context) async {
    try {
      setLoading(true);
      if (phoneController.text.trim().isEmpty) {
        state.errorPhoneForgotPassword.value =
            'Số điện thoại không được để trống';
      } else if (!PhoneValidator.validate(phoneController.text.trim())) {
        state.errorPhoneForgotPassword.value =
            'Định dạng số điện thoại không hợp lệ';
      } else {
        state.errorPhoneForgotPassword.value = '';
        verifyCodeController.text = '';
        state.errorVerifyCodeForgotPassword.value = '';
        context.toNamedScreen(
          AppRoutes.enterVerifyCodeForgotPassword,
        );
        final random = Random();
        final verifyCode = 100000 + random.nextInt(900000);
        state.verifyCode.value = verifyCode;
        NotificationService().showNotification(
            title: 'Medi Express Verify Code', body: '$verifyCode');
        state.verifyCode.value = verifyCode;
        startTimeout();
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> sendOtpRegister(BuildContext context) async {
    try {
      setLoading(true);
      if (phoneController.text.trim().isEmpty) {
        state.errorPhoneRegister.value = 'Số điện thoại không được để trống';
      } else if (!PhoneValidator.validate(phoneController.text.trim())) {
        state.errorPhoneRegister.value = 'Định dạng số điện thoại không hợp lệ';
      } else {
        state.errorPhoneRegister.value = '';
        verifyCodeController.text = '';
        state.errorVerifyCodeRegister.value = '';
        context.toNamedScreen(
          AppRoutes.enterVerifyCodeRegister,
        );
        final random = Random();
        final verifyCode = 100000 + random.nextInt(900000);
        state.verifyCode.value = verifyCode;
        NotificationService().showNotification(
            title: 'Medi Express Verify Code', body: '$verifyCode');
        state.verifyCode.value = verifyCode;
        startTimeout();
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> verifyOtpForgotPassword(BuildContext context) async {
    try {
      setLoading(true);
      if (verifyCodeController.text.trim().isEmpty) {
        state.errorVerifyCodeForgotPassword.value = 'Vui lòng nhập mã xác thực';
      } else if (verifyCodeController.text.trim().length != 6) {
        state.errorVerifyCodeForgotPassword.value = 'Mã xác thực không hợp lệ';
      } else {
        state.errorVerifyCodeForgotPassword.value = '';
        state.errorPasswordForgotPassword.value = '';
        state.errorRePasswordForgotPassword.value = '';
        passwordForgotPasswordController.text = '';
        rePasswordForgotPasswordController.text = '';
        if (state.timeoutConfirmVerifyCode.value > 0) {
          if (verifyCodeController.text == state.verifyCode.value.toString()) {
            context.toNamedScreen(
              AppRoutes.enterPasswordForgotPassword,
            );
          } else {
            state.errorVerifyCodeForgotPassword.value =
                'Mã xác thực không chính xác';
          }
        } else {
          state.errorVerifyCodeForgotPassword.value =
              'Hết thời gian xác thực vui lòng gửi lại mã';
        }
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> verifyOtpRegister(BuildContext context) async {
    try {
      setLoading(true);
      if (verifyCodeController.text.trim().isEmpty) {
        state.errorVerifyCodeRegister.value = 'Vui lòng nhập mã xác thực';
      } else if (verifyCodeController.text.trim().length != 6) {
        state.errorVerifyCodeRegister.value = 'Mã xác thực không hợp lệ';
      } else {
        state.errorVerifyCodeRegister.value = '';
        state.errorPasswordRegister.value = '';
        state.errorRePasswordRegister.value = '';
        passwordRegisterController.text = '';
        rePasswordRegisterController.text = '';
        if (state.timeoutConfirmVerifyCode.value > 0) {
          if (verifyCodeController.text == state.verifyCode.value.toString()) {
            context.toNamedScreen(
              AppRoutes.enterPasswordRegister,
            );
          } else {
            state.errorVerifyCodeRegister.value = 'Mã xác thực không chính xác';
          }
        } else {
          state.errorVerifyCodeRegister.value =
              'Hết thời gian xác thực vui lòng gửi lại mã';
        }
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> resendOtp(BuildContext context) async {
    try {
      setLoading(true);
      verifyCodeController.text = '';
      final random = Random();
      final verifyCode = 100000 + random.nextInt(900000);
      state.verifyCode.value = verifyCode;
      state.errorVerifyCodeForgotPassword.value = '';
      state.errorVerifyCodeRegister.value = '';
      NotificationService().showNotification(
          title: 'Medi Express Verify Code', body: '$verifyCode');
      state.verifyCode.value = verifyCode;
      startTimeout();
    } catch (e) {
      setError(e.toString());
    } finally {
      setLoading(false);
    }
  }

  Future<void> getAllCity() async {
    setLoading(true);
    final result = await getAllCityUsecase(NoParams());
    result.fold(
      (failure) {
        Log.severe("$failure");
        setError(failure.message);
      },
      (success) {
        state.listAllCity.value = success;
        Log.severe("$success");
        clearError();
      },
    );
    setLoading(false);
  }

  Future<void> getAllDistrict() async {
    // final result = await getAllDistrictUsecase(NoParams());
    // result.fold(
    //   (failure) {
    //     Log.severe("$failure");
    //     handleFailure(failure);
    //   },
    //   (success) {
    //     state.listAllDistrict.value = success;
    //     Log.severe("$success");
    //     clearError();
    //   },
    // );
  }

  Future<void> getAllWard() async {
    // final result = await getAllWardUsecase(NoParams());
    // result.fold(
    //   (failure) {
    //     Log.severe("$failure");
    //     handleFailure(failure);
    //   },
    //   (success) {
    //     state.listAllWard.value = success;
    //     Log.severe("$success");
    //     clearError();
    //   },
    // );
  }

  Future<void> getDistrictByCity(int cityId) async {
    setLoading(true);
    final result =
        await getDistrictByCityUsecase(GetDistrictByCityParams(cityId: cityId));
    result.fold(
      (failure) {
        Log.severe("$failure");
        setError(failure.message);
      },
      (success) {
        state.listAllDistrict.value = success;
        Log.severe("$success");
        clearError();
      },
    );
    setLoading(false);
  }

  Future<void> getWardByDistrict(int districtId) async {
    setLoading(true);
    final result = await getWardByDistrictUsecase(
        GetWardByDistrictParams(districtId: districtId));
    result.fold(
      (failure) {
        Log.severe("$failure");
        setError(failure.message);
      },
      (success) {
        state.listAllWard.value = success;
        Log.severe("$success");
        clearError();
      },
    );
    setLoading(false);
  }

  Future<void> login(BuildContext context) async {
    bool isError = false;
    if (phoneController.text.trim().isEmpty) {
      isError = true;
      state.errorPhoneLogin.value = 'Số điện thoại không được để trống';
    } else if (!PhoneValidator.validate(phoneController.text.trim())) {
      isError = true;
      state.errorPhoneLogin.value = 'Định dạng số điện thoại không hợp lệ';
    } else {
      state.errorPhoneLogin.value = '';
    }
    if (passwordLoginController.text.trim().isEmpty) {
      isError = true;
      state.errorPasswordLogin.value = 'Mật khẩu không được để trống';
    } else if (passwordLoginController.text.trim().length < 8) {
      isError = true;
      state.errorPasswordLogin.value =
          'Mật khẩu phải có độ dài lớn hơn 8 kí tự';
    } else {
      state.errorPasswordLogin.value = '';
    }

    if (!isError) {
      setLoading(true);
      final result = await loginUsecase(
        LoginParams(
          phoneNumber: phoneController.text,
          password: passwordLoginController.text,
        ),
      );
      result.fold(
        (failure) {
          Log.severe("$failure");
          setError(failure.message);
        },
        (success) {
          // context.off
          Get.offAllNamed(AppRoutes.bottomBarNavigation);
          Log.severe("$success");
          clearError();
        },
      );
      setLoading(false);
    }
  }

  Future<void> enterInformation(BuildContext context) async {
    Log.info("click");
    bool isError = false;
    if (fullNameController.text.trim().isEmpty) {
      isError = true;
      Log.info("iff");
      state.errorFullName.value = 'Họ tên không được để trống';
    } else {
      state.errorFullName.value = '';
      Log.info("else");
    }

    if (!EmailValidator.validate(emailController.text.trim())) {
      isError = true;
      state.errorEmail.value = 'Định dạng email không hợp lệ';
    } else {
      state.errorEmail.value = '';
    }

    if (birthdateController.text.trim().isEmpty) {
      isError = true;
      state.errorBirthdate.value = 'Ngày sinh không được để trống';
    } else {
      state.errorBirthdate.value = '';
    }

    if (genderController.text.trim().isEmpty) {
      isError = true;
      state.errorGender.value = 'Giới tính không được để trống';
    } else {
      state.errorGender.value = '';
    }

    if (cityController.text.trim().isEmpty) {
      isError = true;
      state.errorCity.value = 'Tỉnh/Thành phố không được để trống';
    } else {
      state.errorCity.value = '';
    }

    if (districtController.text.trim().isEmpty) {
      isError = true;
      state.errorDistrict.value = 'Quận/Huyện không được để trống';
    } else {
      state.errorDistrict.value = '';
    }

    if (wardController.text.trim().isEmpty) {
      isError = true;
      state.errorWard.value = 'Phường/Xã không được để trống';
    } else {
      state.errorWard.value = '';
    }

    if (addressController.text.trim().isEmpty) {
      isError = true;
      state.errorAddress.value = 'Đại chỉ cụ thể không được để trống';
    } else {
      state.errorAddress.value = '';
    }

    if (bhytController.text.trim().isEmpty) {
      isError = true;
      state.errorBhyt.value = 'Sổ bảo hiểm y tế không được để trống';
    } else {
      state.errorBhyt.value = '';
    }

    if (!isError) {
      state.hypertension.value = false;
      state.diabetes.value = false;
      state.heartDisease.value = false;
      state.stroke.value = false;
      state.asthma.value = false;
      state.epilepsy.value = false;
      state.copd.value = false;
      state.palpitations.value = false;
      state.otherMedicalHistory.value = '';
      context.toNamedScreen(AppRoutes.enterAnamnesisRegister);
    }
  }

  // Future<void> sendOtp(Function() processWhenSuccess) async {
  //   // bool isError = false;
  //   // if (phoneController.text.trim().isEmpty) {
  //   //   isError = true;
  //   //   state.errorPhoneForgotPassword.value =
  //   //       'Số điện thoại không được để trống';
  //   //   state.errorPhoneRegister.value = 'Số điện thoại không được để trống';
  //   // } else if (!PhoneValidator.validate(phoneController.text.trim())) {
  //   //   isError = true;
  //   //   state.errorPhoneForgotPassword.value =
  //   //       'Định dạng số điện thoại không hợp lệ';
  //   //   state.errorPhoneRegister.value = 'Định dạng số điện thoại không hợp lệ';
  //   // } else {
  //   //   state.errorPhoneForgotPassword.value = '';
  //   //   state.errorPhoneRegister.value = '';
  //   // }

  //   // if (!isError) {
  //   //   final globalController = Get.find<GlobalController>();
  //   //   globalController.showLoading();
  //   //   try {
  //   //     globalController.showLoading();
  //   //     String phoneTmp = phoneController.text;
  //   //     if (phoneTmp.startsWith('0')) {
  //   //       phoneTmp = phoneTmp.substring(1);
  //   //     }
  //   //     Log.info("phoneAuthCredential: +84${phoneController.text}");
  //   //     await FirebaseAuth.instance.verifyPhoneNumber(
  //   //       phoneNumber: '+84${phoneController.text}',
  //   //       verificationCompleted: (phoneAuthCredential) {
  //   //         Log.info("phoneAuthCredential: $phoneAuthCredential");
  //   //         globalController.hideLoading();
  //   //       },
  //   //       verificationFailed: (error) {
  //   //         Log.info("error: $error");
  //   //         globalController.hideLoading();
  //   //         if (error
  //   //             .toString()
  //   //             .contains('firebase_auth/missing-client-identifier')) {
  //   //           globalController.setWarning(
  //   //               'Số điện thoại chưa được xác minh! [firebase_auth/missing-client-identifier]');
  //   //         } else if (error
  //   //             .toString()
  //   //             .contains('firebase_auth/too-many-requests')) {
  //   //           globalController.setWarning(
  //   //               'Hết lượt gửi mã với firebase: [firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.');
  //   //         } else {
  //   //           Log.info(error.toString());
  //   //           globalController.setWarning('Số điện thoại không hợp lệ!');
  //   //         }
  //   //       },
  //   //       codeSent: (verificationId, forceResendingToken) async {
  //   //         Log.info("code sent verificationId: $verificationId");
  //   //         state.verificationId.value = verificationId;
  //   //         // context.navigateTo(AppRoutes.enterVerifyCodeForgotPassword);
  //   //         await processWhenSuccess();
  //   //         // await Get.context!.navigateWithTransition(
  //   //         //   AppRoutes.enterVerifyCodeForgotPassword,
  //   //         //   transition: Transition.rightToLeft,
  //   //         // );
  //   //         globalController.hideLoading();
  //   //         startTimeout();
  //   //       },
  //   //       codeAutoRetrievalTimeout: (verificationId) {
  //   //         Log.info("verificationId end: $verificationId");
  //   //         globalController.hideLoading();
  //   //       },
  //   //     );
  //   //   } catch (e) {
  //   //     Log.severe("Error: $e");
  //   //   }
  //   // }
  // }

  Future<void> verifyCode(Function() processWhenSuccess) async {
    bool isError = false;
    if (verifyCodeController.text.trim().isEmpty) {
      isError = true;
      state.errorVerifyCodeForgotPassword.value = 'Vui lòng điền mã xác thực';
      state.errorVerifyCodeRegister.value = 'Vui lòng điền mã xác thực';
    } else if (verifyCodeController.text.trim().length < 6) {
      isError = true;
      state.errorVerifyCodeForgotPassword.value =
          'Mã xác thực phải có 6 chữ số';
      state.errorVerifyCodeRegister.value = 'Mã xác thực phải có 6 chữ số';
    } else if (verifyCodeController.text.trim() != "123456") {
      isError = true;
      state.errorVerifyCodeForgotPassword.value = 'Mã xác thực không chính xác';
      state.errorVerifyCodeRegister.value = 'Mã xác thực phải có 6 chữ số';
    } else {
      state.errorVerifyCodeForgotPassword.value = '';
      state.errorVerifyCodeRegister.value = '';
    }

    if (!isError) {
      // try {
      //   if (state.timeoutConfirmVerifyCode.value == 0) {
      //     globalController
      //         .setWarning('Hết thời gian xác thực, vui lòng gửi lại mã');
      //   } else {
      //     globalController.showLoading();
      //     Log.info("verificationId end: ${state.verificationId.value}");
      //     Log.info("verifyCodeController.text: ${verifyCodeController.text}");
      //     final credential = PhoneAuthProvider.credential(
      //       verificationId: state.verificationId.value,
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
      state.errorPasswordForgotPassword.value =
          'Mật khẩu phải có it nhất 1 chữ cái viết hoa, phải có ít nhất 1 chữ cái viết thường, phải có ít nhất một kí tự đặc biệt, phải có ít nhất 1 chữ số, phải có độ dài từ 8 kí tự trở lên';
    } else {
      state.errorPasswordForgotPassword.value = '';
    }

    if (PasswordValidator.validate(
        passwordForgotPasswordController.text.trim())) {
      if (rePasswordForgotPasswordController.text.trim() !=
          passwordForgotPasswordController.text.trim()) {
        check = false;
        state.errorRePasswordForgotPassword.value = 'Mật khẩu không trùng khớp';
      } else {
        state.errorRePasswordForgotPassword.value = '';
      }
    }

    if (check) {
      setLoading(true);
      final result = await forgotPasswordUsecase(
        ForgotPasswordParams(
          phoneNumber: phoneController.text,
          password: passwordForgotPasswordController.text,
        ),
      );
      result.fold(
        (failure) {
          Log.severe("$failure");
          setError(failure.message);
        },
        (success) {
          Log.info("success");
          showWarning(
            () {
              Log.info("go to login");
              context.offAllNamedScreen(AppRoutes.login);
              hideWarning();
            },
            'Thay đổi mật khẩu thành công',
            'Đăng nhập ngay',
          );
          Log.severe("$success");
          clearError();
        },
      );
      setLoading(false);
    }
  }

  Future<void> register(BuildContext context) async {
    setLoading(true);
    Log.info(state.wardId.value.toString());
    Log.info(state.genderId.value.toString());
    final result = await registerUsecase(
      RegisterParams(
        phoneNumber: phoneController.text,
        name: fullNameController.text,
        address: addressController.text,
        wardId: state.wardId.value,
        gender: state.genderId.value,
        birthdate: birthdateController.text,
        password: passwordRegisterController.text,
        role: 'Patient',
      ),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        setError(failure.message);
      },
      (success) async {
        final result = await createMedicalHistoryUsecase(
          CreateMedicalHistoryParams(
            patientId: success.patientId,
            hypertension: state.hypertension.value,
            diabetes: state.diabetes.value,
            heartDisease: state.heartDisease.value,
            stroke: state.stroke.value,
            asthma: state.asthma.value,
            epilepsy: state.epilepsy.value,
            copd: state.copd.value,
            palpitations: state.palpitations.value,
            otherMedicalHistory: anotherController.text,
          ),
        );
        Log.info(result.toString());
        result.fold(
          (failure) {
            Log.severe("$failure");
            setError(failure.message);
          },
          (success) {
            // showWarningDialog(
            //   'Đăng kí thành công',
            //   'Đăng nhập ngay',
            // );
            showWarning(
              () {
                Log.info("go to login");
                context.offAllNamedScreen(AppRoutes.login);
                hideWarning();
              },
              'Tạo tài khoản thành công',
              'Đăng nhập ngay',
            );
            clearError();
          },
        );
        Log.severe("$success");
        clearError();
      },
    );
    setLoading(false);
  }

  Future<void> changePassword() async {
    setLoading(true);
    final result = await changePasswordUsecase(
      ChangePasswordParams(
        oldPassword: passwordLoginController.text,
        newPassword: passwordLoginController.text,
      ),
    );
    result.fold(
      (failure) {
        Log.severe("$failure");
        setError(failure.message);
      },
      (success) {
        Get.offAllNamed(AppRoutes.home);
        Log.severe("$success");
        clearError();
      },
    );
    setLoading(false);
  }
}
