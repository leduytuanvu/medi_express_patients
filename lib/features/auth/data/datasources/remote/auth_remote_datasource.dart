import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/network/api_response.dart';
import 'package:medi_express_patients/core/utils/common/execute_with_handling.dart';
import 'package:medi_express_patients/features/auth/data/dto/city_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/create_medical_history_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/district_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/forgot_password_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/register_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/user_dto.dart';
import 'package:medi_express_patients/features/auth/data/dto/ward_dto.dart';
import 'package:medi_express_patients/features/auth/domain/entities/user_entity.dart';
import '../../dto/auth_dto.dart';
import 'auth_api_service.dart';

class AuthRemoteDatasource {
  final AuthApiService apiService;

  AuthRemoteDatasource(this.apiService);

  Future<ApiResponse<AuthDto>> login(
    String phoneNumber,
    String password,
  ) async {
    Log.info("login in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.login(
        phoneNumber,
        password,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => AuthDto.fromJson(data),
      );
    }, 'AuthRemoteDatasource/login');
  }

  Future<ApiResponse<RegisterDto>> register(
    String phoneNumber,
    String name,
    String address,
    int wardId,
    int gender,
    String birthdate,
    String password,
  ) async {
    Log.info("register in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.register(
        phoneNumber,
        name,
        address,
        wardId,
        gender,
        birthdate,
        password,
        'Patient',
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => RegisterDto.fromJson(data),
      );
    }, 'AuthRemoteDatasource/register');
  }

  Future<ApiResponse<ForgotPasswordDto>> forgotPassword(
    String phoneNumber,
    String password,
  ) async {
    Log.info("forgotPassword in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.forgotPassword(
        phoneNumber,
        password,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => ForgotPasswordDto.fromJson(data),
      );
    }, 'AuthRemoteDatasource/forgotPassword');
  }

  Future<ApiResponse<int>> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    Log.info("changePassword in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.changePassword(
        oldPassword,
        newPassword,
      );
      return ApiResponse.fromJson(
        response.data!,
        (data) => int.parse(data.toString()),
      );
    }, 'AuthRemoteDatasource/changePassword');
  }

  Future<ApiResponse<List<CityDto>>> getAllCity() async {
    Log.info("getAllCity in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getAllCity();
      final Map<String, dynamic> data = response.data as Map<String, dynamic>;
      return ApiResponse.fromJson(
        data,
        (data) {
          final list = data as List<dynamic>;
          return list
              .map((item) => CityDto.fromJson(item as Map<String, dynamic>))
              .toList();
        },
      );
    }, 'AuthRemoteDatasource/getAllCity');
  }

  Future<ApiResponse<List<DistrictDto>>> getDistrictByCity(
    int cityId,
  ) async {
    Log.info("getDistrictByCity in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getDistrictByCity(cityId);
      return ApiResponse.fromJson(
        response.data!,
        (data) =>
            (data as List).map((item) => DistrictDto.fromJson(item)).toList(),
      );
    }, 'AuthRemoteDatasource/getDistrictByCity');
  }

  Future<ApiResponse<List<WardDto>>> getWardByDistrict(
    int districtId,
  ) async {
    Log.info("getWardByDistrict in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getWardByDistrict(districtId);
      return ApiResponse.fromJson(
        response.data!,
        (data) =>
            (data as List).map((item) => WardDto.fromJson(item)).toList(),
      );
    }, 'AuthRemoteDatasource/getWardByDistrict');
  }

  Future<bool> checkPhoneNumberExists(
    String phoneNumber,
  ) async {
    Log.info("checkPhoneNumberExists in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.checkPhoneNumberExists(phoneNumber);
      final responseData = response.data;
      if(responseData!["code"] == -1) {
        return true;
      }
      return false;
    }, 'AuthRemoteDatasource/checkPhoneNumberExists');
  }

  Future<ApiResponse<List<UserDto>>> getUserInformation() async {
    Log.info("getUserInformation in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.getUserInformation();
      return ApiResponse.fromJson(
        response.data!,
            (data) =>
            (data as List).map((item) => UserDto.fromJson(item)).toList(),
      );
    }, 'AuthRemoteDatasource/getUserInformation');
  }

  Future<ApiResponse<CreateMedicalHistoryDto>> createMedicalHistory(
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
    Log.info("createMedicalHistory in AuthRemoteDatasource");
    return executeWithHandling(() async {
      final response = await apiService.createMedicalHistory(
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
      return ApiResponse.fromJson(
        response.data!,
        (data) => CreateMedicalHistoryDto.fromJson(data),
      );
    }, 'AuthRemoteDatasource/createMedicalHistory');
  }
}
