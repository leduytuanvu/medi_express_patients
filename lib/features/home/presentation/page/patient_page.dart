import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/comon/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/home/data/model/item_patient_model.dart';
import 'package:medi_express_patients/features/home/presentation/controller/home_controller.dart';

class PatientPage extends BaseStatelessWidget {
  final HomeController homeController = Get.find<HomeController>();
  PatientPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
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
                      // context.backScreen();
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
              // border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: homeController.searchController,
                    onChanged: (value) {
                      homeController.searchController.text = value;
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
                  onPressed: () {},
                ),
              ],
            ),
          ).paddingOnly(
            left: context.wp(4),
            right: context.wp(4),
            top: context.wp(4),
            bottom: context.wp(2),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: ItemPatientModel.list(context).length,
              itemBuilder: (context, index) {
                final item = ItemPatientModel.list(context)[index];
                return Container(
                  // color: Colors.red,
                  // margin: EdgeInsets.only(right: context.wp(2)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        item.imagePath,
                        height: context.hp(15),
                      ),
                      context.wp(4).sbw,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          context.hp(2).sbh,
                          Text(
                            item.title,
                            style: AppTextStyle.bigItemPatientTitle(context),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          context.hp(0.6).sbh,
                          Text(
                            item.datetime,
                            style: AppTextStyle.mediumDateTime(context),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ).paddingOnly(
              left: context.wp(4),
              right: context.wp(4),
              top: context.wp(2),
            ),
          ),
        ],
      ),
    );
  }
}
