class EmailValidator {
  static final RegExp emailPattern = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static bool validate(String email) {
    return emailPattern.hasMatch(email);
  }
}
