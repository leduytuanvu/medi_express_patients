import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/account/presentation/state/account_state.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class MeasuringDeviceLinkPage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  MeasuringDeviceLinkPage({super.key});

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
                    'measuring_device_link'.tr,
                    style: AppTextStyle.appBar(context),
                  ),
                  const Spacer(),
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
                          Icons.share,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).paddingOnly(top: context.hp(4)),
          ),
          SizedBox(height: context.hp(2)),
          Obx(() {
            return GestureDetector(
              onTap: () {
                accountController.accountState.selectedTypeMeasuringDeviceLink
                    .value = TypeMeasuringDeviceLink.homeKit6In1;
              },
              child: Container(
                height: context.hp(6.4),
                decoration: BoxDecoration(
                  color: accountController.accountState
                              .selectedTypeMeasuringDeviceLink.value ==
                          TypeMeasuringDeviceLink.homeKit6In1
                      ? Color(0xFFE8FAFF)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(context.rp(7)),
                  border: Border.all(
                      color: accountController.accountState
                                  .selectedTypeMeasuringDeviceLink ==
                              TypeMeasuringDeviceLink.homeKit6In1
                          ? Color(0xFF59B3DF)
                          : Color(0xEEEEEEFF)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      height: context.wp(6),
                      width: context.wp(6),
                      Assets.svg.graphDownNew,
                      color: accountController.accountState
                                  .selectedTypeMeasuringDeviceLink.value ==
                              TypeMeasuringDeviceLink.homeKit6In1
                          ? Color(0xFF59B3DF)
                          : Colors.black,
                    ),
                    SizedBox(width: context.wp(3)),
                    Text(
                      'Thiết bị Homekit6in1',
                      style: AppTextStyle.mediumBodyWithColor(
                        context,
                        accountController.accountState
                                    .selectedTypeMeasuringDeviceLink.value ==
                                TypeMeasuringDeviceLink.homeKit6In1
                            ? Color(0xFF59B3DF)
                            : Colors.black,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: context.wp(4)),
              ).paddingSymmetric(horizontal: context.wp(4)),
            );
          }),
          SizedBox(height: context.hp(1.6)),
          Obx(() {
            return GestureDetector(
              onTap: () {
                accountController.accountState.selectedTypeMeasuringDeviceLink
                    .value = TypeMeasuringDeviceLink.skinTest;
              },
              child: Container(
                height: context.hp(6.4),
                decoration: BoxDecoration(
                  color: accountController.accountState
                              .selectedTypeMeasuringDeviceLink.value ==
                          TypeMeasuringDeviceLink.skinTest
                      ? Color(0xFFE8FAFF)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(context.rp(7)),
                  border: Border.all(
                      color: accountController.accountState
                                  .selectedTypeMeasuringDeviceLink ==
                              TypeMeasuringDeviceLink.skinTest
                          ? Color(0xFF59B3DF)
                          : Color(0xEEEEEEFF)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      height: context.wp(6),
                      width: context.wp(6),
                      Assets.svg.bacteria,
                      color: accountController.accountState
                                  .selectedTypeMeasuringDeviceLink.value ==
                              TypeMeasuringDeviceLink.skinTest
                          ? Color(0xFF59B3DF)
                          : Colors.black,
                    ),
                    SizedBox(width: context.wp(3)),
                    Text(
                      'Soi da',
                      style: AppTextStyle.mediumBodyWithColor(
                        context,
                        accountController.accountState
                                    .selectedTypeMeasuringDeviceLink.value ==
                                TypeMeasuringDeviceLink.skinTest
                            ? Color(0xFF59B3DF)
                            : Colors.black,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: context.wp(4)),
              ).paddingSymmetric(horizontal: context.wp(4)),
            );
          }),
          SizedBox(height: context.hp(1.6)),
          Obx(() {
            return GestureDetector(
              onTap: () {
                accountController.accountState.selectedTypeMeasuringDeviceLink
                    .value = TypeMeasuringDeviceLink.lungMeasurement;
              },
              child: Container(
                height: context.hp(6.4),
                decoration: BoxDecoration(
                  color: accountController.accountState
                              .selectedTypeMeasuringDeviceLink.value ==
                          TypeMeasuringDeviceLink.lungMeasurement
                      ? Color(0xFFE8FAFF)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(context.rp(7)),
                  border: Border.all(
                      color: accountController.accountState
                                  .selectedTypeMeasuringDeviceLink ==
                              TypeMeasuringDeviceLink.lungMeasurement
                          ? Color(0xFF59B3DF)
                          : Color(0xEEEEEEFF)),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      height: context.wp(6),
                      width: context.wp(6),
                      Assets.svg.tuningSquare,
                      color: accountController.accountState
                                  .selectedTypeMeasuringDeviceLink.value ==
                              TypeMeasuringDeviceLink.lungMeasurement
                          ? Color(0xFF59B3DF)
                          : Colors.black,
                    ),
                    SizedBox(width: context.wp(3)),
                    Text(
                      'Đo phổi',
                      style: AppTextStyle.mediumBodyWithColor(
                        context,
                        accountController.accountState
                                    .selectedTypeMeasuringDeviceLink.value ==
                                TypeMeasuringDeviceLink.lungMeasurement
                            ? Color(0xFF59B3DF)
                            : Colors.black,
                      ),
                    ),
                  ],
                ).paddingSymmetric(horizontal: context.wp(4)),
              ).paddingSymmetric(horizontal: context.wp(4)),
            );
          }),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: context.hp(10.6),
              color: Colors.white,
              child: CustomButtonWidget(
                height: context.hp(6),
                width: context.wp(92),
                title: "measuring_device_link".tr,
                onPressed: () async {
                  context.toNamedScreen(AppRoutes.healthIndexMeasurement);
                },
                color: const Color(0xffCF4375),
                titleSize: context.sp(14),
                radius: context.rp(10),
              ).paddingSymmetric(
                  horizontal: context.wp(4), vertical: context.wp(2)),
            ),
          ),
        ],
      ),
    );
  }
}
