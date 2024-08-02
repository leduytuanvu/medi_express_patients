class AuthEntity {
  String accessToken;
  String refreshToken;
  int expiresIn;
  String isTheFirstTime;

  AuthEntity({
    this.accessToken = '',
    this.refreshToken = '',
    this.expiresIn = -1,
    this.isTheFirstTime = 'combros',
  });
}
