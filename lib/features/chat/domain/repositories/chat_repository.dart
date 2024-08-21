import 'package:medi_express_patients/features/chat/domain/entities/conversation_entity.dart';
import 'package:medi_express_patients/features/chat/domain/entities/create_conversation_entity.dart';
import 'package:medi_express_patients/features/chat/domain/entities/create_message_entity.dart';
import 'package:medi_express_patients/features/chat/domain/entities/message_entity.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_conversation_params.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_message_params.dart';

abstract class ChatRepository {
  Future<List<MessageEntity>> getAllMessage(int conversationId);

  Future<List<ConversationEntity>> getAllConversation(int userId);

  Future<CreateMessageEntity> createMessage(CreateMessageParams params);

  Future<CreateConversationEntity> createConversation(
      CreateConversationParams params);
}
