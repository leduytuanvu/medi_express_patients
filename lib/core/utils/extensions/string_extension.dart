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

  // Extract and return the time in "HH:mm" format after adding 7 hours
  String toAdjustedHourMinute() {
    DateTime dateTime = DateTime.parse(this).toUtc().add(Duration(hours: 7));
    DateFormat timeFormat = DateFormat('HH:mm');
    return timeFormat.format(dateTime);
  }

  // Extract and return the time in "HH:mm" format from the string
  String toHourMinute() {
    return substring(11, 16);
  }

  String toShortTime() {
    // Split the string by colon
    final parts = split(':');

    // Check if the input string is in the correct format
    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1]}';
    } else {
      // Return the original string if it doesn't match the expected format
      return this;
    }
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

  String toRelativeTime() {
    // Parse the ISO 8601 date string to a DateTime object
    DateTime dateTime = DateTime.parse(this).toLocal();

    // Get the current time
    DateTime now = DateTime.now();

    // Calculate the difference in hours between now and the given time
    Duration difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'Vừa xong';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} phút trước';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} giờ trước';
    } else {
      return DateFormat('dd/MM/yyyy').format(dateTime);
    }
  }

  String get address {
    final parts = this.split(',');
    return parts.length > 0 ? parts[0].trim() : '';
  }

  String get ward {
    final parts = this.split(',');
    return parts.length > 1 ? parts[1].trim() : '';
  }

  String get city {
    final parts = this.split(',');
    return parts.length > 2 ? parts[2].trim() : '';
  }

  String get district {
    final parts = this.split(',');
    return parts.length > 3 ? parts[3].trim() : '';
  }

  String toIsoFormat() {
    // Split the input string into day, month, and year
    final parts = this.split('/');
    if (parts.length != 3) {
      throw FormatException('Invalid date format');
    }

    final day = parts[0].padLeft(2, '0');
    final month = parts[1].padLeft(2, '0');
    final year = parts[2];

    // Return the new format
    return '$year-$month-$day';
  }

  // 2024-08-29T06:47:24.000Z -> 13:47 29/08/2024
  String toFormattedString() {
    // Parse the ISO 8601 string
    DateTime dateTime = DateTime.parse(this).toUtc();

    // Add 7 hours to the date-time
    DateTime adjustedDateTime = dateTime.add(Duration(hours: 7));

    // Define the desired date format
    final DateFormat timeFormat = DateFormat("HH:mm");
    final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

    // Format the adjusted date-time
    String time = timeFormat.format(adjustedDateTime);
    String date = dateFormat.format(adjustedDateTime);

    // Return the formatted string
    return "$time $date";
  }

  // '' -> 13:47 29/08/2024 (current datetime)
  String toFormattedStringCurrentDatetime() {
    // Parse the ISO 8601 string
    DateTime dateTime = DateTime.parse(this).toUtc();

    // Add 7 hours to the date-time
    DateTime adjustedDateTime = dateTime.add(Duration(hours: 7));

    // Define the desired date format
    final DateFormat timeFormat = DateFormat("HH:mm");
    final DateFormat dateFormat = DateFormat("dd/MM/yyyy");

    // Format the adjusted date-time
    String time = timeFormat.format(adjustedDateTime);
    String date = dateFormat.format(adjustedDateTime);

    // Return the formatted string
    return "$time $date";
  }
}
