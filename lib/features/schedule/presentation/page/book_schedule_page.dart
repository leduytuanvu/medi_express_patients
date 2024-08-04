import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_button_widget.dart';
import 'package:medi_express_patients/core/presentation/widgets/custom_drop_down_box_widget.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/home/data/model/item_patient_model.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';
import 'package:medi_express_patients/features/schedule/presentation/controller/schedule_controller.dart';

class BookSchedulePage extends BaseStatelessWidget {
  final ScheduleController scheduleController = Get.find<ScheduleController>();
  BookSchedulePage({super.key});

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
                      'Đặt lịch khám',
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
            context.hp(2.2).sbh,
            Text(
              'Loại hình khám',
              style: AppTextStyle.mediumItemTitle(context),
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(1.8).sbh,
            Row(
              children: [
                Icon(
                  Icons.radio_button_checked,
                  color: Color(0xFF005495),
                  size: context.sp(20),
                ),
                context.wp(1.2).sbw,
                Text(
                  'Khám bệnh tại nhà',
                  style: AppTextStyle.mediumBody(context),
                ),
                Spacer(),
                Icon(
                  Icons.radio_button_checked,
                  color: Color(0xFF005495),
                  size: context.sp(20),
                ),
                context.wp(1.2).sbw,
                Text(
                  'Khám tại bênh viện',
                  style: AppTextStyle.mediumBody(context),
                ),
              ],
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(2.2).sbh,
            Divider(
              thickness: context.hp(0.9),
              color: Color(0xFFF4F5F7),
            ),
            context.hp(2.2).sbh,
            Text(
              'Chọn dịch vụ',
              style: AppTextStyle.mediumItemTitle(context),
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(1.8).sbh,
            DropdownButtonFormField<String>(
              value: 'Sức khoẻ tổng quát',
              hint: Text(''),
              items: ['Sức khoẻ tổng quát'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              style: AppTextStyle.mediumBody(context),
              onChanged: (String? newValue) {},
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xFFE3E8EF), // Border color
                    width: 1, // Border width
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xFFE3E8EF), // Border color when enabled
                    width: 1, // Border width when enabled
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Color(0xFFE3E8EF), // Border color when focused
                    width: 1, // Border width when focused
                  ),
                ),
              ),
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(2.2).sbh,
            Divider(
              thickness: context.hp(0.9),
              color: Color(0xFFF4F5F7),
            ),
            context.hp(2.2).sbh,
            Text(
              'Chọn ngày giờ',
              style: AppTextStyle.mediumItemTitle(context),
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
            context.hp(1.8).sbh,
            Row(children: [
              Text('Chọn ngày', style: AppTextStyle.mediumBody(context)),
              Spacer(),
              SvgPicture.asset(
                Assets.svg.calender,
                color: Color(0xFF005495),
                height: context.wp(4),
                width: context.wp(4),
              ).paddingOnly(bottom: context.wp(0.3)),
              context.wp(2).sbw,
              Text('06/2022', style: AppTextStyle.linkH5(context)),
            ]).paddingSymmetric(horizontal: context.wp(4)),
            context.hp(1.6).sbh,
            Container(
              height: context.hp(9),
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Scroll horizontally
                itemCount: 10, // Number of items in the list
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: context.hp(7.8),
                    width: context.wp(14),
                    margin: EdgeInsets.only(
                      left: index == 0 ? context.wp(4) : context.wp(0),
                      right: index == 9 ? context.wp(4) : context.wp(2),
                    ), // Width of each item
                    // margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Color(0xFFEEF2F6), // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          context.hp(0.7).sbh,
                          Text('T2', style: AppTextStyle.smallBody(context)),
                          context.hp(0.8).sbh,
                          Text('13', style: AppTextStyle.bodyH1(context)),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            context.hp(1.8).sbh,
            Text('Chọn giờ', style: AppTextStyle.mediumBody(context))
                .paddingOnly(left: context.wp(4)),
            context.hp(1.6).sbh,
            Container(
              height: context.hp(6),
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Scroll horizontally
                itemCount: 6, // Number of items in the list
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: context.hp(4),
                    width: context.wp(34),
                    margin: EdgeInsets.only(
                      left: index == 0 ? context.wp(4) : context.wp(0),
                      right: index == 5 ? context.wp(4) : context.wp(2),
                    ), // Width of each item
                    // margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Color(0xFFEEF2F6), // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '07:00 - 08:00',
                        style: AppTextStyle.mediumBody(context),
                      ),
                    ),
                  );
                },
              ),
            ),
            context.hp(1).sbh,
            Container(
              height: context.hp(6),
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // Scroll horizontally
                itemCount: 6, // Number of items in the list
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: context.hp(4),
                    width: context.wp(34),
                    margin: EdgeInsets.only(
                      left: index == 0 ? context.wp(4) : context.wp(0),
                      right: index == 5 ? context.wp(4) : context.wp(2),
                    ), // Width of each item
                    // margin: EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        color: Color(0xFFEEF2F6), // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '07:00 - 08:00',
                        style: AppTextStyle.mediumBody(context),
                      ),
                    ),
                  );
                },
              ),
            ),
            context.hp(1).sbh,
            CustomButtonWidget(
              height: context.hp(6),
              width: context.wp(100),
              title: "Hoàn tất",
              onPressed: () async {
                // Handle button press
                FocusScope.of(context).unfocus();
                authController.enterInformation(context);
              },
              color: const Color(0xffCF4375),
              titleSize: context.sp(14),
              radius: context.rp(10),
              fontWeight: FontWeight.w600,
            ).paddingSymmetric(horizontal: context.wp(4)),

          ],
        ),
      ),
    );
  }
}
