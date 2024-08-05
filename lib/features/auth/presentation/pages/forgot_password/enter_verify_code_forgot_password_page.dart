import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/service/notification_service.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:pinput/pinput.dart';

class EnterVerifyCodeForgotPasswordPage extends BaseStatelessWidget {
  EnterVerifyCodeForgotPasswordPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _content(context, authController),
    );
  }

  Stack _content(BuildContext context, AuthController authController) {
    return Stack(
      children: [
        _header(context, authController),
        _body(context, authController),
      ],
    );
  }

  Positioned _body(BuildContext context, AuthController authController) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.rp(26)),
            topRight: Radius.circular(context.rp(26)),
          ),
        ),
        height: context.hp(88),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
          child: Column(
            children: [
              SizedBox(height: context.hp(4)),
              Text(
                'Nhập mã xác thực',
                style: AppTextStyle.mediumTitle(context),
              ),
              SizedBox(height: context.hp(1)),
              Text(
                'Mã xác thực OTP đã được gửi về số điện thoại của bạn',
                style: AppTextStyle.bigHint(context),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.hp(3)),
              Pinput(
                length: 6, // Number of digits
                controller: authController.verifyCodeController,
                onCompleted: (pin) {
                  authController.verifyCodeController.text = pin;
                },
                defaultPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(
                    fontSize: context.sp(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
                focusedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(
                    fontSize: context.sp(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.blue),
                  ),
                ),
                submittedPinTheme: PinTheme(
                  width: 56,
                  height: 56,
                  textStyle: TextStyle(
                    fontSize: context.sp(20),
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                ),
              ),
              SizedBox(height: context.hp(0.6)),
              Obx(() {
                if (authController
                    .authState.errorVerifyCodeForgotPassword.isEmpty) {
                  return const SizedBox.shrink();
                } else {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      authController
                          .authState.errorVerifyCodeForgotPassword.value,
                      style: AppTextStyle.mediumError(context),
                    ),
                  );
                }
              }),
              SizedBox(height: context.hp(1.4)),
              Row(
                children: [
                  Obx(() {
                    if (authController
                            .authState.timeoutConfirmVerifyCode.value ==
                        0) {
                      return const SizedBox.shrink();
                    } else {
                      return Text(
                        'Gửi lại mã (0:${authController.authState.timeoutConfirmVerifyCode}s)',
                        style: AppTextStyle.mediumBody(context),
                      );
                    }
                  }),
                  const Spacer(),
                  Obx(() {
                    if (authController
                            .authState.timeoutConfirmVerifyCode.value ==
                        0) {
                      return GestureDetector(
                        onTap: () {
                          authController.resendOtp(context);
                        },
                        child: Text(
                          'Gửi lại mã',
                          style: AppTextStyle.link(context),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                ],
              ),
              SizedBox(height: context.hp(2)),
              CustomButtonWidget(
                height: context.hp(6),
                width: context.wp(100),
                title: "Xác nhận",
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  authController.verifyOtpForgotPassword(context);
                  // authController.sendOtp();
                  // NotificationService().showNotification(
                  //     title: 'Sample title', body: 'It works!');
                  // authController.sendOtpDemo(() {
                  //   authController.authState.errorPasswordForgotPassword.value = '';
                  //   authController.authState.errorRePasswordForgotPassword.value =
                  //       '';
                  //   authController.passwordForgotPasswordController.text = '';
                  //   authController.rePasswordForgotPasswordController.text = '';
                  //   // context.navigateTo(AppRoutes.enterPasswordForgotPassword);
                  // });
                  // authController.verifyCode(() {
                  //   authController.authState.errorPasswordForgotPassword.value = '';
                  //   authController.authState.errorRePasswordForgotPassword.value =
                  //       '';
                  //   authController.passwordForgotPasswordController.text = '';
                  //   authController.rePasswordForgotPasswordController.text = '';
                  //   // context.navigateTo(AppRoutes.enterPasswordForgotPassword);
                  // });
                },
                color: const Color(0xffCF4375),
                titleSize: context.sp(14),
                radius: context.rp(10),
                fontWeight: FontWeight.w600,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Positioned _header(BuildContext context, AuthController authController) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D4E96), Color(0xFF1C75D8)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        height: context.hp(19),
        child: Stack(
          children: [
            Transform.rotate(
              angle: -0.04,
              child: Transform.translate(
                offset: const Offset(0, 10),
                child: Image.asset(
                  Assets.png.backgroundTop4x,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.backScreen();
                    },
                    child: Container(
                      height: context.hp(7),
                      width: context.wp(16),
                      color: Colors.transparent,
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Quên mật khẩu',
                    style: AppTextStyle.appBar(context),
                  ),
                  const Spacer(),
                  SizedBox(width: context.wp(16)),
                ],
              ),
            ).paddingOnly(top: context.hp(4)),
          ],
        ),
      ),
    );
  }
}
