import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/schedule/domain/entities/schedule_entity.dart';
import 'package:medi_express_patients/features/schedule/presentation/controller/schedule_controller.dart';

class ScheduleDetailPage extends BaseStatelessWidget {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  ScheduleDetailPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final ScheduleEntity schedule = arguments['schedule'] as ScheduleEntity;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scheduleController.getScheduleResult(schedule.appointmentId.toString());
    });
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
                      'Thông tin lịch khám',
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
                          borderRadius: BorderRadius.circular(context.rp(6)),
                          // border: Border.all(color: Colors.grey.shade300),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              schedule.appointmentDate.toDate(),
                              style: AppTextStyle.titleNumberPatient(context),
                            ),
                            Text(
                              'Th ${schedule.appointmentDate.toMonth()}',
                              style: AppTextStyle.bodyNumberPatient(context),
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
                            schedule.nameServiceType,
                            style: AppTextStyle.mediumItemTitle(context),
                          ),
                          context.hp(0.3).sbh,
                          Text(
                            '${schedule.startTime.toHourMinute()} - ${schedule.appointmentDate.toFormattedDate()}',
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
                        schedule.nameDoctor,
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
                        schedule.phoneDoctor,
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
                        schedule.nameService,
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
                        schedule.clinic,
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
              ).paddingAll(context.wp(4)),
            ),
            Divider(
              thickness: context.hp(0.9),
              color: Color(0xFFF4F5F7),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.hp(2).sbh,
                Text('Kết luận', style: AppTextStyle.smallTitle(context)),
                context.hp(0.8).sbh,
                Obx(() {
                  if (scheduleController.scheduleState.scheduleResult.value
                      .clinicalIndication.isNotEmpty) {
                    return Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.dot,
                          height: context.wp(1),
                          width: context.wp(1),
                        ),
                        context.wp(2).sbw,
                        Text(
                            scheduleController.scheduleState.scheduleResult
                                .value.clinicalIndication,
                            style: AppTextStyle.smallBody(context)),
                      ],
                    );
                  } else {
                    return Row(
                      children: [
                        SvgPicture.asset(
                          Assets.svg.dot,
                          height: context.wp(1),
                          width: context.wp(1),
                        ),
                        context.wp(2).sbw,
                        Text('Chưa có kết luận',
                            style: AppTextStyle.smallBody(context)),
                      ],
                    );
                  }
                }),
                context.hp(2).sbh,
                // Row(
                //   children: [
                //     SvgPicture.asset(
                //       Assets.svg.dot,
                //       height: context.wp(1),
                //       width: context.wp(1),
                //     ),
                //     context.wp(2).sbw,
                //     Text('Basedown', style: AppTextStyle.smallBody(context)),
                //   ],
                // ),
                // context.hp(2).sbh,
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F6F9),
                    borderRadius: BorderRadius.circular(context.rp(8)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Chỉ định',
                          style: AppTextStyle.smallBodyW600(context)),
                      context.hp(1).sbh,
                      if (scheduleController.scheduleState.scheduleResult.value
                          .diagnosis.isNotEmpty) ...{
                        Row(
                          children: [
                            Text('Siêu âm Doppler tim',
                                style: AppTextStyle.smallBodyW500(context)),
                            Spacer(),
                            Text('Chi tiết',
                                style: AppTextStyle.smallBodyLink(context)),
                          ],
                        ),
                        context.hp(0.6).sbh,
                        Row(
                          children: [
                            Text('XN hóa ',
                                style: AppTextStyle.smallBodyW500(context)),
                            Spacer(),
                            Text('Chi tiết',
                                style: AppTextStyle.smallBodyLink(context)),
                          ],
                        ),
                        context.hp(0.6).sbh,
                        Row(
                          children: [
                            Text('Điện tim thường',
                                style: AppTextStyle.smallBodyW500(context)),
                            Spacer(),
                            Text('Chi tiết',
                                style: AppTextStyle.smallBodyLink(context)),
                          ],
                        ),
                      } else ...{
                        Text('Chưa có chỉ định',
                            style: AppTextStyle.smallBodyW500(context)),
                      }
                    ],
                  ).paddingAll(context.wp(4)),
                ),
              ],
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(2).sbh,
            Divider(
              thickness: context.hp(0.9),
              color: Color(0xFFF4F5F7),
            ),
            context.hp(2).sbh,
            Obx(() {
              if (!scheduleController.scheduleState.scheduleExamDone.value) {
                return _itemScheduleDetail(context).paddingSymmetric(
                  horizontal: context.wp(4),
                );
              } else {
                return _itemScheduleDetailDone(context).paddingSymmetric(
                  horizontal: context.wp(4),
                );
              }
            }),
          ],
        ),
      ),
    );
  }

  Column _itemScheduleDetail(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Đơn thuốc', style: AppTextStyle.smallTitle(context)),
        context.hp(0.8).sbh,
        Text(
          'Chưa có thông tin đơn thuốc',
          style: AppTextStyle.bigHint(context).copyWith(
            color: Color(0xFF777F89),
          ),
        ),
      ],
    );
  }

  Widget _itemScheduleDetailDone(BuildContext context) {
    return SizedBox(
      // Add a fixed height for the TabBar and TabBarView
      height: context.hp(57.4), // Adjust height as needed
      child: DefaultTabController(
        length: 3, // Number of tabs
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Đơn thuốc', style: AppTextStyle.smallTitle(context)),
            SizedBox(height: context.hp(1.4)), // Adjusted for spacing

            // TabBar
            Container(
              // Optional: background color for TabBar
              child: TabBar(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                labelColor: Color(0xFF005495), // Color for the selected tab
                unselectedLabelColor:
                    Colors.grey, // Color for the unselected tabs
                indicatorColor: Color(0xFF005495),
                tabs: [
                  Tab(text: 'Thuốc'),
                  Tab(text: 'Lời nhắc'),
                  Tab(text: 'Lịch sử sử dụng'),
                ],
              ),
            ),

            // TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(context.rp(8)),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Balfaxar'),
                        context.hp(0.7).sbh,
                        Divider(
                          thickness: context.hp(0.1),
                        ),
                        context.hp(1).sbh,
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.svg.dot,
                              height: context.wp(1),
                              width: context.wp(1),
                            ),
                            context.wp(2).sbw,
                            Text('Một viên buổi sáng sau khi ăn',
                                style: AppTextStyle.smallBody(context)),
                          ],
                        ),
                        context.hp(0.6).sbh,
                        Row(
                          children: [
                            SvgPicture.asset(
                              Assets.svg.dot,
                              height: context.wp(1),
                              width: context.wp(1),
                            ),
                            context.wp(2).sbw,
                            Text('Uống hằng ngày',
                                style: AppTextStyle.smallBody(context)),
                          ],
                        ),
                        context.hp(1.8).sbh,
                        Container(
                          height: context.hp(6),
                          decoration: BoxDecoration(
                            color: Color(0xFF92DAF4),
                            borderRadius: BorderRadius.circular(context.rp(8)),
                          ),
                          child: Center(
                            child: Text(
                              'Lưu ý: lorem ipsum dolo sit amet',
                              style: AppTextStyle.linkW400(context),
                            ),
                          ).paddingSymmetric(
                            vertical: context.hp(1),
                          ),
                        ),
                      ],
                    ).paddingAll(context.wp(4)),
                  ).paddingSymmetric(vertical: context.hp(2)),
                  Container(
                    child: Center(child: Text('')),
                  ),
                  Container(
                    child: Center(child: Text('')),
                  ),
                ],
              ),
            ),
            context.hp(20).sbh,
          ],
        ),
      ),
    );
  }
}
