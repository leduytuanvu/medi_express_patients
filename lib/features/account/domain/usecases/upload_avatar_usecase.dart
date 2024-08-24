import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/usecases/usecase.dart';
import 'package:medi_express_patients/core/utils/extensions/exception_extension.dart';
import 'package:medi_express_patients/features/account/domain/entities/upload_avatar_entity.dart';
import 'package:medi_express_patients/features/account/domain/repositories/account_repository.dart';

class UploadAvatarUsecase implements UseCase<UploadAvatarEntity, File> {
  final AccountRepository repository;

  UploadAvatarUsecase(this.repository);

  @override
  Future<Either<Failure, UploadAvatarEntity>> call(File file) async {
    try {
      Log.info("UploadAvatarUsecase");
      final result = await repository.uploadAvatar(file);
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
