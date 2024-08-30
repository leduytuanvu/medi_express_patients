import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';
import 'package:medi_express_patients/features/main/presentation/controller/main_controller.dart';

class ChatDetailPage extends BaseStatelessWidget {
  final ChatController chatController = Get.find<ChatController>();

  ChatDetailPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final int conversation = arguments['conversationId'] as int;
    final String nameDoctor = arguments['nameDoctor'] as String;
    final String avatarDoctor = arguments['avatarDoctor'] as String;

    chatController.getAllMessage(conversation);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                      final MainController mainController =
                          Get.find<MainController>();
                      mainController.mainState.doctorInformation.value = null;
                      context.backScreen();
                    },
                    child: Container(
                      height: context.hp(7),
                      width: context.wp(10),
                      color: Colors.transparent,
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  context.wp(1).sbw,
                  avatarDoctor.isEmpty
                      ? Image.asset(
                          Assets.png.user,
                          height: context.hp(4),
                          fit: BoxFit.cover,
                          color: Colors.white,
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            width: context.hp(4),
                            height: context.hp(4),
                            imageUrl: avatarDoctor,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                              color: Colors.grey[200],
                              strokeWidth: 2,
                            ).paddingAll(context.wp(4)),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                  context.wp(2).sbw,
                  Text(
                    nameDoctor,
                    style: AppTextStyle.appBar(context),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      // Handle phone call button press
                    },
                    child: Container(
                      height: context.hp(7),
                      width: context.wp(10),
                      color: Colors.transparent,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.phone,
                          height: context.wp(5.2),
                          width: context.wp(5.2),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Handle video call button press
                    },
                    child: Container(
                      height: context.hp(7),
                      width: context.wp(10),
                      color: Colors.transparent,
                      child: Center(
                        child: SvgPicture.asset(
                          Assets.svg.videoRecorder,
                          height: context.wp(5.2),
                          width: context.wp(5.2),
                        ),
                      ),
                    ),
                  ),
                ],
              ).paddingOnly(right: context.wp(2.4), left: context.wp(2.4)),
            ).paddingOnly(top: context.hp(4)),
          ),
          Obx(() {
            return Expanded(
              flex: 8,
              child: ListView.builder(
                reverse: true,
                padding: EdgeInsets.symmetric(horizontal: 16),
                itemCount: chatController.chatState.listMessage.length,
                itemBuilder: (context, index) {
                  final item = chatController.chatState.listMessage[index];
                  final isUser =
                      (item.senderID == authController.baseState.user.value.id);

                  // Show date header if it's the first message or the date is different from the previous message
                  bool showDateHeader = index ==
                          chatController.chatState.listMessage.length - 1 ||
                      (index <
                              chatController.chatState.listMessage.length - 1 &&
                          DateTime.parse(item.createdAt).toLocal().day !=
                              DateTime.parse(chatController.chatState
                                      .listMessage[index + 1].createdAt)
                                  .toLocal()
                                  .day);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (showDateHeader)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Center(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    thickness: context.hp(0.1),
                                    color: Color(0xFFF4F5F7),
                                  ),
                                ),
                                Column(
                                  children: [
                                    SizedBox(height: context.hp(2.2)),
                                    Text(
                                      item.createdAt
                                          .toAdjustedHourMinute(), // Format time as needed
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      item.createdAt
                                          .toRelativeTime(), // Format time as needed
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ).paddingSymmetric(horizontal: context.wp(5)),
                                Expanded(
                                  child: Divider(
                                    thickness: context.hp(0.1),
                                    color: Color(0xFFF4F5F7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisAlignment: isUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: isUser
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isUser
                                          ? Color(0xFF005495)
                                          : Color(0xFFF5F6F9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      item.messageText,
                                      style: TextStyle(
                                          color: isUser
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    item.createdAt.toAdjustedHourMinute(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          }),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF5F6F9),
              borderRadius: BorderRadius.circular(context.rp(2)),
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
                      hintText: 'Nhập tin nhắn',
                      hintStyle: AppTextStyle.searchHint(context),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Color(0xFF414852),
                  ),
                  onPressed: () {
                    if (chatController.searchController.text
                        .trim()
                        .isNotEmpty) {
                      chatController.createMessage(conversation);
                    }
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
        ],
      ),
    );
  }
}
