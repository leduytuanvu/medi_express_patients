import 'dart:math' as math;

import 'package:intl/intl.dart';

extension StringExtension on String {
  // Capitalize the first letter of the string and lowercase the rest
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';

  // Convert each word in the string to title case (capitalize first letter of each word)
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((String str) => str.toCapitalized())
      .join(' ');

  // Generate a random string of a specified length from the characters of this string
  String randomString(int len) {
    return List<String>.generate(
      len,
      (int index) => this[math.Random().nextInt(length)],
    ).join();
  }

  // Convert ISO 8601 date string to 'dd/MM/yyyy' format
  String toFormattedDate() {
    // Parse the date string to a DateTime object
    DateTime dateTime = DateTime.parse(this);

    // Format the DateTime object to the desired format
    DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    return dateFormat.format(dateTime);
  }

  // Extract and return the time in "HH:mm" format from the string
  String toHourMinute() {
    return substring(11, 16);
  }

  // Extract and return the day part from the string
  String toDate() {
    return substring(8, 10);
  }

  // Extract and return the month part from the string
  String toMonth() {
    return substring(5, 7);
  }

  // Convert the string representing a number to a formatted VND currency string
  String toVnd() {
    // Convert the string to an integer
    int value = int.parse(this);

    // Format the integer with a dot separator and add the currency symbol
    String formattedValue = value.toString().replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]}.',
        );

    // Append the currency symbol
    return '$formattedValueđ';
  }
}
