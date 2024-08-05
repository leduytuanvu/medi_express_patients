import 'dart:convert';

import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/utils/common/constants.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/create_medical_history_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/register_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/user_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/local/doctor_local_datasource.dart';
import 'package:medi_express_patients/features/doctor/data/datasources/remote/doctor_remote_datasource.dart';
import 'package:medi_express_patients/features/doctor/domain/entities/doctor_entity.dart';
import 'package:medi_express_patients/features/doctor/domain/repositories/doctor_repository.dart';

class DoctorRepositoryImpl implements DoctorRepository {
  final DoctorLocalDatasource localDatasource;
  final DoctorRemoteDatasource remoteDatasource;

  DoctorRepositoryImpl(this.localDatasource, this.remoteDatasource);

  @override
  Future<List<DoctorEntity>> getAllDoctor() async {
    Log.info("login in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getAllDoctor();
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/login',
        );
      }
    }, 'AuthRepositoryImpl/login');
  }
}
