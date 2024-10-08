import 'package:flutter/material.dart';
import 'package:medi_express_patients/core/utils/extensions/context_extension.dart';

class AppTextStyle {
  static TextStyle _base({
    required BuildContext context,
    Paint? background,
    Color? backgroundColor,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<FontFeature>? fontFeatures,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    Paint? foreground,
    double? height,
    double? letterSpacing,
    Locale? locale,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
    TextStyle? textStyle,
    double? wordSpacing,
    String fontFamily = 'Bepro',
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      background: background,
      backgroundColor: backgroundColor,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontFeatures: fontFeatures,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      foreground: foreground,
      height: height,
      letterSpacing: letterSpacing,
      locale: locale,
      shadows: shadows,
      textBaseline: textBaseline,
      wordSpacing: wordSpacing,
    ).merge(textStyle);
  }

  static TextStyle bepro({
    required BuildContext context,
    Paint? background,
    Color? backgroundColor,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<FontFeature>? fontFeatures,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    Paint? foreground,
    double? height,
    double? letterSpacing,
    Locale? locale,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
    TextStyle? textStyle,
    double? wordSpacing,
  }) {
    return _base(
      context: context,
      background: background,
      backgroundColor: backgroundColor,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontFeatures: fontFeatures,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      foreground: foreground,
      height: height,
      letterSpacing: letterSpacing,
      locale: locale,
      shadows: shadows,
      textBaseline: textBaseline,
      textStyle: textStyle,
      wordSpacing: wordSpacing,
      fontFamily: 'Bepro',
    );
  }

  // static TextStyle get bigError => bepro(
  //       fontSize: 32,
  //       fontWeight: FontWeight.w700,
  //       color: Colors.black,
  //     );

  // static TextStyle get mediumError => bepro(
  //       fontSize: 32,
  //       fontWeight: FontWeight.w700,
  //       color: Colors.black,
  //     );

  // static TextStyle get smallError => bepro(
  //       fontSize: 32,
  //       fontWeight: FontWeight.w700,
  //       color: Colors.black,
  //     );

  // static TextStyle get bigTitle => bepro(
  //       fontSize: 32,
  //       fontWeight: FontWeight.w700,
  //       color: Colors.black,
  //     );

  // static TextStyle get mediumTitle => bepro(
  //       fontSize: 32,
  //       fontWeight: FontWeight.w700,
  //       color: Colors.black,
  //     );

  // static TextStyle get smallTitle => bepro(
  //       fontSize: 32,
  //       fontWeight: FontWeight.w700,
  //       color: Colors.black,
  //     );

  // static TextStyle get bigBody => bepro(
  //       fontSize: 32,
  //       fontWeight: FontWeight.w700,
  //       color: Colors.black,
  //     );

  static TextStyle smallTitle(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle titleButtonPatient(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  static TextStyle titleNumberPatient(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(23),
        fontWeight: FontWeight.w600,
        color: Color(0xFF005495),
      );

  static TextStyle bodyNumberPatient(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(12),
        fontWeight: FontWeight.w600,
        color: Color(0xFF005495),
      );

  static TextStyle mediumItemTitle(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(16),
        fontWeight: FontWeight.w700,
        color: Colors.black,
      );

  static TextStyle smallItemTitle(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(15),
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  static TextStyle bigItemPatientTitle(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(15),
        fontWeight: FontWeight.w700,
        color: Colors.black,
      );

  static TextStyle mediumDateTime(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w400,
        color: const Color(0xFF777F89),
      );

  static TextStyle mediumItemBody(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(12),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle bigItemBody(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(13),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle mediumItemPrice(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(13),
        fontWeight: FontWeight.w600,
        color: const Color(0xFF005495),
      );

  static TextStyle smallItem(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(11),
        fontWeight: FontWeight.w500,
        color: const Color(0xFF121926),
      );

  static TextStyle mediumTitle(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(18),
        fontWeight: FontWeight.w700,
        color: Colors.black,
      );

  static TextStyle smallBody(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(12),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle smallBodyW600(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(12),
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  static TextStyle smallBodyW500(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(12),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle smallBodyLink(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(12),
        fontWeight: FontWeight.w500,
        color: Color(0xFF005495),
      );

  static TextStyle linkH5(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w500,
        color: Color(0xFF005495),
      );

  static TextStyle mediumBody(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle mediumBodyWithColor(BuildContext context, Color color) =>
      bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w500,
        color: color,
      );

  static TextStyle bigBody(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(16),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  static TextStyle bodyH1(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(20),
        fontWeight: FontWeight.w500,
        color: Colors.black,
      );

  // static TextStyle get smallBody => bepro(
  //       fontSize: 32,
  //       fontWeight: FontWeight.w700,
  //       color: Colors.black,
  //     );

  static TextStyle appBar(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(16),
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  static TextStyle bigTitle(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(19),
        fontWeight: FontWeight.w700,
        color: Colors.white,
      );

  // static TextStyle get button => bepro(
  //       fontSize: 32,
  //       fontWeight: FontWeight.w700,
  //       color: Colors.white,
  //     );

  static TextStyle mediumHint(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(11),
        fontWeight: FontWeight.w500,
        color: const Color(0xFF777F89),
      );

  static TextStyle bigHint(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(13),
        fontWeight: FontWeight.w400,
        color: const Color(0xFF777F89),
      );

  static TextStyle searchHint(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w500,
        color: const Color(0xFF9CA4B0),
      );

  static TextStyle bodyIntro(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(13),
        fontWeight: FontWeight.w400,
        color: const Color(0xFF777F89),
        height: 1.7,
      );

  static TextStyle mediumTextButton(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w600,
        color: Colors.black,
      );

  static TextStyle button(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );

  static TextStyle link(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w700,
        color: const Color(0xFF005495),
      );

  static TextStyle linkW400(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(14),
        fontWeight: FontWeight.w400,
        color: const Color(0xFF005495),
      );

  static TextStyle mediumError(BuildContext context) => bepro(
        context: context,
        fontSize: context.sp(11),
        fontWeight: FontWeight.w400,
        color: const Color.fromARGB(255, 214, 63, 53),
      );

  // static TextStyle get caption => bepro(
  //       fontSize: 12,
  //       fontWeight: FontWeight.normal,
  //       color: Colors.grey,
  //     );

  static TextStyle custom({
    required BuildContext context,
    Paint? background,
    Color? backgroundColor,
    Color? color,
    TextDecoration? decoration,
    Color? decorationColor,
    TextDecorationStyle? decorationStyle,
    double? decorationThickness,
    List<FontFeature>? fontFeatures,
    double? fontSize,
    FontStyle? fontStyle,
    FontWeight? fontWeight,
    Paint? foreground,
    double? height,
    double? letterSpacing,
    Locale? locale,
    List<Shadow>? shadows,
    TextBaseline? textBaseline,
    TextStyle? textStyle,
    double? wordSpacing,
    String fontFamily = 'Bepro',
  }) {
    return _base(
      context: context,
      background: background,
      backgroundColor: backgroundColor,
      color: color,
      decoration: decoration,
      decorationColor: decorationColor,
      decorationStyle: decorationStyle,
      decorationThickness: decorationThickness,
      fontFeatures: fontFeatures,
      fontSize: fontSize,
      fontStyle: fontStyle,
      fontWeight: fontWeight,
      foreground: foreground,
      height: height,
      letterSpacing: letterSpacing,
      locale: locale,
      shadows: shadows,
      textBaseline: textBaseline,
      textStyle: textStyle,
      wordSpacing: wordSpacing,
      fontFamily: fontFamily,
    );
  }
}
