import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';
import 'package:medi_express_patients/features/home/data/model/item_patient_model.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class ChatPage extends BaseStatelessWidget {
  final ChatController chatController = Get.find<ChatController>();
  ChatPage({super.key});

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
                  SizedBox(
                    height: context.hp(7),
                    width: context.wp(16),
                  ),
                  const Spacer(),
                  Text(
                    'Chat',
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
                    controller: chatController.searchController,
                    onChanged: (value) {
                      chatController.searchController.text = value;
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Tìm bác sĩ',
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
            bottom: context.wp(4),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              itemCount: ItemPatientModel.list(context).length,
              itemBuilder: (context, index) {
                final item = ItemPatientModel.list(context)[index];
                if (index == 0) {
                  return context.hp(1).sbh;
                }
                return GestureDetector(
                  onTap: () {
                    Log.info("click");
                    context.toNamedScreen(AppRoutes.chatDetail);
                  },
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            Assets.png.avatar1,
                            height: context.hp(7.6),
                            fit: BoxFit.cover,
                          ),
                        ),
                        context.wp(4).sbw,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Bs. Hà Ngọc Cường',
                                style:
                                    AppTextStyle.bigItemPatientTitle(context),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                              context.hp(0.4).sbh,
                              Text(
                                'Chào bác sĩ',
                                style: AppTextStyle.mediumDateTime(context),
                              ),
                            ],
                          ),
                        ),
                        Text('3 giờ trước'),
                      ],
                    ).paddingOnly(bottom: context.hp(2)),
                  ),
                );
              },
            ).paddingSymmetric(
              horizontal: context.wp(4),
            ),
          ),
        ],
      ),
    );
  }
}
