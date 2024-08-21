import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/chat/data/datasource/remote/chat_api_service.dart';
import 'package:medi_express_patients/features/chat/data/dto/conversation_dto.dart';
import 'package:medi_express_patients/features/chat/data/dto/create_conversation_dto.dart';
import 'package:medi_express_patients/features/chat/data/dto/create_message_dto.dart';
import 'package:medi_express_patients/features/chat/data/dto/message_dto.dart';

class ChatRemoteDatasource {
  final ChatApiService chatApiService;

  ChatRemoteDatasource(this.chatApiService);

  Future<ApiResponse<CreateConversationDto>> createConversation(
    int participantOneID,
    int participantTwoID,
  ) async {
    Log.info("createConversation in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await chatApiService.createConversation(
        participantOneID,
        participantTwoID,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => CreateConversationDto.fromJson(data),
      );
    }, 'AccountRemoteDatasource/createConversation');
  }

  Future<ApiResponse<CreateMessageDto>> createMessage(
    int conversationID,
    int senderID,
    String messageText,
  ) async {
    Log.info("createMessage in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await chatApiService.createMessage(
        conversationID,
        senderID,
        messageText,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => CreateMessageDto.fromJson(data),
      );
    }, 'AccountRemoteDatasource/createMessage');
  }

  Future<ApiResponse<List<ConversationDto>>> getAllConversation(
    int userId,
  ) async {
    Log.info("createMessage in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await chatApiService.getAllConversation(
        userId,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => (data as List)
            .map((item) => ConversationDto.fromJson(item))
            .toList(),
      );
    }, 'AccountRemoteDatasource/createMessage');
  }

  Future<ApiResponse<List<MessageDto>>> getAllMessageDetail(
    int conversationId,
  ) async {
    Log.info("getAllMessageDetail in AccountRemoteDatasource");
    return executeWithHandling(() async {
      final response = await chatApiService.getAllMessageDetail(
        conversationId,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) =>
            (data as List).map((item) => MessageDto.fromJson(item)).toList(),
      );
    }, 'AccountRemoteDatasource/getAllMessageDetail');
  }
}
