import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

class ChatPage extends StatelessWidget {
  final ChatController chatController = Get.find<ChatController>();
  final MainController mainController = Get.find<MainController>();
  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    chatController.getAllConversation(context);
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
                    'chat'.tr,
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
                      hintText: 'find_a_doctor'.tr,
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
          Obx(() {
            Log.info(
                "chatController.chatState.listConversation.length: ${chatController.chatState.listConversation.length}");
            return Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  chatController.getAllConversation(context);
                },
                color: Colors.grey,
                backgroundColor: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: chatController.chatState.listConversation.length,
                  itemBuilder: (context, index) {
                    final item =
                        chatController.chatState.listConversation[index];
                    // if (index == 0) {
                    //   return context.hp(1).sbh;
                    // }
                    return GestureDetector(
                      onTap: () {
                        Log.info("click");
                        context.toNamedScreen(AppRoutes.chatDetail, arguments: {
                          'conversationId': item.conversationID,
                          'nameDoctor': item.name,
                          'avatarDoctor': item.avatar,
                        });
                        // context.toNamedScreen(AppRoutes.scheduleDetail,
                        //     arguments: {'schedule': item});
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            item.avatar!.isEmpty
                                ? Image.asset(
                                    Assets.png.user,
                                    height: context.hp(7.6),
                                  )
                                : CachedNetworkImage(
                                    width: context.hp(7.6),
                                    height: context.hp(7.6),
                                    imageUrl: item.avatar!,
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(
                                      color: Colors.grey[200],
                                      strokeWidth: 2,
                                    ).paddingAll(context.wp(4)),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                            context.wp(4).sbw,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bs. ' + item.name,
                                    style: AppTextStyle.bigItemPatientTitle(
                                        context),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  context.hp(0.4).sbh,
                                  Text(
                                    item.lastMessage ?? '',
                                    style: AppTextStyle.mediumDateTime(context),
                                  ),
                                ],
                              ),
                            ),
                            Text(item.lastMessageTime!.isEmpty
                                ? chatController
                                    .getCurrentLastMessageDate()
                                    .toRelativeTime()
                                : item.lastMessageTime!.toRelativeTime()),
                          ],
                        ).paddingOnly(
                          bottom: context.hp(2),
                          top: index == 0 ? context.hp(1) : 0,
                        ),
                      ),
                    );
                  },
                ).paddingSymmetric(
                  horizontal: context.wp(4),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
