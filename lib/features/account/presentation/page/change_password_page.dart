import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';

class ChangePasswordPage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  final AuthController authController = Get.find<AuthController>();
  ChangePasswordPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.hp(12),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D4E96), Color(0xFF1C75D8)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Align(
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
                    'change_password'.tr,
                    style: AppTextStyle.appBar(context),
                  ),
                  const Spacer(),
                  SizedBox(
                    height: context.hp(7),
                    width: context.wp(16),
                  ),
                ],
              ),
            ).paddingOnly(top: context.hp(4)),
          ),
          SizedBox(height: context.hp(3)),
          CustomTextFieldWidget(
            labelText: 'old_password'.tr,
            controller: authController.oldChangePasswordController,
            type: TextFieldType.password,
            errorText: authController.authState.errorOldPasswordChangePassword,
          ).paddingSymmetric(horizontal: context.wp(4)),
          CustomTextFieldWidget(
            labelText: 'new_password'.tr,
            controller: authController.newChangePasswordController,
            type: TextFieldType.password,
            errorText: authController.authState.errorNewPasswordChangePassword,
          ).paddingSymmetric(horizontal: context.wp(4)),
          CustomTextFieldWidget(
            labelText: 'confirm_new_password'.tr,
            controller: authController.reNewChangePasswordController,
            type: TextFieldType.password,
            errorText:
                authController.authState.errorReNewPasswordChangePassword,
          ).paddingSymmetric(horizontal: context.wp(4)),
          const Spacer(),
          CustomButtonWidget(
            height: context.hp(6),
            width: context.wp(100),
            title: "update".tr,
            onPressed: () async {
              FocusScope.of(context).unfocus();
              authController.changePassword(context);
            },
            color: const Color(0xffCF4375),
            titleSize: context.sp(14),
            radius: context.rp(10),
            fontWeight: FontWeight.w600,
          ).paddingSymmetric(horizontal: context.wp(4)),
          context.wp(2).sbh,
        ],
      ),
    );
  }
}
