class PasswordValidator {
  static final RegExp passwordPattern = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
  );

  static bool validate(String password) {
    return passwordPattern.hasMatch(password);
  }
}
