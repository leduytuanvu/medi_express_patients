import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/account/presentation/widgets/chart_widget.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';

class HeartbeatPage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();

  HeartbeatPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    accountController.getListHeartRate();
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
                      'heart_rate'.tr,
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
                context.wp(4).sbh,
                Row(
                  children: [
                    Text(
                      'recent_index'.tr,
                      style: AppTextStyle.mediumItemTitle(context),
                    ),
                    Spacer(),
                    // GestureDetector(
                    //   onTap: () {
                    //     context.toNamedScreen(AppRoutes.updateHeight);
                    //   },
                    //   child: Text(
                    //     'Thêm chỉ số',
                    //     style: AppTextStyle.link(context),
                    //   ),
                    // ),
                    // context.wp(2).sbw,
                    // Text(' | '),
                    // context.wp(1).sbw,
                    Icon(
                      Icons.share_outlined,
                      color: Color(0xFF005495),
                    ),
                  ],
                ),
                context.wp(4).sbh,
                Container(
                  height: context.hp(20),
                  child: Obx(() {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: accountController
                          .accountState.listHeartbeatDetail.length,
                      itemBuilder: (context, index) {
                        final reverseIndex = accountController
                                .accountState.listHeartbeatDetail.length -
                            1 -
                            index;
                        final item = accountController
                            .accountState.listHeartbeatDetail[reverseIndex];
                        return Column(
                          children: [
                            context.wp(1).sbh,
                            Row(
                              children: [
                                Text(
                                  item.heartRate.isEmpty
                                      ? "0 BPM"
                                      : item.heartRate + " BPM",
                                  style: AppTextStyle.smallItemTitle(context),
                                ),
                                Spacer(),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFF6FFED),
                                    borderRadius:
                                        BorderRadius.circular(context.rp(2)),
                                    border: Border.all(
                                      color: const Color(0xFFB7EB8F),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text('normal'.tr).paddingSymmetric(
                                      horizontal: context.wp(2),
                                      vertical: context.wp(1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            context.wp(1).sbh,
                            Row(
                              children: [
                                Text(item.createdAt.toFormattedString()),
                                // Spacer(),
                                // SvgPicture.asset(Assets.svg.edit),
                              ],
                            ),
                            context.wp(2).sbh,
                            if (index !=
                                accountController.accountState
                                        .listHeartbeatDetail.length -
                                    1) ...{
                              Divider(
                                thickness: context.hp(0.1),
                                color: Color(0xFFF4F5F7),
                              ),
                            }
                          ],
                        ); // Add padding between items
                      },
                    );
                  }),
                ),
                context.wp(1).sbh,
              ],
            ).paddingSymmetric(horizontal: context.wp(4)),
            context.wp(3).sbh,
            Divider(
              thickness: context.wp(2),
              color: Color(0xFFF4F5F7),
            ),
            context.wp(5).sbh,
            Column(
              children: [
                Text(
                  'heart_rate_chart'.tr,
                  style: AppTextStyle.mediumItemTitle(context),
                ).paddingSymmetric(
                  horizontal: context.wp(4),
                ),
              ],
            ),
            context.hp(6).sbh,
            ChartWidget(data: chartDataList).paddingOnly(right: context.wp(6)),
          ],
        ),
      ),
    );
  }

  List<ChartData> chartDataList = [
    ChartData(x: 0, y: 75, title: '15/08'),
    ChartData(x: 1, y: 90, title: '23/09'),
    ChartData(x: 2, y: 80, title: '23/10'),
    ChartData(x: 3, y: 100, title: '21/11'),
    ChartData(x: 4, y: 120, title: '22/12'),
  ];
}
