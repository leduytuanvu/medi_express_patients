import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/chat/domain/entities/create_message_entity.dart';
import 'package:medi_express_patients/features/chat/domain/params/create_message_params.dart';
import 'package:medi_express_patients/features/chat/domain/repositories/chat_repository.dart';

class CreateMessageUsecase
    implements UseCase<CreateMessageEntity, CreateMessageParams> {
  final ChatRepository repository;

  CreateMessageUsecase(this.repository);

  @override
  Future<Either<Failure, CreateMessageEntity>> call(
      CreateMessageParams params) async {
    try {
      Log.info("CreateMessageUsecase");
      final result = await repository.createMessage(params);
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
