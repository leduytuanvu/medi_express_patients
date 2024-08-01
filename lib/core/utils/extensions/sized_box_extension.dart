import 'package:flutter/widgets.dart';

extension SizedBoxExtension on num {
  // Extension for SizedBox with only height
  SizedBox get sbh => SizedBox(height: toDouble());

  // Extension for SizedBox with only width
  SizedBox get sbw => SizedBox(width: toDouble());

  // Extension for SizedBox with both height and width
  SizedBox sb({double? height, double? width}) => SizedBox(
        height: height ?? toDouble(),
        width: width ?? toDouble(),
      );
}
