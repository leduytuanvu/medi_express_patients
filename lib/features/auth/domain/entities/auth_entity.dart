class AuthEntity {
  final String accessToken;
  final String refreshToken;
  final String isFirstTimeOpenApp;
  final int expiresIn;

  AuthEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.isFirstTimeOpenApp,
    required this.expiresIn,
  });
}
