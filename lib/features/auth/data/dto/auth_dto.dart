import 'package:medi_express_patients/features/auth/domain/entities/auth_entity.dart';

class AuthDto {
  final String accessToken;
  final String tokenType;
  final String refreshToken;
  final int expiresIn;
  final String idToken;

  AuthDto({
    required this.accessToken,
    required this.tokenType,
    required this.refreshToken,
    required this.expiresIn,
    required this.idToken,
  });

  factory AuthDto.fromJson(Map<String, dynamic> json) {
    return AuthDto(
      accessToken: json['AccessToken'],
      tokenType: json['TokenType'],
      refreshToken: json['RefreshToken'],
      expiresIn: json['ExpiresIn'],
      idToken: json['IdToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AccessToken': accessToken,
      'TokenType': tokenType,
      'RefreshToken': refreshToken,
      'ExpiresIn': expiresIn,
      'IdToken': idToken,
    };
  }

  AuthEntity toEntity() {
    return AuthEntity(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}
