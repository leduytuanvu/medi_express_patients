import 'dart:math' as math;

///
extension StringExtension on String {
  ///
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  ///
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((String str) => str.toCapitalized())
      .join(' ');

  ///
  String randomString(int len) {
    return List<String>.generate(
      len,
      (int index) => this[math.Random().nextInt(length)],
    ).join();
  }
}
