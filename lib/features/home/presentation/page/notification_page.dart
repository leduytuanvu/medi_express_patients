import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';

class NotificationPage extends BaseStatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  NotificationPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    homeController.getAllHealthRecord();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
                    'notification'.tr,
                    style: AppTextStyle.appBar(context),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // context.backScreen();
                    },
                    child: SizedBox(
                      height: context.hp(7),
                      width: context.wp(16),
                    ),
                  ),
                ],
              ),
            ).paddingOnly(top: context.hp(4)),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: homeController.getAllHealthRecord,
              color: Colors.grey,
              backgroundColor: Colors.white,
              child: Obx(() {
                if (homeController.homeState.listNotification.isNotEmpty) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: homeController.homeState.listNotification.length,
                    itemBuilder: (context, index) {
                      final item =
                          homeController.homeState.listNotification[index];
                      return Column(
                        children: [
                          if (index == 0) ...{
                            context.hp(2).sbh,
                          },
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(width: context.wp(100)),
                              Text(
                                'Chưa có UI',
                                style: AppTextStyle.mediumBody(context),
                              ),
                              Text(
                                '',
                                style: AppTextStyle.smallBody(context),
                              ),
                              SizedBox(height: context.wp(3)),
                            ],
                          )
                        ],
                      ).paddingOnly(
                        left: context.wp(4),
                        right: context.wp(4),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Bạn chưa có thông báo nào.').paddingOnly(
                      bottom: context.hp(12),
                    ),
                  );
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
