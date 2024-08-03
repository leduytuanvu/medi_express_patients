import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/utils/comon/constants.dart';
import 'package:medi_express_patients/core/utils/comon/execute_with_handling.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/create_medical_history_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/register_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/local/auth_local_datasource.dart';
import '../datasources/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDatasource localDatasource;
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl(this.localDatasource, this.remoteDatasource);

  @override
  Future<AuthEntity> login(
    String phoneNumber,
    String password,
  ) async {
    Log.info("login in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.login(
        phoneNumber,
        password,
      );
      if (apiResponse.code == 1) {
        await localDatasource.save(
          Constants.keyAccessToken,
          apiResponse.data!.accessToken,
        );
        await localDatasource.save(
          Constants.keyRefreshToken,
          apiResponse.data!.refreshToken,
        );
        await localDatasource.save(
          Constants.keyExpiresIn,
          apiResponse.data!.expiresIn.toString(),
        );
        await localDatasource.save(
          Constants.keyFirstTimeOpenApp,
          'false',
        );
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/login',
        );
      }
    }, 'AuthRepositoryImpl/login');
  }

  @override
  Future<RegisterEntity> register(
    String phoneNumber,
    String name,
    String address,
    int wardId,
    int gender,
    String birthdate,
    String password,
  ) async {
    Log.info("register in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.register(
        phoneNumber,
        name,
        address,
        wardId,
        gender,
        birthdate,
        password,
      );
      if (apiResponse.code == 1) {
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/register',
        );
      }
    }, 'AuthRepositoryImpl/register');
  }

  @override
  Future<ForgotPasswordEntity> forgotPassword(
    String phoneNumber,
    String password,
  ) async {
    Log.info("forgotPassword in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.forgotPassword(
        phoneNumber,
        password,
      );
      if (apiResponse.code == 1) {
        // await localDatasource.saveUser(userEntity);
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/forgotPassword',
        );
      }
    }, 'AuthRepositoryImpl/forgotPassword');
  }

  @override
  Future<int> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    Log.info("login in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.changePassword(
        oldPassword,
        newPassword,
      );
      if (apiResponse.data == 1) {
        // await localDatasource.saveUser(userEntity);
        return apiResponse.data!;
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/forgotPassword',
        );
      }
    }, 'AuthRepositoryImpl/forgotPassword');
  }

  @override
  Future<List<CityEntity>> getAllCity() async {
    Log.info("getAllCity in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getAllCity();
      if (apiResponse.code == 1 && apiResponse.data != null) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/getAllCity',
        );
      }
    }, 'AuthRepositoryImpl/getAllCity');
  }

  @override
  Future<List<DistrictEntity>> getDistrictByCity(int cityId) async {
    Log.info("getDistrictByCity in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getDistrictByCity(cityId);
      if (apiResponse.code == 1 && apiResponse.data != null) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/getDistrictByCity',
        );
      }
    }, 'AuthRepositoryImpl/getDistrictByCity');
  }

  @override
  Future<List<WardEntity>> getWardByDistrict(int districtId) async {
    Log.info("getWardByDistrict in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getWardByDistrict(districtId);
      if (apiResponse.code == 1 && apiResponse.data != null) {
        return apiResponse.data!.map((dto) => dto.toEntity()).toList();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/getWardByDistrict',
        );
      }
    }, 'AuthRepositoryImpl/getWardByDistrict');
  }

  @override
  Future<AuthEntity> getAuthFromLocal() async {
    Log.info("getAuthFromLocal in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final accessToken = await localDatasource.get(Constants.keyAccessToken);
      final refreshToken = await localDatasource.get(Constants.keyRefreshToken);
      final expireIn = await localDatasource.get(Constants.keyExpiresIn);
      final firstTimeOpenApp =
          await localDatasource.get(Constants.keyFirstTimeOpenApp);
      final auth = AuthEntity(
        accessToken: accessToken ?? '',
        refreshToken: refreshToken ?? '',
        expiresIn: int.parse(expireIn ?? '-1'),
        firstTimeOpenApp: firstTimeOpenApp ?? 'true',
      );
      return auth;
    }, 'AuthRepositoryImpl/getAuthFromLocal');
  }

  @override
  Future<CreateMedicalHistoryEntity> createMedicalHistory(
    int patientId,
    bool hypertension,
    bool diabetes,
    bool heartDisease,
    bool stroke,
    bool asthma,
    bool epilepsy,
    bool copd,
    bool palpitations,
    String otherMedicalHistory,
  ) async {
    Log.info("createMedicalHistory in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.createMedicalHistory(
        patientId,
        hypertension,
        diabetes,
        heartDisease,
        stroke,
        asthma,
        epilepsy,
        copd,
        palpitations,
        otherMedicalHistory,
      );
      if (apiResponse.code == 1) {
        // await localDatasource.saveUser(userEntity);
        return apiResponse.data!.toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/createMedicalHistory',
        );
      }
    }, 'AuthRepositoryImpl/createMedicalHistory');
  }
}
