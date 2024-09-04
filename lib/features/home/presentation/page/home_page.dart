import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/home/data/model/item_news_model.dart';
import 'package:medi_express_patients/features/home/data/model/item_utilities_model.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  final AuthController authController = Get.find<AuthController>();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // homeController.getAllHomeExaminationPackage();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: context.hp(31),
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D4E96), Color(0xFF1C75D8)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: context.hp(5.4),
                  left: context.hp(0),
                  right: context.hp(0),
                  child: Row(
                    children: [
                      Obx(() {
                        if (authController
                            .baseState.user.value.name!.isNotEmpty) {
                          return Text(
                            'hi'.tr +
                                ', ${authController.baseState.user.value.name}',
                            style: AppTextStyle.bigTitle(context),
                          );
                        } else {
                          return Text(
                            'hi'.tr + ', ' + 'anonymous'.tr,
                            style: AppTextStyle.bigTitle(context),
                          );
                        }
                      }),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.toNamedScreen(AppRoutes.notification);
                        },
                        child: SvgPicture.asset(
                          Assets.svg.bell,
                          height: context.wp(7),
                          width: context.wp(7),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(horizontal: context.wp(4)),
                ),
                Positioned(
                    top: context.hp(16.4),
                    left: context.hp(0),
                    right: context.hp(0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(context.rp(26)),
                          topRight: Radius.circular(context.rp(26)),
                        ),
                      ),
                      height: context.hp(15.6),
                      width: context.wp(100),
                    )),
                Positioned(
                  top: context.hp(8),
                  left: context.hp(0),
                  right: context.hp(0),
                  child: Image.asset(
                    Assets.png.banner4x,
                  ),
                ),
              ],
            ),
          ),
          Text('utilities'.tr, style: AppTextStyle.mediumItemTitle(context))
              .paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            top: context.wp(8),
            bottom: context.wp(4),
          ),
          SizedBox(
            height: context.hp(25),
            child: GridView.builder(
              padding: const EdgeInsets.all(0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: context.wp(0),
                mainAxisSpacing: context.wp(0),
                childAspectRatio: 0.9,
              ),
              itemCount: ItemUtilitiesModel.list(context).length,
              itemBuilder: (context, index) {
                final item = ItemUtilitiesModel.list(context)[index];
                return GestureDetector(
                  onTap: () {
                    Log.info("on tap: ${item.title}");
                    // context.toNamedScreen(AppRoutes.patientPage);
                    switch (item.title) {
                      case "health_index":
                        context.toNamedScreen(AppRoutes.healthIndex);
                      case "prescription":
                        context.toNamedScreen(AppRoutes.prescription);
                      case "vaccination":
                        context.toNamedScreen(AppRoutes.vaccination);
                      case "examination_schedule":
                        final MainController mainController =
                            Get.find<MainController>();
                        mainController.changePage(2);
                      case "testing":
                        context.toNamedScreen(AppRoutes.testing);
                      case "diagnosis_of_images":
                        context.toNamedScreen(AppRoutes.diagnosticImaging);
                      case "medical_services":
                        context.toNamedScreen(AppRoutes.medicalServices);
                      case "medical_record":
                        homeController.searchController.text = '';
                        context.toNamedScreen(AppRoutes.healthRecord);
                    }
                  },
                  child: DottedBorder(
                    color: const Color(0xFFD5D8DD),
                    dashPattern: const [4, 4],
                    strokeWidth: 1,
                    child: SizedBox(
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            item.icon,
                            context.hp(1.36).sbh,
                            _buildTwoLineText(context, item.title.tr),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ).paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            bottom: context.wp(4.2),
          ),
          Divider(
            color: const Color(0xFFF4F5F7),
            thickness: context.hp(1),
          ),
          Row(
            children: [
              Text(
                'home_health_check_up_package'.tr,
                style: AppTextStyle.mediumItemTitle(context),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.toNamedScreen(AppRoutes.homeHealthPackage);
                },
                child: SvgPicture.asset(
                  Assets.svg.arrorRight,
                ),
              ),
            ],
          ).paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            top: context.wp(6),
            bottom: context.wp(4),
          ),
          // Container(
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: context.hp(26),
          //         child: ListView.builder(
          //           scrollDirection: Axis.horizontal,
          //           itemCount:
          //               ItemHomeExaminationPackageModel.list(context).length,
          //           itemBuilder: (context, index) {
          //             final item =
          //                 ItemHomeExaminationPackageModel.list(context)[index];
          //             return Container(
          //               width: context.wp(40),
          //               margin: EdgeInsets.only(
          //                 right: ItemHomeExaminationPackageModel.list(context)
          //                                 .length -
          //                             1 ==
          //                         index
          //                     ? context.wp(4)
          //                     : context.wp(2),
          //                 left: index == 0 ? context.wp(4) : context.wp(0),
          //               ),
          //               child: Column(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Image.asset(
          //                     item.iconPath,
          //                     width: context.wp(40),
          //                   ),
          //                   context.hp(1).sbh,
          //                   Text(
          //                     item.title,
          //                     style: AppTextStyle.bigItemBody(context),
          //                     maxLines: 3,
          //                     overflow: TextOverflow.ellipsis,
          //                   ),
          //                   context.hp(0.3).sbh,
          //                   Text(
          //                     item.price,
          //                     style: AppTextStyle.mediumItemPrice(context),
          //                   ),
          //                 ],
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: context
                        .hp(22), // Adjust the height constraint as needed
                  ),
                  child: Obx(() {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeController
                          .homeState.listAllHomeExaminationPackage.length,
                      itemBuilder: (context, index) {
                        final item = homeController
                            .homeState.listAllHomeExaminationPackage[index];
                        return GestureDetector(
                          onTap: () {
                            context.toNamedScreen(AppRoutes.homeHealthPackage);
                          },
                          child: Container(
                            // color: Colors.amber,
                            width: context.wp(40),
                            margin: EdgeInsets.only(
                              right: homeController
                                              .homeState
                                              .listAllHomeExaminationPackage
                                              .length -
                                          1 ==
                                      index
                                  ? context.wp(4)
                                  : context.wp(2),
                              left: index == 0 ? context.wp(4) : context.wp(0),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (item.filePath == null || item.filePath.isEmpty)
                                    ? Image.network(
                                        item.filePath,
                                        width: context.wp(40),
                                      )
                                    : SizedBox(
                                        width: context.hp(40),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: item.filePath,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(
                                              color: Colors.grey[200],
                                              strokeWidth: 2,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                SizedBox(height: context.hp(1)),
                                Text(
                                  item.serviceName,
                                  style: AppTextStyle.bigItemBody(context),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: context.hp(0.3)),
                                Text(
                                  item.priceTag.toVnd(),
                                  style: AppTextStyle.mediumItemPrice(context),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),

          context.hp(1.4).sbh,
          Divider(
            color: const Color(0xFFF4F5F7),
            thickness: context.hp(1),
          ),
          Row(
            children: [
              Text(
                'news'.tr,
                style: AppTextStyle.mediumItemTitle(context),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  context.toNamedScreen(AppRoutes.news);
                },
                child: SvgPicture.asset(
                  Assets.svg.arrorRight,
                ),
              ),
            ],
          ).paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            top: context.wp(6),
            bottom: context.wp(4),
          ),
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: context.hp(26),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: ItemNewsModel.list(context).length,
                    itemBuilder: (context, index) {
                      final item = ItemNewsModel.list(context)[index];
                      return GestureDetector(
                        onTap: () {
                          context.toNamedScreen(AppRoutes.newsDetail);
                        },
                        child: Container(
                          width: context.wp(40),
                          margin: EdgeInsets.only(
                            right:
                                ItemNewsModel.list(context).length - 1 == index
                                    ? context.wp(4)
                                    : context.wp(2),
                            left: index == 0 ? context.wp(4) : context.wp(0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                item.iconPath,
                                width: context.wp(40),
                              ),
                              context.hp(1).sbh,
                              Text(
                                item.title,
                                style: AppTextStyle.bigItemBody(context),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTwoLineText(BuildContext context, String title) {
    final words = title.split(' ');
    final half = (words.length / 2).ceil();
    final firstLine = words.take(half).join(' ');
    final secondLine = words.skip(half).join(' ');

    return Column(
      children: [
        Text(
          firstLine,
          style: AppTextStyle.mediumItemBody(context),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          secondLine,
          style: AppTextStyle.mediumItemBody(context),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
