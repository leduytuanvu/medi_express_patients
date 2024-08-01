class PhoneValidator {
  static final RegExp phonePattern = RegExp(r'^\+?[0-9]{10,15}$');

  static bool validate(String phoneNumber) {
    return phonePattern.hasMatch(phoneNumber);
  }
}
