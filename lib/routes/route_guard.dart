import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/features/account/presentation/controller/account_controller.dart';
import 'package:medi_express_patients/features/auth/data/datasources/local/auth_local_datasource.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';

class RouteGuard extends GetMiddleware {
  RouteGuard();

  @override
  RouteSettings? redirect(String? route) {
    final isAuthenticated = _checkAuthentication();
    if (!isAuthenticated) {
      return const RouteSettings(name: '/login');
    }
    return null;
  }

  bool _checkAuthentication() {
    final AuthController authController = Get.find<AuthController>();
    if(authController.baseState.auth.value.accessToken.isEmpty) {
      Log.info("route empty");
      return false;
    } else {
      Log.info("route not empty");
      return true;
    }
  }
}
