class AuthEntity {
  String accessToken;
  String refreshToken;
  int expiresIn;
  String firstTimeOpenApp;

  AuthEntity({
    this.accessToken = '',
    this.refreshToken = '',
    this.expiresIn = -1,
    this.firstTimeOpenApp = 'false',
  });

  @override
  String toString() {
    return '========= $accessToken, $refreshToken, $expiresIn, $firstTimeOpenApp';
  }
}
