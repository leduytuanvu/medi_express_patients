class AuthEntity {
  String accessToken;
  String refreshToken;
  int expiresIn;
  String firstTimeOpenApp;

  AuthEntity({
    this.accessToken = '',
    this.refreshToken = '',
    this.expiresIn = -1,
    this.firstTimeOpenApp = 'true',
  });

  @override
  String toString() {
    return '========= $accessToken, $refreshToken, $expiresIn, $firstTimeOpenApp';
  }
}
