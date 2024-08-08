import 'dart:math' as math;
import 'package:intl/intl.dart';

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((String str) => str.toCapitalized())
      .join(' ');

  String randomString(int len) {
    return List<String>.generate(
      len,
      (int index) => this[math.Random().nextInt(length)],
    ).join();
  }

  String toFormattedDate() {
    // Parse the date string to a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Format the DateTime object to the desired format
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

  String toHourMinute() {
    return substring(0, 5);
  }

  String toDate() {
    return substring(8, 10);
  }

  String toMonth() {
    return substring(5, 7);
  }
}
