import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/account/presentation/widgets/chart_widget.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';

class BloodSugarPage extends BaseStatelessWidget {
  final AccountController accountController = Get.find<AccountController>();
  BloodSugarPage({super.key});

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
                      'Đường huyết',
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
                      'Chỉ số gần đây',
                      style: AppTextStyle.mediumItemTitle(context),
                    ),
                    Spacer(),
                    // Text(
                    //   'Thêm chỉ số',
                    //   style: AppTextStyle.link(context),
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
                Row(
                  children: [
                    Text(
                      '80 BPM',
                      style: AppTextStyle.smallItemTitle(context),
                    ),
                    Spacer(),
                    Text('Bình thường'),
                  ],
                ),
                context.wp(1).sbh,
                Row(
                  children: [
                    Text('08:30 23/09/2021'),
                    Spacer(),
                    SvgPicture.asset(Assets.svg.edit),
                  ],
                ),
                context.wp(2).sbh,
                Divider(),
                context.wp(2).sbh,
                Row(
                  children: [
                    Text(
                      '80 BPM',
                      style: AppTextStyle.smallItemTitle(context),
                    ),
                    Spacer(),
                    Text('Bình thường'),
                  ],
                ),
                context.wp(1).sbh,
                Row(
                  children: [
                    Text('08:30 23/09/2021'),
                    Spacer(),
                    SvgPicture.asset(Assets.svg.edit),
                  ],
                ),
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
                  'Biểu đồ nhịp tim',
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
