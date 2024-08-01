import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/presentation/pages/unknown_route_page.dart';

extension ContextExtension on BuildContext {
  T? tryRead<T>() {
    try {
      return Get.find<T>();
    } catch (_) {
      return null;
    }
  }

  /// Get responsive width
  double wp(double percentage) => ScreenUtil().screenWidth * percentage / 100;

  /// Get responsive height
  double hp(double percentage) => ScreenUtil().screenHeight * percentage / 100;

  /// Get responsive radius as double
  double rp(double value) => ScreenUtil().radius(value);

  /// Get responsive text size
  double sp(double size) => ScreenUtil().setSp(size);

  /// Get responsive width
  double rw(double width) => ScreenUtil().setWidth(width);

  /// Get responsive height
  double rh(double height) => ScreenUtil().setHeight(height);

  // Navigate to a new screen
  Future<dynamic>? toScreen(Widget screen,
      {dynamic arguments, Bindings? binding}) {
    return Get.to(() => screen, arguments: arguments, binding: binding);
  }

  // Navigate to a new screen using named routes
  Future<dynamic>? toNamedScreen(String routeName,
      {dynamic arguments, dynamic parameters}) {
    return Get.toNamed(routeName, arguments: arguments, parameters: parameters);
  }

  // Navigate to a new screen and remove all previous screens
  Future<dynamic>? offAllScreen(Widget screen,
      {dynamic arguments, Bindings? binding}) {
    return Get.offAll(() => screen, arguments: arguments, binding: binding);
  }

  // Navigate to a new screen and remove the previous screen
  Future<dynamic>? offScreen(Widget screen,
      {dynamic arguments, Bindings? binding}) {
    return Get.off(() => screen, arguments: arguments, binding: binding);
  }

  // Go back to the previous screen
  void backScreen({dynamic result}) {
    Get.back(result: result);
  }

  // Show a dialog
  Future<dynamic>? showDialogScreen(Widget dialog,
      {bool barrierDismissible = true}) {
    return Get.dialog(dialog, barrierDismissible: barrierDismissible);
  }

  // Show a bottom sheet
  Future<dynamic>? showBottomSheetScreen(Widget bottomSheet,
      {bool isDismissible = true, bool enableDrag = true}) {
    return Get.bottomSheet(bottomSheet,
        isDismissible: isDismissible, enableDrag: enableDrag);
  }

  // Navigate with custom transition
  Future<dynamic>? toScreenWithTransition(Widget screen, Transition transition,
      {Duration? duration,
      Curve? curve,
      dynamic arguments,
      Bindings? binding}) {
    return Get.to(() => screen,
        transition: transition,
        duration: duration,
        curve: curve,
        arguments: arguments,
        binding: binding);
  }

  // Handle unknown routes
  Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return GetPageRoute(
      page: () => const UnknownRoutePage(),
      settings: settings,
    );
  }

  // Navigate and replace all previous routes with new route
  Future<dynamic>? offAllNamedScreen(String routeName,
      {dynamic arguments, dynamic parameters}) {
    return Get.offAllNamed(routeName,
        arguments: arguments, parameters: parameters);
  }

  // Navigate and replace the current route with new route
  Future<dynamic>? offNamedScreen(String routeName,
      {dynamic arguments, dynamic parameters}) {
    return Get.offNamed(routeName,
        arguments: arguments, parameters: parameters);
  }
}
