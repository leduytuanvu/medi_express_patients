import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class HealthIndexPage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  HealthIndexPage({super.key});

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
                      'Chỉ số sức khỏe',
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
            SizedBox(height: context.hp(1)),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // context.toNamedScreen(AppRoutes.healthIndex);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(Assets.svg.height).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Chiều cao',
                              style: AppTextStyle.smallItemTitle(context),
                            ),
                            Row(
                              children: [
                                Text(
                                  accountController.accountState.healthMetricts
                                              .value.height !=
                                          null
                                      ? accountController.accountState
                                              .healthMetricts.value.height +
                                          ' cm'
                                      : '0 cm',
                                  style: AppTextStyle.mediumBody(context),
                                ),
                                Text(
                                  '   |   ',
                                  style: AppTextStyle.mediumHint(context)
                                      .copyWith(color: Color(0xFFE3E8EF)),
                                ),
                                SvgPicture.asset(
                                  Assets.svg.alarm,
                                  height: context.wp(5),
                                  width: context.wp(5),
                                ).paddingOnly(
                                    bottom: context.hp(0.3),
                                    right: context.wp(1.4)),
                                Text(
                                  accountController.accountState.healthMetricts
                                              .value.height !=
                                          null
                                      ? accountController.accountState
                                              .healthMetricts.value.height +
                                          ' cm'
                                      : '0 cm',
                                  style: AppTextStyle.bigHint(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingSymmetric(vertical: context.hp(1.7)),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ),
                GestureDetector(
                  onTap: () {
                    // context.toNamedScreen(AppRoutes.healthIndex);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(Assets.svg.weight).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Cân nặng',
                              style: AppTextStyle.smallItemTitle(context),
                            ),
                            Row(
                              children: [
                                Text(
                                  accountController.accountState.healthMetricts
                                              .value.weight !=
                                          null
                                      ? accountController.accountState
                                              .healthMetricts.value.weight +
                                          ' kg'
                                      : '0 kg',
                                  style: AppTextStyle.mediumBody(context),
                                ),
                                Text(
                                  '   |   ',
                                  style: AppTextStyle.mediumHint(context)
                                      .copyWith(color: Color(0xFFE3E8EF)),
                                ),
                                SvgPicture.asset(
                                  Assets.svg.alarm,
                                  height: context.wp(5),
                                  width: context.wp(5),
                                ).paddingOnly(
                                    bottom: context.hp(0.3),
                                    right: context.wp(1.4)),
                                Text(
                                  '08:30 23/09/2021',
                                  style: AppTextStyle.bigHint(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingSymmetric(vertical: context.hp(1.7)),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ),
                GestureDetector(
                  onTap: () {
                    Log.info('click');
                    // context.toNamedScreen(AppRoutes.personalInformation);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(
                            Assets.svg.temp,
                          ).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nhiệt độ',
                              style: AppTextStyle.smallItemTitle(context),
                            ),
                            Row(
                              children: [
                                Text(
                                  accountController.accountState.healthMetricts
                                          .value.temperature!.value.isNotEmpty
                                      ? accountController
                                          .accountState
                                          .healthMetricts
                                          .value
                                          .temperature!
                                          .value
                                      : '0',
                                  style: AppTextStyle.mediumBody(context),
                                ),
                                Text(
                                  '   |   ',
                                  style: AppTextStyle.mediumHint(context)
                                      .copyWith(color: Color(0xFFE3E8EF)),
                                ),
                                SvgPicture.asset(
                                  Assets.svg.alarm,
                                  height: context.wp(5),
                                  width: context.wp(5),
                                ).paddingOnly(
                                    bottom: context.hp(0.3),
                                    right: context.wp(1.4)),
                                Text(
                                  '08:30 23/09/2021',
                                  style: AppTextStyle.bigHint(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingOnly(
                      top: context.hp(1.7),
                      bottom: context.hp(1.7),
                    ),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ),
                GestureDetector(
                  onTap: () {
                    context.toNamedScreen(AppRoutes.heartbeat);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Container(
                          height: context.wp(14),
                          width: context.wp(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6F9),
                            borderRadius: BorderRadius.circular(context.rp(20)),
                          ),
                          child: SvgPicture.asset(
                            Assets.svg.heartbeat,
                          ).paddingAll(
                            context.wp(3.4),
                          ),
                        ),
                        context.wp(4).sbw,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nhịp tim',
                              style: AppTextStyle.smallItemTitle(context),
                            ),
                            Row(
                              children: [
                                Text(
                                  accountController.accountState.healthMetricts
                                          .value.heartRate!.value.isNotEmpty
                                      ? accountController
                                              .accountState
                                              .healthMetricts
                                              .value
                                              .heartRate!
                                              .value +
                                          ' BPM'
                                      : '0 BPM',
                                  style: AppTextStyle.mediumBody(context),
                                ),
                                Text(
                                  '   |   ',
                                  style: AppTextStyle.mediumHint(context)
                                      .copyWith(color: Color(0xFFE3E8EF)),
                                ),
                                SvgPicture.asset(
                                  Assets.svg.alarm,
                                  height: context.wp(5),
                                  width: context.wp(5),
                                ).paddingOnly(
                                    bottom: context.hp(0.3),
                                    right: context.wp(1.4)),
                                Text(
                                  '08:30 23/09/2021',
                                  style: AppTextStyle.bigHint(context),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: context.wp(5),
                        ),
                      ],
                    ).paddingOnly(
                      bottom: context.hp(1.7),
                      top: context.hp(1.7),
                    ),
                  ),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ),
                Row(
                  children: [
                    Container(
                      height: context.wp(14),
                      width: context.wp(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(context.rp(20)),
                      ),
                      child: SvgPicture.asset(
                        Assets.svg.bloodPressure,
                      ).paddingAll(
                        context.wp(3.4),
                      ),
                    ),
                    context.wp(4).sbw,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Huyết áp',
                          style: AppTextStyle.smallItemTitle(context),
                        ),
                        Row(
                          children: [
                            Text(
                              accountController.accountState.healthMetricts
                                      .value.bloodPressure!.value.isNotEmpty
                                  ? accountController
                                          .accountState
                                          .healthMetricts
                                          .value
                                          .bloodPressure!
                                          .value +
                                      ' mmHg'
                                  : '0 mmHg',
                              style: AppTextStyle.mediumBody(context),
                            ),
                            Text(
                              '   |   ',
                              style: AppTextStyle.mediumHint(context)
                                  .copyWith(color: Color(0xFFE3E8EF)),
                            ),
                            SvgPicture.asset(
                              Assets.svg.alarm,
                              height: context.wp(5),
                              width: context.wp(5),
                            ).paddingOnly(
                                bottom: context.hp(0.3),
                                right: context.wp(1.4)),
                            Text(
                              '08:30 23/09/2021',
                              style: AppTextStyle.bigHint(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: context.wp(5),
                    ),
                  ],
                ).paddingOnly(
                  top: context.hp(1.7),
                  bottom: context.hp(1.7),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ),
                Row(
                  children: [
                    Container(
                      height: context.wp(14),
                      width: context.wp(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(context.rp(20)),
                      ),
                      child: SvgPicture.asset(
                        Assets.svg.spo2,
                      ).paddingAll(
                        context.wp(3.4),
                      ),
                    ),
                    context.wp(4).sbw,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SpO2',
                          style: AppTextStyle.smallItemTitle(context),
                        ),
                        Row(
                          children: [
                            Text(
                              accountController.accountState.healthMetricts
                                      .value.spO2!.value.isNotEmpty
                                  ? accountController.accountState
                                          .healthMetricts.value.spO2!.value +
                                      ' %'
                                  : '0 %',
                              style: AppTextStyle.mediumBody(context),
                            ),
                            Text(
                              '   |   ',
                              style: AppTextStyle.mediumHint(context)
                                  .copyWith(color: Color(0xFFE3E8EF)),
                            ),
                            SvgPicture.asset(
                              Assets.svg.alarm,
                              height: context.wp(5),
                              width: context.wp(5),
                            ).paddingOnly(
                                bottom: context.hp(0.3),
                                right: context.wp(1.4)),
                            Text(
                              '08:30 23/09/2021',
                              style: AppTextStyle.bigHint(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: context.wp(5),
                    ),
                  ],
                ).paddingOnly(
                  bottom: context.hp(1.7),
                  top: context.hp(1.7),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ),
                Row(
                  children: [
                    Container(
                      height: context.wp(14),
                      width: context.wp(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(context.rp(20)),
                      ),
                      child: SvgPicture.asset(
                        Assets.svg.bloodSugar,
                      ).paddingAll(
                        context.wp(3.4),
                      ),
                    ),
                    context.wp(4).sbw,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Đường huyết',
                          style: AppTextStyle.smallItemTitle(context),
                        ),
                        Row(
                          children: [
                            Text(
                              accountController
                                      .accountState
                                      .healthMetricts
                                      .value
                                      .bloodSugar!
                                      .bloodSugarAfterMeal
                                      .isNotEmpty
                                  ? accountController
                                          .accountState
                                          .healthMetricts
                                          .value
                                          .bloodSugar!
                                          .bloodSugarAfterMeal +
                                      ' mmol/l'
                                  : '0 mmol/l',
                              style: AppTextStyle.mediumBody(context),
                            ),
                            Text(
                              '   |   ',
                              style: AppTextStyle.mediumHint(context)
                                  .copyWith(color: Color(0xFFE3E8EF)),
                            ),
                            SvgPicture.asset(
                              Assets.svg.alarm,
                              height: context.wp(5),
                              width: context.wp(5),
                            ).paddingOnly(
                                bottom: context.hp(0.3),
                                right: context.wp(1.4)),
                            Text(
                              '08:30 23/09/2021',
                              style: AppTextStyle.bigHint(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: context.wp(5),
                    ),
                  ],
                ).paddingOnly(
                  bottom: context.hp(1.7),
                  top: context.hp(1.7),
                ),
                Divider(
                  thickness: context.hp(0.1),
                  color: Color(0xFFF4F5F7),
                ),
                Row(
                  children: [
                    Container(
                      height: context.wp(14),
                      width: context.wp(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF5F6F9),
                        borderRadius: BorderRadius.circular(context.rp(20)),
                      ),
                      child: SvgPicture.asset(
                        Assets.svg.ua,
                      ).paddingAll(
                        context.wp(3.4),
                      ),
                    ),
                    context.wp(4).sbw,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Chỉ số UA',
                          style: AppTextStyle.smallItemTitle(context),
                        ),
                        Row(
                          children: [
                            Text(
                              accountController.accountState.healthMetricts
                                      .value.acidUric!.value.isNotEmpty
                                  ? accountController
                                          .accountState
                                          .healthMetricts
                                          .value
                                          .acidUric!
                                          .value +
                                      ' umol/l'
                                  : '0 umol/l',
                              style: AppTextStyle.mediumBody(context),
                            ),
                            Text(
                              '   |   ',
                              style: AppTextStyle.mediumHint(context)
                                  .copyWith(color: Color(0xFFE3E8EF)),
                            ),
                            SvgPicture.asset(
                              Assets.svg.alarm,
                              height: context.wp(5),
                              width: context.wp(5),
                            ).paddingOnly(
                                bottom: context.hp(0.3),
                                right: context.wp(1.4)),
                            Text(
                              '08:30 23/09/2021',
                              style: AppTextStyle.bigHint(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: context.wp(5),
                    ),
                  ],
                ).paddingOnly(
                  bottom: context.hp(1.7),
                  top: context.hp(1.7),
                ),
              ],
            ).paddingSymmetric(horizontal: context.wp(4)),
            context.hp(6).sbh,
          ],
        ),
      ),
    );
  }
}
