import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';

class LanguagePage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  final AuthController authController = Get.find<AuthController>();

  LanguagePage({super.key});

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
                    'language'.tr,
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
          SizedBox(height: context.hp(1)),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: authController.baseState.listLocale.length,
              itemBuilder: (context, index) {
                final item = authController.baseState.listLocale[index];
                return GestureDetector(
                  onTap: () {
                    Log.info('click: ${item.languageCode}');
                    authController.baseState.locale.value = item;
                  },
                  child: Obx(() {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(context.rp(8)),
                        border: Border.all(
                          color: authController
                                      .baseState.locale.value.languageCode !=
                                  item.languageCode
                              ? Colors.grey.shade300
                              : const Color(0xFFCF4375),
                        ),
                      ),
                      height: context.hp(6),
                      width: context.wp(70),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          authController.baseState.listLanguage[index].tr,
                          style: AppTextStyle.mediumBody(context),
                        ).paddingOnly(left: context.wp(4)),
                      ),
                    );
                  }).paddingOnly(
                    bottom: context.wp(3),
                    left: context.wp(4),
                    right: context.wp(4),
                  ),
                );
              },
            ).paddingOnly(top: context.wp(2)),
          ),
          Spacer(),
          CustomButtonWidget(
            height: context.hp(6),
            width: double.infinity,
            title: 'save'.tr,
            onPressed: () async {
              authController.saveLanguage(context);
            },
            color: const Color(0xffCF4375),
            titleSize: context.sp(14),
            radius: context.rp(10),
            fontWeight: FontWeight.w600,
          ).paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            bottom: context.wp(2),
          ),
        ],
      ),
    );
  }
}
