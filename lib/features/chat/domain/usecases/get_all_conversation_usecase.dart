import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/chat/domain/entities/conversation_entity.dart';
import 'package:medi_express_patients/features/chat/domain/repositories/chat_repository.dart';

class GetAllConversationUsecase
    implements UseCase<List<ConversationEntity>, int> {
  final ChatRepository repository;

  GetAllConversationUsecase(this.repository);

  @override
  Future<Either<Failure, List<ConversationEntity>>> call(int userId) async {
    try {
      Log.info("CreateMessageUsecase");
      final result = await repository.getAllConversation(userId);
      Log.info('result: $result');
      return Right(result);
    } catch (error) {
      Log.info('error result: $error');
      if (error is Exception) {
        return Left(error.toFailure());
      } else {
        return Left(UnknownFailure('Unknown error', error.toString()));
      }
    }
  }
}
