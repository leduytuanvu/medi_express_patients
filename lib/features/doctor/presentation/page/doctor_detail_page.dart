import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_text_field_widget.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';
import '../controller/doctor_controller.dart';

class DoctorDetailPage extends BaseStatelessWidget {
  final DoctorController doctorController = Get.find<DoctorController>();
  DoctorDetailPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _content(context, doctorController),
    );
  }

  Stack _content(BuildContext context, DoctorController doctorController) {
    return Stack(
      children: [
        _header(context, doctorController),
        _body(context, doctorController),
        Align(
          alignment: Alignment.topCenter,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              Assets.png.avatarDoctor1x,
              height: context.wp(20),
              width: context.wp(20),
              fit: BoxFit.cover,
            ),
          ),
        ).paddingOnly(top: context.hp(12))
      ],
    );
  }

  Positioned _body(BuildContext context, DoctorController doctorController) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(context.rp(26)),
            topRight: Radius.circular(context.rp(26)),
          ),
        ),
        height: context.hp(83),
        child: Column(
          children: [
            context.hp(7).sbh,
            Text(
              'BS Trần Minh Khuyên',
              style: AppTextStyle.bigItemPatientTitle(
                context,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Bác sĩ chuyên khoa 2',
              style: AppTextStyle.mediumDateTime(context)
                  .copyWith(color: Color(0xFF414852)),
            ),
            Text(
              'Sức khỏe tâm thần',
              style: AppTextStyle.mediumDateTime(context),
            ),
            Text(
              'Bệnh viện Đại học Y Dược 1',
              style: AppTextStyle.mediumDateTime(context),
            ),
            context.hp(2).sbh,
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8FAFF),
                      borderRadius: BorderRadius.circular(context.rp(4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    ).paddingSymmetric(vertical: context.hp(1.2)),
                  ),
                ),
                context.wp(2).sbw,
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8FAFF),
                      borderRadius: BorderRadius.circular(context.rp(4)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                    ).paddingSymmetric(vertical: context.hp(1.2)),
                  ),
                ),
              ],
            ).paddingSymmetric(horizontal: context.wp(4)),
            context.hp(2.2).sbh,
            Divider(
              thickness: context.hp(0.9),
              color: Color(0xFFF4F5F7),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    context.hp(1.6).sbh,
                    Text(
                      'Giới thiệu về bác sĩ Trần Minh Khuyên',
                      style: AppTextStyle.bigItemPatientTitle(
                        context,
                      ),
                    ),
                    context.hp(1.8).sbh,
                    Text(
                      'Tiến sĩ, Bác sĩ Trần Minh Khuyên',
                      style: AppTextStyle.bigItemPatientTitle(context)
                          .copyWith(fontSize: context.sp(14)),
                    ),
                    context.hp(0.6).sbh,
                    Text(
                      'Bác sĩ điều trị tại khoa Cấp cứu A9 - Bệnh viện Bạch Mai',
                      style: AppTextStyle.bigItemPatientTitle(context).copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: context.sp(14)),
                    ),
                    context.hp(0.6).sbh,
                    Text(
                      'Giảng viên trường Đaị học Y Hà Nội',
                      style: AppTextStyle.bigItemPatientTitle(
                        context,
                      ).copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: context.sp(14)),
                    ),
                    context.hp(0.6).sbh,
                    Text(
                      'Bác sĩ tại phòng khám Đa khoa vip 12 clinic',
                      style: AppTextStyle.bigItemPatientTitle(
                        context,
                      ).copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: context.sp(14)),
                    ),
                    context.hp(1.4).sbh,
                    Divider(
                      thickness: context.hp(0.1),
                      color: Color(0xFFF4F5F7),
                    ),
                    context.hp(2).sbh,
                    Text(
                      'Quá trình công tác',
                      style: AppTextStyle.bigItemPatientTitle(
                        context,
                      ),
                    ),
                    context.hp(1.8).sbh,
                    for (int i = 0; i < 10; i++) ...{
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: context.hp(1)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 1, // Adjust flex as needed
                              child: Text(
                                '2024:',
                                style: AppTextStyle.mediumDateTime(context),
                              ),
                            ),
                            SizedBox(width: context.wp(2)), // Add spacing between texts
                            Expanded(
                              flex: 3, // Adjust flex as needed
                              child: Text(
                                'Tốt nghiệp hệ bác sĩ nội trú chuyên ngành Hồi sức cấp cứu - trường Đại học Y Hà Nội',
                                style: AppTextStyle.mediumDateTime(context),
                                softWrap: true,
                                overflow: TextOverflow.visible, // Allows wrapping
                              ),
                            ),
                          ],
                        ),
                      )
                    }
                    // ListView.builder for work history
                    // Container(
                    //   height: context.hp(30), // Adjust height as needed
                    //   child: ListView.builder(
                    //     padding: EdgeInsets.zero,
                    //     itemCount: 10, // Replace with your data length
                    //     itemBuilder: (context, index) {
                    //       return Padding(
                    //         padding: EdgeInsets.symmetric(vertical: context.hp(1)),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: [
                    //             Text(
                    //               'Item ${index * 2 + 1}',
                    //               style: AppTextStyle.mediumDateTime(context),
                    //             ),
                    //             Text(
                    //               'Item ${index * 2 + 2}',
                    //               style: AppTextStyle.mediumDateTime(context),
                    //             ),
                    //           ],
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ).paddingSymmetric(vertical: context.hp(2)),
                  ],
                ).paddingSymmetric(
                    horizontal: context.wp(4), vertical: context.hp(1)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _header(BuildContext context, DoctorController doctorController) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0D4E96), Color(0xFF1C75D8)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        height: context.hp(22),
        child: Align(
          alignment: Alignment.topCenter,
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  // authController.phoneController.text = '';
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
                'Thông tin bác sĩ',
                style: AppTextStyle.appBar(context),
              ),
              const Spacer(),
              SizedBox(width: context.wp(16)),
            ],
          ),
        ).paddingOnly(top: context.hp(4)),
      ),
    );
  }
}
