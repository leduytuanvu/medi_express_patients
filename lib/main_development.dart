import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/di.dart';
import 'package:medi_express_patients/core/config/enviroment.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/exception/failure.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/core/service/notification_service.dart';
import 'package:medi_express_patients/medi_express_patients_app.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    NotificationService().initNotification();
    // await Firebase.initializeApp();

    BindingBase.debugZoneErrorsAreFatal = true;

    // Initialize logging
    Log.initialize();

    // Initialize dependencies
    await initDI('development');

    // Set global error handling
    FlutterError.onError = (FlutterErrorDetails details) async {
      FlutterError.presentError(details);
      if (Get.isRegistered<ErrorHandlingService>()) {
        Get.find<ErrorHandlingService>().handleException(
          UnknownFailure('Throw error in main', details.exceptionAsString()),
        );
      }
    };

    // Load environment configuration
    final environment = Get.find<Environment>();

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    Get.testMode = true;

    // Run the app
    runApp(
      ScreenUtilInit(
        enableScaleWH: () => false,
        enableScaleText: () => false,
        designSize: const Size(375, 667),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MediExpressPatientsApp(environment);
        },
      ),
    );
    FlutterNativeSplash.remove();
  }, (error, stackTrace) {
    if (Get.isRegistered<ErrorHandlingService>()) {
      Get.find<ErrorHandlingService>().handleException(
        UnknownFailure('Throw error in main', error.toString()),
      );
    }
  });
}
