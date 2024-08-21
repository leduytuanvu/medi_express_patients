import 'package:dio/dio.dart';

class ChatApiService {
  final Dio dio;

  ChatApiService(this.dio);

  Future<Response<Map<String, dynamic>>> createConversation(
    int participantOneID,
    int participantTwoID,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/chat/createConversation',
      data: {
        'ParticipantOneID': participantOneID,
        'ParticipantTwoID': participantTwoID,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> createMessage(
    int conversationID,
    int senderID,
    String messageText,
  ) async {
    final response = await dio.post<Map<String, dynamic>>(
      '/mediexpress/chat/createMessage',
      data: {
        'ConversationID': conversationID,
        'SenderID': senderID,
        'MessageText': messageText,
      },
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getAllConversation(
    int userId,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/chat/getConversationList',
      queryParameters: {'userID': userId},
    );
    return response;
  }

  Future<Response<Map<String, dynamic>>> getAllMessageDetail(
    int conversationId,
  ) async {
    final response = await dio.get<Map<String, dynamic>>(
      '/mediexpress/chat/getListMessageDetail/$conversationId',
    );
    return response;
  }
}
