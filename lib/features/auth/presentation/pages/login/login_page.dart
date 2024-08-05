import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/routes/app_routes.dart';
import '../../controller/auth_controller.dart';

class LoginPage extends BaseStatelessWidget {
  LoginPage({super.key});

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
        _header(context),
        _body(context, authController),
        _footer(context, authController),
      ],
    );
  }

  Positioned _footer(BuildContext context, AuthController authController) {
    return Positioned(
      bottom: context.hp(2),
      left: 0,
      right: 0,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            'Chưa có tài khoản?',
            style: AppTextStyle.smallTitle(context),
          ),
          GestureDetector(
            child: Container(
              height: context.hp(6),
              width: context.wp(28),
              color: Colors.transparent,
              child: Center(
                child: Text(
                  'Đăng kí ngay',
                  style: AppTextStyle.link(context),
                ),
              ),
            ),
            onTap: () {
              Log.info("message");
              // authController.phoneController.text = '';
              // authController.authState.errorPhoneRegister.value = '';
              context.toNamedScreen(AppRoutes.enterPhoneNumberRegister);
            },
          ),
        ],
      ),
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
            topRight: Radius.circular(
              context.rp(26),
            ),
          ),
        ),
        height: context.hp(86),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.wp(5)),
          child: Column(
            children: [
              context.hp(4).sbh,
              _titleBody(context),
              context.hp(3).sbh,
              CustomTextFieldWidget(
                labelText: 'Số điện thoại',
                controller: authController.phoneController,
                type: TextFieldType.phone,
                errorText: authController.authState.errorPhoneLogin,
              ),
              CustomTextFieldWidget(
                labelText: 'Mật khẩu',
                controller: authController.passwordLoginController,
                type: TextFieldType.password,
                errorText: authController.authState.errorPasswordLogin,
              ),
              context.hp(1).sbh,
              CustomButtonWidget(
                height: context.hp(6),
                width: context.wp(100),
                title: "Đăng nhập",
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  authController.login(context);
                },
                color: const Color(0xffCF4375),
                titleSize: context.sp(14),
                radius: context.rp(10),
                fontWeight: FontWeight.w600,
              ),
              GestureDetector(
                onTap: () async {
                  authController.phoneController.text = '';
                  authController.passwordLoginController.text = '';
                  authController.authState.errorPhoneLogin.value = '';
                  authController.authState.errorPasswordLogin.value = '';
                  authController.authState.errorPhoneForgotPassword.value = '';
                  context.toNamedScreen(
                    AppRoutes.enterPhoneNumberForgotPassword,
                  );
                },
                child: Container(
                  height: context.hp(6),
                  width: context.wp(36),
                  color: Colors.transparent,
                  child: Center(
                    child: Text(
                      'Quên mật khẩu?',
                      style: AppTextStyle.link(context),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              context.hp(8).sbh,
            ],
          ),
        ),
      ),
    );
  }

  Text _titleBody(BuildContext context) {
    return Text(
      'Đăng nhập',
      style: AppTextStyle.mediumTitle(context),
    );
  }

  Positioned _header(BuildContext context) {
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
        height: context.hp(23),
        child: Stack(
          children: [
            _backgroundHeader(),
            _logoHeader(context).paddingOnly(top: context.hp(4.8)),
          ],
        ),
      ),
    );
  }

  Align _logoHeader(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Image.asset(
        Assets.png.logo2x,
        width: context.wp(44),
      ),
    );
  }

  Transform _backgroundHeader() {
    return Transform.rotate(
      angle: -0.04,
      child: Transform.translate(
        offset: const Offset(0, 10),
        child: Image.asset(
          Assets.png.backgroundTop4x,
        ),
      ),
    );
  }
}
