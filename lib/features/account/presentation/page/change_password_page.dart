import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_drop_down_box_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/home/data/model/item_patient_model.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/features/schedule/presentation/controller/schedule_controller.dart';

class ChangePasswordPage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  ChangePasswordPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                      'Thông tin cá nhân',
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
              labelText: 'Mật khẩu cũ',
              controller: authController.passwordForgotPasswordController,
              type: TextFieldType.password,
              errorText: authController.authState.errorPasswordForgotPassword,
            ).paddingSymmetric(horizontal: context.wp(4)),
            CustomTextFieldWidget(
              labelText: 'Mật khẩu mới',
              controller: authController.rePasswordForgotPasswordController,
              type: TextFieldType.password,
              errorText:
              authController.authState.errorRePasswordForgotPassword,
            ).paddingSymmetric(horizontal: context.wp(4)),
            CustomTextFieldWidget(
              labelText: 'Xác nhận mật khẩu mới',
              controller: authController.rePasswordForgotPasswordController,
              type: TextFieldType.password,
              errorText:
              authController.authState.errorRePasswordForgotPassword,
            ).paddingSymmetric(horizontal: context.wp(4)),
            CustomButtonWidget(
              height: context.hp(6),
              width: context.wp(100),
              title: "Cập nhật",
              onPressed: () async {
                FocusScope.of(context).unfocus();
                authController.forgotPassword(context);
              },
              color: const Color(0xffCF4375),
              titleSize: context.sp(14),
              radius: context.rp(10),
              fontWeight: FontWeight.w600,
            ).paddingSymmetric(horizontal: context.wp(4)),
          ],
        ),
      ),
    );
  }
}
