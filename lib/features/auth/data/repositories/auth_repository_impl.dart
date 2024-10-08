import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/exceptions.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/constants.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/create_medical_history_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/register_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/user_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';

import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
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
  Future<UserEntity> getUserInformation() async {
    Log.info("getUserInformation in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.getUserInformation();
      if (apiResponse.code == 1) {
        return apiResponse.data![0].toEntity();
      } else {
        throw ApiErrorException(
          apiResponse.message,
          '${apiResponse.message} in AuthRepositoryImpl/getUserInformation',
        );
      }
    }, 'AuthRepositoryImpl/getUserInformation');
  }

  @override
  Future<RegisterEntity> register(
    String phoneNumber,
    String name,
    String address,
    String email,
    int wardId,
    int gender,
    String birthdate,
    String bhytCode,
    String password,
  ) async {
    Log.info("register in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.register(
        phoneNumber,
        name,
        address,
        email,
        wardId,
        gender,
        birthdate,
        bhytCode,
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
  Future<ApiResponse<List<int>>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    Log.info("login in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.changePassword(
        oldPassword,
        newPassword,
      );
      return apiResponse;
      // if (apiResponse.code == 1) {
      //   // await localDatasource.saveUser(userEntity);
      //   return apiResponse.data!;
      // } else {
      //   throw ApiErrorException(
      //     apiResponse.message,
      //     '${apiResponse.message} in AuthRepositoryImpl/forgotPassword',
      //   );
      // }
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
      Log.info("mmmmmmmmmmmmmmmmmmmmmm: ${firstTimeOpenApp}");
      final auth = AuthEntity(
        accessToken: accessToken ?? '',
        refreshToken: refreshToken ?? '',
        expiresIn: int.parse(expireIn ?? '-1'),
        firstTimeOpenApp: firstTimeOpenApp ?? 'true',
      );
      Log.info("bbbbbbbbbbbbbbbbbbbbbbbbb: ${auth.toString()}");
      return auth;
    }, 'AuthRepositoryImpl/getAuthFromLocal');
  }

  @override
  Future<String> getLanguageFromLocal() async {
    Log.info("getLanguageFromLocal in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final accessToken = await localDatasource.get(Constants.keyLanguage);
      return accessToken ?? "";
    }, 'AuthRepositoryImpl/getLanguageFromLocal');
  }

  @override
  Future<bool> saveAuthToLocal(AuthEntity authEntity) {
    Log.info("saveAuthToLocal in AuthRepositoryImpl");
    return executeWithHandling(() async {
      await localDatasource.save(
          Constants.keyAccessToken, authEntity.accessToken);
      await localDatasource.save(
          Constants.keyRefreshToken, authEntity.refreshToken);
      await localDatasource.save(
          Constants.keyExpiresIn, authEntity.expiresIn.toString());
      await localDatasource.save(
          Constants.keyFirstTimeOpenApp, authEntity.firstTimeOpenApp);
      return true;
    }, 'AuthRepositoryImpl/saveAuthToLocal');
  }

  @override
  Future<bool> saveLanguageToLocal(String language) {
    Log.info("saveLanguageToLocal in AuthRepositoryImpl");
    return executeWithHandling(() async {
      await localDatasource.save(Constants.keyLanguage, language);
      return true;
    }, 'AuthRepositoryImpl/saveLanguageToLocal');
  }

  @override
  Future<bool> checkPhoneNumberExists(String phoneNumber) {
    Log.info("checkPhoneNumberExists in AuthRepositoryImpl");
    return executeWithHandling(() async {
      final apiResponse = await remoteDatasource.checkPhoneNumberExists(
        phoneNumber,
      );
      return apiResponse;
    }, 'AuthRepositoryImpl/saveAuthToLocal');
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
