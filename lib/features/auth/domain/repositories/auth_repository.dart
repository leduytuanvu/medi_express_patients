import 'package:medi_express_patients/features/auth/domain/entities/city_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/create_medical_history_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/district_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/forgot_password_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/register_entity.dart';
import 'package:medi_express_patients/features/auth/domain/entities/ward_entity.dart';

import '../entities/auth_entity.dart';

abstract class AuthRepository {
  Future<AuthEntity> login(
    String phoneNumber,
    String password,
  );

  Future<RegisterEntity> register(
    String phoneNumber,
    String name,
    String address,
    int wardId,
    int gender,
    String birthdate,
    String password,
  );

  Future<ForgotPasswordEntity> forgotPassword(
    String phoneNumber,
    String password,
  );

  Future<int> changePassword(
    String oldPassword,
    String newPassword,
  );

  Future<List<CityEntity>> getAllCity();

  Future<List<DistrictEntity>> getDistrictByCity(int cityId);

  Future<List<WardEntity>> getWardByDistrict(int districtId);

  Future<AuthEntity> getAuthFromLocal();

  Future<String> getAccessTokenFromLocal();

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
  );
}
