import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/core/utils/validators/password_validator.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class EnterPasswordRegisterPage extends BaseStatelessWidget {
  EnterPasswordRegisterPage({super.key});

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
                'Tạo mật khẩu đăng nhập',
                style: AppTextStyle.mediumTitle(context),
              ),
              SizedBox(height: context.hp(3)),
              CustomTextFieldWidget(
                labelText: 'Mật khẩu mới',
                controller: authController.passwordRegisterController,
                type: TextFieldType.password,
                errorText: authController.authState.errorPasswordRegister,
              ),
              CustomTextFieldWidget(
                labelText: 'Xác nhận mật khẩu mới',
                controller: authController.rePasswordRegisterController,
                type: TextFieldType.password,
                errorText: authController.authState.errorRePasswordRegister,
              ),
              CustomButtonWidget(
                height: context.hp(6),
                width: context.wp(100),
                title: "Xác nhận",
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  authController.fullNameController.text = '';
                  authController.emailController.text = '';
                  authController.birthdateController.text = '';
                  authController.genderController.text = '';
                  authController.cityController.text = '';
                  authController.districtController.text = '';
                  authController.wardController.text = '';
                  authController.addressController.text = '';
                  authController.bhytController.text = '';

                  authController.authState.errorFullName.value = '';
                  authController.authState.errorEmail.value = '';
                  authController.authState.errorBirthdate.value = '';
                  authController.authState.errorGender.value = '';
                  authController.authState.errorCity.value = '';
                  authController.authState.errorDistrict.value = '';
                  authController.authState.errorWard.value = '';
                  authController.authState.errorAddress.value = '';
                  authController.authState.errorBhyt.value = '';

                  var validateSuccess = true;
                  if (!PasswordValidator.validate(
                      authController.passwordRegisterController.text.trim())) {
                    validateSuccess = false;
                    authController.authState.errorPasswordRegister.value =
                        'Mật khẩu phải có it nhất 1 chữ cái viết hoa, phải có ít nhất 1 chữ cái viết thường, phải có ít nhất một kí tự đặc biệt, phải có ít nhất 1 chữ số, phải có độ dài từ 8 kí tự trở lên';
                  } else {
                    authController.authState.errorPasswordRegister.value = '';
                  }

                  if (PasswordValidator.validate(
                      authController.passwordRegisterController.text.trim())) {
                    if (authController.rePasswordRegisterController.text
                            .trim() !=
                        authController.passwordRegisterController.text.trim()) {
                      validateSuccess = false;
                      authController.authState.errorRePasswordRegister.value =
                          'Mật khẩu không trùng khớp';
                    } else {
                      authController.authState.errorRePasswordRegister.value = '';
                    }
                  }

                  if (validateSuccess) {
                    FocusScope.of(context).unfocus();
                    context.toNamedScreen(AppRoutes.enterInformationRegister);
                    authController.getAllCity();
                  }
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
                      authController.phoneController.text = '';
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
                    'Đăng kí tài khoản',
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
