import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/schedule/presentation/controller/schedule_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class SchedulePage extends StatelessWidget {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    if (!scheduleController.scheduleState.scheduleExamDone.value) {
      Log.info(
          "===== ${scheduleController.scheduleState.scheduleExamDone.value}");
      scheduleController.getAllSchedule();
    } else {
      Log.info(
          "===== ${scheduleController.scheduleState.scheduleExamDone.value}");
      scheduleController.getAllScheduleDone();
    }

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
                  'Lịch khám',
                  style: AppTextStyle.appBar(context),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    // context.backScreen();
                    scheduleController.scheduleState.dateChoose.value = '';
                    scheduleController.scheduleState.timeChoose.value = '';
                    scheduleController.scheduleState.typeExamAtHome.value =
                        true;
                    context.toNamedScreen(AppRoutes.bookSchedule);
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
        AnimatedContainer(
          height: context.hp(7),
          decoration: BoxDecoration(
            color: const Color(0xFFEEF2F6),
            borderRadius: BorderRadius.circular(context.rp(8)),
            // border: Border.all(color: Colors.grey.shade300),
          ),
          duration: Duration(milliseconds: 300),
          child: Row(children: [
            context.wp(1).sbw,
            Obx(() {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    scheduleController.getAllSchedule();
                  },
                  child: Container(
                    height: context.hp(6),
                    decoration: BoxDecoration(
                      color: scheduleController
                              .scheduleState.scheduleExamDone.value
                          ? Color(0xFFEEF2F6)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(context.rp(8)),
                      // border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        'Lịch sắp tới',
                        style: AppTextStyle.titleButtonPatient(context),
                      ),
                    ),
                  ),
                ),
              );
            }),
            // Expanded(
            //   child: Container(
            //     height: context.hp(6),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(context.rp(8)),
            //       // border: Border.all(color: Colors.grey.shade300),
            //     ),
            //     child: Center(
            //       child: Text(
            //         'Lịch sắp tới',
            //         style: AppTextStyle.titleButtonPatient(context),
            //       ),
            //     ),
            //   ),
            // ),
            context.wp(1).sbw,
            Obx(() {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    scheduleController.getAllScheduleDone();
                  },
                  child: Container(
                    height: context.hp(6),
                    decoration: BoxDecoration(
                      color: scheduleController
                              .scheduleState.scheduleExamDone.value
                          ? Colors.white
                          : Color(0xFFEEF2F6),
                      borderRadius: BorderRadius.circular(context.rp(8)),
                      // border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Center(
                      child: Text(
                        'Đã khám',
                        style: AppTextStyle.titleButtonPatient(context),
                      ),
                    ),
                  ),
                ),
              );
            }),
            // Expanded(
            //   child: Container(
            //     height: context.hp(6),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(context.rp(8)),
            //       // border: Border.all(color: Colors.grey.shade300),
            //     ),
            //     child: Center(
            //       child: Text(
            //         'Đã khám',
            //         style: AppTextStyle.titleButtonPatient(context),
            //       ),
            //     ),
            //   ),
            // ),
            context.wp(1).sbw,
          ]),
        ).paddingSymmetric(
          horizontal: context.wp(4),
          vertical: context.wp(4),
        ),
        Obx(() {
          if (!scheduleController.scheduleState.scheduleExamDone.value) {
            return _buildSchedule(context);
          } else {
            return _buildScheduleDone(context);
          }
        }),
      ],
    );
  }

  Expanded _buildSchedule(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await scheduleController.getAllSchedule();
        },
        color: Colors.grey,
        backgroundColor: Colors.white,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount: scheduleController.scheduleState.listAllSchedule.length,
          itemBuilder: (context, index) {
            final item =
                scheduleController.scheduleState.listAllSchedule[index];
            return GestureDetector(
              onTap: () {
                context.toNamedScreen(AppRoutes.scheduleDetail,
                    arguments: {'schedule': item});
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(context.rp(8)),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    // color: Colors.red,
                    // margin: EdgeInsets.only(right: context.wp(2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: context.hp(8),
                              width: context.hp(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFCCEAF9),
                                borderRadius:
                                    BorderRadius.circular(context.rp(6)),
                                // border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    item.appointmentDate!.toDate(),
                                    style: AppTextStyle.titleNumberPatient(
                                        context),
                                  ),
                                  Text(
                                    'Th ${item.appointmentDate!.toMonth()}',
                                    style:
                                        AppTextStyle.bodyNumberPatient(context),
                                  ),
                                ],
                              ),
                            ),
                            context.wp(4).sbw,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.nameServiceType!,
                                  style: AppTextStyle.mediumItemTitle(context),
                                ),
                                context.hp(0.3).sbh,
                                Text(
                                  '${item.startTime!.toHourMinute()} - ${item.appointmentDate!.toFormattedDate()}',
                                  style: AppTextStyle.bigHint(context).copyWith(
                                    color: Color(0xFF777F89),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        context.hp(0.7).sbh,
                        Divider(
                          thickness: 1,
                          color: Color(0xFFE3E8EF),
                        ),
                        context.hp(0.5).sbh,
                        Row(
                          children: [
                            Text(
                              'Bác sĩ',
                              style: AppTextStyle.bigHint(context).copyWith(
                                color: Color(0xFF777F89),
                              ),
                            ),
                            Spacer(),
                            Text(
                              item.nameDoctor!,
                              style: AppTextStyle.mediumBody(context).copyWith(
                                fontSize: context.sp(13),
                              ),
                            ),
                          ],
                        ),
                        context.hp(0.5).sbh,
                        Row(
                          children: [
                            Text(
                              'Số điện thoại',
                              style: AppTextStyle.bigHint(context).copyWith(
                                color: Color(0xFF777F89),
                              ),
                            ),
                            Spacer(),
                            Text(
                              item.phoneDoctor!,
                              style: AppTextStyle.mediumBody(context).copyWith(
                                fontSize: context.sp(13),
                              ),
                            ),
                          ],
                        ),
                        context.hp(0.5).sbh,
                        Row(
                          children: [
                            Text(
                              'Dịch vụ',
                              style: AppTextStyle.bigHint(context).copyWith(
                                color: Color(0xFF777F89),
                              ),
                            ),
                            Spacer(),
                            Text(
                              item.nameService!,
                              style: AppTextStyle.mediumBody(context).copyWith(
                                fontSize: context.sp(13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).paddingAll(context.wp(3)),
                  ).paddingOnly(
                    bottom: context.wp(4),
                  ),
                  if (scheduleController.scheduleState.listAllSchedule.length -
                          1 ==
                      index) ...{
                    context.hp(10).sbh,
                  }
                ],
              ),
            );
          },
        ).paddingSymmetric(
          horizontal: context.wp(4),
        ),
      ),
    );
  }

  Expanded _buildScheduleDone(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () async {
          await scheduleController.getAllScheduleDone();
        },
        color: Colors.grey,
        backgroundColor: Colors.white,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          itemCount:
              scheduleController.scheduleState.listAllScheduleDone.length,
          itemBuilder: (context, index) {
            final item =
                scheduleController.scheduleState.listAllScheduleDone[index];
            return GestureDetector(
              onTap: () {
                // context.toNamedScreen(AppRoutes.scheduleDetail);
                context.toNamedScreen(AppRoutes.scheduleDetail,
                    arguments: {'schedule': item});
              },
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(context.rp(8)),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    // color: Colors.red,
                    // margin: EdgeInsets.only(right: context.wp(2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: context.hp(8),
                              width: context.hp(8),
                              decoration: BoxDecoration(
                                color: Color(0xFFCCEAF9),
                                borderRadius:
                                    BorderRadius.circular(context.rp(6)),
                                // border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    item.appointmentDate!.toDate(),
                                    style: AppTextStyle.titleNumberPatient(
                                        context),
                                  ),
                                  Text(
                                    'Th ${item.appointmentDate!.toMonth()}',
                                    style:
                                        AppTextStyle.bodyNumberPatient(context),
                                  ),
                                ],
                              ),
                            ),
                            context.wp(4).sbw,
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.nameServiceType!,
                                  style: AppTextStyle.mediumItemTitle(context),
                                ),
                                context.hp(0.3).sbh,
                                Text(
                                  '${item.startTime!.toHourMinute()} - ${item.appointmentDate!.toFormattedDate()}',
                                  style: AppTextStyle.bigHint(context).copyWith(
                                    color: Color(0xFF777F89),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        context.hp(0.7).sbh,
                        Divider(
                          thickness: context.hp(0.1),
                        ),
                        context.hp(0.5).sbh,
                        Row(
                          children: [
                            Text(
                              'Bác sĩ',
                              style: AppTextStyle.bigHint(context).copyWith(
                                color: Color(0xFF777F89),
                              ),
                            ),
                            Spacer(),
                            Text(
                              item.nameDoctor!,
                              style: AppTextStyle.mediumBody(context).copyWith(
                                fontSize: context.sp(13),
                              ),
                            ),
                          ],
                        ),
                        context.hp(0.5).sbh,
                        Row(
                          children: [
                            Text(
                              'Số điện thoại',
                              style: AppTextStyle.bigHint(context).copyWith(
                                color: Color(0xFF777F89),
                              ),
                            ),
                            Spacer(),
                            Text(
                              item.phoneDoctor!,
                              style: AppTextStyle.mediumBody(context).copyWith(
                                fontSize: context.sp(13),
                              ),
                            ),
                          ],
                        ),
                        context.hp(0.5).sbh,
                        Row(
                          children: [
                            Text(
                              'Dịch vụ',
                              style: AppTextStyle.bigHint(context).copyWith(
                                color: Color(0xFF777F89),
                              ),
                            ),
                            Spacer(),
                            Text(
                              item.nameService!,
                              style: AppTextStyle.mediumBody(context).copyWith(
                                fontSize: context.sp(13),
                              ),
                            ),
                          ],
                        ),
                        context.hp(0.5).sbh,
                        Row(
                          children: [
                            Text(
                              'Phòng khám',
                              style: AppTextStyle.bigHint(context).copyWith(
                                color: Color(0xFF777F89),
                              ),
                            ),
                            Spacer(),
                            Text(
                              item.address!,
                              style: AppTextStyle.mediumBody(context).copyWith(
                                fontSize: context.sp(13),
                              ),
                            ),
                          ],
                        ),
                        context.hp(0.5).sbh,
                        Row(
                          children: [
                            Text(
                              'STT',
                              style: AppTextStyle.bigHint(context).copyWith(
                                color: Color(0xFF777F89),
                              ),
                            ),
                            Spacer(),
                            Text(
                              '3',
                              style: AppTextStyle.mediumBody(context).copyWith(
                                fontSize: context.sp(13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ).paddingAll(context.wp(3)),
                  ).paddingOnly(
                    bottom: context.wp(4),
                  ),
                  if (scheduleController
                              .scheduleState.listAllScheduleDone.length -
                          1 ==
                      index) ...{
                    context.hp(10).sbh,
                  }
                ],
              ),
            );
          },
        ).paddingSymmetric(
          horizontal: context.wp(4),
        ),
      ),
    );
  }
}
