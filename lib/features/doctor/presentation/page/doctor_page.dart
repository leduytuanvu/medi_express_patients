import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

import '../controller/doctor_controller.dart';

class DoctorPage extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final DoctorController doctorController = Get.find<DoctorController>();
  DoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    doctorController.getAllInformationDoctor();
    return Column(
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
                SizedBox(
                  height: context.hp(7),
                  width: context.wp(16),
                ),
                const Spacer(),
                Text(
                  'Bác sĩ',
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
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(context.rp(2)),
            // border: Border.all(color: Colors.grey.shade300),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: doctorController.searchController,
                  onChanged: (value) {
                    doctorController.searchController.text = value;
                    doctorController.doctorState.search.value = value;
                    Log.info(
                        "search: ${doctorController.doctorState.search.value}");
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Tìm bác sĩ',
                    hintStyle: AppTextStyle.searchHint(context),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Color(0xFF414852),
                ),
                onPressed: () {
                  doctorController.getDoctorByName();
                },
              ),
            ],
          ),
        ).paddingOnly(
          left: context.wp(4),
          right: context.wp(4),
          top: context.wp(4),
          bottom: context.wp(2),
        ),
        Obx(() {
          Log.info("buildlllllllllllllllllllllllllll");
          return Expanded(
            child: RefreshIndicator(
              onRefresh: doctorController.getAllInformationDoctor,
              color: Colors.grey,
              backgroundColor: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: doctorController
                    .doctorState.listAllInformationDoctor.length,
                itemBuilder: (context, index) {
                  // final item = ItemDoctorModel.list(context)[index];
                  final item = doctorController
                      .doctorState.listAllInformationDoctor[index];
                  if (doctorController.doctorState.search.value.isNotEmpty) {
                    Log.info("buildlllllllllllllllllllllllllll111");
                    if (doctorController.doctorState.search.value
                        .contains(item.degree)) {
                      Log.info("buildlllllllllllllllllllllllllll0000");
                      return GestureDetector(
                        onTap: () {
                          Log.info('click');
                          // context.toNamedScreen(AppRoutes.doctorDetail);
                          context.toNamedScreen(AppRoutes.doctorDetail,
                              arguments: {'doctorInformation': item});
                        },
                        child: Container(
                          color: Colors.transparent,
                          // margin: EdgeInsets.only(right: context.wp(2)),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  (item.avatar == null || item.avatar.isEmpty)
                                      ? Image.asset(
                                          Assets.png.avatarDoctor1x,
                                          height: context.hp(15),
                                        )
                                      :
                                      // Image.asset(
                                      //   Assets.png.avatarDoctor1x,
                                      //   height: context.hp(15),
                                      // ),
                                      SizedBox(
                                          height: context.hp(15),
                                          width: context.hp(15),
                                          child: Center(
                                            child: CachedNetworkImage(
                                              imageUrl: item.avatar,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // context.hp(2).sbh,
                                        Row(
                                          children: [
                                            Text(
                                              "${item.degree} ${item.name}",
                                              style: AppTextStyle
                                                  .bigItemPatientTitle(
                                                context,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const Spacer(),
                                            Icon(
                                              Icons.star,
                                              color: const Color(0xFFFE9E0D),
                                              size: context.wp(4.7),
                                            ),
                                            context.wp(0.8).sbw,
                                            Text(
                                              '4.2',
                                              style: AppTextStyle.smallBody(
                                                  context),
                                            )
                                          ],
                                        ),
                                        // context.hp(0.6).sbh,
                                        Text(
                                          item.major ?? 'Chưa có thông tin',
                                          style: AppTextStyle.mediumDateTime(
                                                  context)
                                              .copyWith(
                                                  color: Color(0xFF414852)),
                                        ),
                                        Text(
                                          item.specialistDoctor ??
                                              'Chưa có thông tin',
                                          style: AppTextStyle.mediumDateTime(
                                              context),
                                        ),
                                        Text(
                                          item.currentWork ??
                                              'Chưa có thông tin',
                                          style: AppTextStyle.mediumDateTime(
                                              context),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '11 lượt đặt khám',
                                              style: AppTextStyle.smallItem(
                                                  context),
                                            ),
                                            SvgPicture.asset(
                                              Assets.svg.dot,
                                              height: context.wp(0.8),
                                              width: context.wp(0.8),
                                            ).paddingSymmetric(
                                                horizontal: context.wp(1.2)),
                                            Text(
                                              '56 lượt tư vấn',
                                              style: AppTextStyle.smallItem(
                                                  context),
                                            )
                                          ],
                                        ).paddingOnly(top: context.hp(1.2))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              context.hp(1).sbh,
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8FAFF),
                                        borderRadius: BorderRadius.circular(
                                            context.rp(4)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            Assets.svg.record,
                                            height: context.wp(4.6),
                                            width: context.wp(4.6),
                                          ),
                                          context.wp(2).sbw,
                                          Text(
                                            'Tư vấn từ xa',
                                            style: AppTextStyle.link(context),
                                          )
                                        ],
                                      ).paddingSymmetric(
                                          vertical: context.hp(1.2)),
                                    ),
                                  ),
                                  context.wp(2).sbw,
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFE8FAFF),
                                        borderRadius: BorderRadius.circular(
                                            context.rp(4)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            Assets.svg.addCircleBlue,
                                            height: context.wp(4.6),
                                            width: context.wp(4.6),
                                          ),
                                          context.wp(2).sbw,
                                          Text(
                                            'Đặt khám',
                                            style: AppTextStyle.link(context),
                                          )
                                        ],
                                      ).paddingSymmetric(
                                          vertical: context.hp(1.2)),
                                    ),
                                  ),
                                ],
                              ),
                              if (doctorController.doctorState
                                          .listAllInformationDoctor.length -
                                      1 >
                                  index) ...{
                                Divider(
                                  thickness: context.hp(0.08),
                                  color: const Color(0xFFE3E8EF),
                                ).paddingOnly(
                                  top: context.hp(1.24),
                                  bottom: context.hp(1.1),
                                ),
                              } else ...{
                                context.hp(10).sbh,
                              }
                            ],
                          ).paddingSymmetric(horizontal: context.wp(4)),
                        ),
                      );
                    } else {
                      Log.info("buildlllllllllllllllllllllllllll00002");
                      return SizedBox.shrink();
                    }
                  } else {
                    Log.info("buildlllllllllllllllllllllllllll2222");
                    return GestureDetector(
                      onTap: () {
                        Log.info('click');
                        // context.toNamedScreen(AppRoutes.doctorDetail);
                        context.toNamedScreen(AppRoutes.doctorDetail,
                            arguments: {'doctorInformation': item});
                      },
                      child: Container(
                        color: Colors.transparent,
                        // margin: EdgeInsets.only(right: context.wp(2)),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                (item.avatar == null || item.avatar.isEmpty)
                                    ? Image.asset(
                                        Assets.png.avatarDoctor1x,
                                        height: context.hp(15),
                                      )
                                    :
                                    // Image.asset(
                                    //   Assets.png.avatarDoctor1x,
                                    //   height: context.hp(15),
                                    // ),
                                    SizedBox(
                                        height: context.hp(15),
                                        width: context.hp(15),
                                        child: Center(
                                          child: CachedNetworkImage(
                                            imageUrl: item.avatar,
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
                                      // context.hp(2).sbh,
                                      Row(
                                        children: [
                                          Text(
                                            "${item.degree} ${item.name}",
                                            style: AppTextStyle
                                                .bigItemPatientTitle(
                                              context,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          const Spacer(),
                                          Icon(
                                            Icons.star,
                                            color: const Color(0xFFFE9E0D),
                                            size: context.wp(4.7),
                                          ),
                                          context.wp(0.8).sbw,
                                          Text(
                                            '4.2',
                                            style:
                                                AppTextStyle.smallBody(context),
                                          )
                                        ],
                                      ),
                                      // context.hp(0.6).sbh,
                                      Text(
                                        item.major ?? 'Chưa có thông tin',
                                        style:
                                            AppTextStyle.mediumDateTime(context)
                                                .copyWith(
                                                    color: Color(0xFF414852)),
                                      ),
                                      Text(
                                        item.specialistDoctor ??
                                            'Chưa có thông tin',
                                        style: AppTextStyle.mediumDateTime(
                                            context),
                                      ),
                                      Text(
                                        item.currentWork ?? 'Chưa có thông tin',
                                        style: AppTextStyle.mediumDateTime(
                                            context),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '11 lượt đặt khám',
                                            style:
                                                AppTextStyle.smallItem(context),
                                          ),
                                          SvgPicture.asset(
                                            Assets.svg.dot,
                                            height: context.wp(0.8),
                                            width: context.wp(0.8),
                                          ).paddingSymmetric(
                                              horizontal: context.wp(1.2)),
                                          Text(
                                            '56 lượt tư vấn',
                                            style:
                                                AppTextStyle.smallItem(context),
                                          )
                                        ],
                                      ).paddingOnly(top: context.hp(1.2))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            context.hp(1).sbh,
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8FAFF),
                                      borderRadius:
                                          BorderRadius.circular(context.rp(4)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.svg.record,
                                          height: context.wp(4.6),
                                          width: context.wp(4.6),
                                        ),
                                        context.wp(2).sbw,
                                        Text(
                                          'Tư vấn từ xa',
                                          style: AppTextStyle.link(context),
                                        )
                                      ],
                                    ).paddingSymmetric(
                                        vertical: context.hp(1.2)),
                                  ),
                                ),
                                context.wp(2).sbw,
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE8FAFF),
                                      borderRadius:
                                          BorderRadius.circular(context.rp(4)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          Assets.svg.addCircleBlue,
                                          height: context.wp(4.6),
                                          width: context.wp(4.6),
                                        ),
                                        context.wp(2).sbw,
                                        Text(
                                          'Đặt khám',
                                          style: AppTextStyle.link(context),
                                        )
                                      ],
                                    ).paddingSymmetric(
                                        vertical: context.hp(1.2)),
                                  ),
                                ),
                              ],
                            ),
                            if (doctorController.doctorState
                                        .listAllInformationDoctor.length -
                                    1 >
                                index) ...{
                              Divider(
                                thickness: context.hp(0.08),
                                color: const Color(0xFFE3E8EF),
                              ).paddingOnly(
                                top: context.hp(1.24),
                                bottom: context.hp(1.1),
                              ),
                            } else ...{
                              context.hp(10).sbh,
                            }
                          ],
                        ).paddingSymmetric(horizontal: context.wp(4)),
                      ),
                    );
                  }
                },
              ).paddingOnly(
                top: context.wp(2),
              ),
            ),
          );
        }),
      ],
    );
  }
}
