import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class HealthRecordPage extends BaseStatelessWidget {
  final HomeController homeController = Get.find<HomeController>();

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
                    'Bệnh án',
                    style: AppTextStyle.appBar(context),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Handle adding new record
                    },
                    child: Container(
                      height: context.hp(7),
                      width: context.wp(16),
                      color: Colors.transparent,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.addCircleWhite,
                          height: context.wp(7),
                          width: context.wp(7),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ).paddingOnly(top: context.hp(4)),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6F9),
              borderRadius: BorderRadius.circular(context.rp(2)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: homeController.searchController,
                    onChanged: (value) {
                      homeController.searchController.text = value;
                      homeController.homeState.search.value = value;
                      homeController.filterHealthRecords(value);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tìm bệnh án',
                      hintStyle: AppTextStyle.searchHint(context),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Color(0xFF414852),
                  ),
                  onPressed: () {
                    homeController.filterHealthRecords(
                        homeController.searchController.text);
                  },
                ),
              ],
            ),
          ).paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            top: context.wp(4),
            bottom: context.wp(4),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: homeController.getAllHealthRecord,
              color: Colors.grey,
              backgroundColor: Colors.white,
              child: Obx(() {
                if (homeController.homeState.listAllHealthRecord.isNotEmpty) {
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount:
                        homeController.homeState.listAllHealthRecord.length,
                    itemBuilder: (context, index) {
                      final item =
                          homeController.homeState.listAllHealthRecord[index];
                      return GestureDetector(
                        onTap: () {
                          context.toNamedScreen(AppRoutes.healthRecordDetail);
                        },
                        child: Column(
                          children: [
                            if (index == 0) ...{
                              context.hp(2).sbh,
                            },
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (item.filePath == null || item.filePath.isEmpty)
                                    ? Image.asset(
                                        Assets.png.patientImage1x,
                                        height: context.hp(15),
                                      )
                                    : SizedBox(
                                        height: context.hp(15),
                                        width: context.hp(15),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: item.filePath!,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(
                                              color: Colors.grey,
                                              strokeWidth: 2,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                context.wp(4).sbw,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      context.hp(1.1).sbh,
                                      Text(
                                        item.nameHealthRecord,
                                        style: AppTextStyle.bigItemPatientTitle(
                                            context),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      context.hp(0.6).sbh,
                                      Text(
                                        item.createdAt.toFormattedDate(),
                                        style: AppTextStyle.mediumDateTime(
                                            context),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            if (homeController
                                        .homeState.listAllHealthRecord.length -
                                    1 >
                                index) ...{
                              const Divider(
                                thickness: 1,
                                color: Color(0xFFEEF2F6),
                              ).paddingSymmetric(
                                  horizontal: context.wp(2),
                                  vertical: context.wp(4)),
                            } else ...{
                              context.hp(10).sbh,
                            }
                          ],
                        ).paddingOnly(
                          left: context.wp(4),
                          right: context.wp(4),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text('Không có bệnh án nào.').paddingOnly(
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
