import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/di.dart';
import 'package:medi_express_patients/core/config/enviroment.dart';
import 'package:medi_express_patients/core/service/error_handling_service.dart';
import 'package:medi_express_patients/medi_express_patients_app.dart';
import 'core/config/log.dart';
import 'core/exception/failure.dart';

void main() {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Optional: Set the debug flag for catching zone errors during development
    BindingBase.debugZoneErrorsAreFatal = true;
    // Initialize logging
    Log.initialize();
    // Initialize dependencies
    await initDI('production');
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
    // Run the app
    runApp(MediExpressPatientsApp(environment));
  }, (error, stackTrace) {
    if (Get.isRegistered<ErrorHandlingService>()) {
      Get.find<ErrorHandlingService>().handleException(
        UnknownFailure('Throw error in main', error.toString()),
      );
    }
  });
}
