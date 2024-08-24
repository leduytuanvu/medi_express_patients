import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/home/data/datasources/local/home_local_datasource.dart';
import 'package:medi_express_patients/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:medi_express_patients/features/home/domain/entities/health_record_entity.dart';
import 'package:medi_express_patients/features/home/domain/entities/home_examination_package_entity.dart';
import 'package:medi_express_patients/features/home/domain/entities/upload_patient_entity.dart';
import 'package:medi_express_patients/features/home/domain/params/upload_patient_params.dart';
import 'package:medi_express_patients/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeLocalDatasource localDatasource;
  final HomeRemoteDatasource remoteDatasource;

  HomeRepositoryImpl(this.localDatasource, this.remoteDatasource);

  @override
  Future<List<HealthRecordEntity>> getAllHealthRecord() async {
    Log.info("getAllHealthRecord in HomeRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getAllHealthRecord();
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in HomeRepositoryImpl/getAllHealthRecord',
        );
      }
    }, 'HomeRepositoryImpl/getAllHealthRecord');
  }

  @override
  Future<List<HomeExaminationPackageEntity>>
      getListHomeExaminationPackage() async {
    Log.info("getListHomeExaminationPackage in HomeRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse =
          await remoteDatasource.getListHomeExaminationPackage();
      if (apiResponse.code == 1) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in HomeRepositoryImpl/getListHomeExaminationPackage',
        );
      }
    }, 'HomeRepositoryImpl/getListHomeExaminationPackage');
  }

  @override
  Future<UploadPatientEntity> uploadPatient(UploadPatientParams params) async {
    Log.info("uploadPatient in HomeRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.uploadPatient(
        params.file,
        params.nameHealthRecord,
        params.description,
        params.createDate,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in HomeRepositoryImpl/uploadPatient',
        );
      }
    }, 'HomeRepositoryImpl/uploadPatient');
  }
}
