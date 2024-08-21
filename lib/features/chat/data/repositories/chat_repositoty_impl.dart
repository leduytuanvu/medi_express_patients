import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/chat/data/datasource/local/chat_local_datasource.dart';
import 'package:medi_express_patients/features/chat/data/datasource/remote/chat_remote_datasource.dart';
import 'package:medi_express_patients/features/chat/domain/entities/conversation_entity.dart';
import 'package:medi_express_patients/features/chat/domain/entities/create_conversation_entity.dart';
import 'package:medi_express_patients/features/chat/domain/entities/create_message_entity.dart';
import 'package:medi_express_patients/features/chat/domain/entities/message_entity.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_conversation_params.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_message_params.dart';
import 'package:medi_express_patients/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatLocalDatasource localDatasource;
  final ChatRemoteDatasource remoteDatasource;

  ChatRepositoryImpl(this.localDatasource, this.remoteDatasource);

  @override
  Future<List<MessageEntity>> getAllMessage(
    int conversationId,
  ) async {
    Log.info("getAllMessage in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getAllMessageDetail(
        conversationId,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getAllMessage',
        );
      }
    }, 'AccountRepositoryImpl/getAllMessage');
  }

  @override
  Future<List<ConversationEntity>> getAllConversation(
    int userId,
  ) async {
    Log.info("getAllConversation in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getAllConversation(userId);
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/getAllConversation',
        );
      }
    }, 'AccountRepositoryImpl/getAllConversation');
  }

  @override
  Future<CreateMessageEntity> createMessage(
    CreateMessageParams params,
  ) async {
    Log.info("createMessage in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.createMessage(
        params.conversationID,
        params.senderID,
        params.messageText,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/createMessage',
        );
      }
    }, 'AccountRepositoryImpl/createMessage');
  }

  @override
  Future<CreateConversationEntity> createConversation(
    CreateConversationParams params,
  ) async {
    Log.info("createConversation in AccountRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.createConversation(
        params.participantOneID,
        params.participantTwoID,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AccountRepositoryImpl/createConversation',
        );
      }
    }, 'AccountRepositoryImpl/createConversation');
  }
}
