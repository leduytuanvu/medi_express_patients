import 'package:get/get.dart';
import 'package:medi_express_patients/features/base/presentation/state/base_state.dart';
import 'package:medi_express_patients/features/chat/domain/entities/conversation_entity.dart';
import 'package:medi_express_patients/features/chat/domain/entities/message_entity.dart';

class ChatState extends BaseState {
  var messages = <String>[].obs;
  var messageTextController = ''.obs;
  var listConversation = <ConversationEntity>[].obs;
  var listMessage = <MessageEntity>[].obs;
}
