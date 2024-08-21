import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/utils/common/assets.dart';
import 'package:medi_express_patients/core/utils/extensions/extensions.dart';
import 'package:medi_express_patients/core/utils/theme/app_text_style.dart';
import 'package:medi_express_patients/features/base/presentation/widgets/base_stateless_widget.dart';
import 'package:medi_express_patients/features/chat/domain/entities/conversation_entity.dart';
import 'package:medi_express_patients/features/chat/presentation/controller/chat_controller.dart';

class ChatDetailPage extends BaseStatelessWidget {
  final ChatController chatController = Get.find<ChatController>();

  ChatDetailPage({super.key});

  @override
  Widget buildContent(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final ConversationEntity conversation =
        arguments['conversation'] as ConversationEntity;

    chatController.getAllMessage(conversation);

    // Dummy data for demonstration
    final List<Map<String, String>> messages = [
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "10:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "9:05 AM",
        "isUser": "false"
      },
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "9:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "8:05 AM",
        "isUser": "false"
      },
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "8:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "7:05 AM",
        "isUser": "false"
      },
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "7:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "6:05 AM",
        "isUser": "false"
      },
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "6:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "5:05 AM",
        "isUser": "false"
      },
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "5:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "4:05 AM",
        "isUser": "false"
      },
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "4:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "3:05 AM",
        "isUser": "false"
      },
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "3:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "2:05 AM",
        "isUser": "false"
      },
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "2:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "1:05 AM",
        "isUser": "false"
      },
      {
        "text": "Chào bác sĩ, em cần hỗ trợ ạ",
        "timestamp": "1:00 AM",
        "isUser": "true"
      },
      {
        "text": "Chào bạn, bạn cần hỗ trợ gì nhỉ",
        "timestamp": "00:05 AM",
        "isUser": "false"
      },
      // Add more messages here
    ];

    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Ensure the layout adjusts when keyboard appears
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
                      // Handle back button press
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      Assets.png.avatar1,
                      height: context.hp(4),
                      fit: BoxFit.cover,
                    ),
                  ),
                  context.wp(2).sbw,
                  Text(
                    'Bs. Hà Ngọc Cường',
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
                      (item.senderID == authController.baseState.user.value.id)
                          ? true
                          : false;
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      mainAxisAlignment: isUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        // if (!isUser)
                        //   CircleAvatar(
                        //     backgroundColor: Colors.grey[300],
                        //     child: Text(
                        //       'A',
                        //       style: TextStyle(color: Colors.black),
                        //     ),
                        //   ),
                        // SizedBox(width: 8),
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
                                  color:
                                      isUser ? Colors.blue : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  item.messageText,
                                  style: TextStyle(
                                      color:
                                          isUser ? Colors.white : Colors.black),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                item.createdAt,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // if (isUser)
                        //   SizedBox(width: 8),
                        // if (isUser)
                        //   CircleAvatar(
                        //     backgroundColor: Colors.blue,
                        //     child: Text(
                        //       'U',
                        //       style: TextStyle(color: Colors.white),
                        //     ),
                        //   ),
                      ],
                    ),
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
                        // Handle send button press
                        chatController.createMessage(conversation);
                      }
                    },
                  ),
                ],
              )).paddingOnly(
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
