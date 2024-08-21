import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/chat/domain/entities/create_conversation_entity.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_conversation_params.dart';
import 'package:medi_express_patients/features/chat/domain/repositories/chat_repository.dart';

class CreateConversationUsecase
    implements UseCase<CreateConversationEntity, CreateConversationParams> {
  final ChatRepository repository;

  CreateConversationUsecase(this.repository);

  @override
  Future<Either<Failure, CreateConversationEntity>> call(
      CreateConversationParams params) async {
    try {
      Log.info("CreateConversationUsecase");
      final result = await repository.createConversation(params);
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
