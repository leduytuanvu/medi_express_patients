import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/enviroment.dart';
import 'package:medi_express_patients/core/config/log.dart';
import 'package:medi_express_patients/core/utils/translations/app_translations.dart';
import 'package:medi_express_patients/features/auth/presentation/binding/auth_binding.dart';
import 'package:medi_express_patients/features/auth/presentation/controller/auth_controller.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/intro/intro_page.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/login/login_page.dart';
import 'package:medi_express_patients/features/main/presentation/page/main_page.dart';
import 'package:medi_express_patients/routes/app_pages.dart';

class MediExpressPatientsApp extends StatelessWidget {
  final Environment environment;

  const MediExpressPatientsApp(this.environment, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: environment.appName,
      translations: AppTranslations(),
      locale: const Locale('vi', 'VN'),
      fallbackLocale: const Locale('vi', 'VN'),
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('vi', 'VN'),
        Locale('fr', 'FR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      getPages: AppPages.routes,
      initialBinding: AuthBinding(),
      home: AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      Log.info("Auth wrapper built");
      if (authController.baseState.accessToken.value.isEmpty) {
        Log.info(
            "loginnnnnn ${authController.baseState.accessToken.value.toString()}");
        return IntroPage();
      } else {
        Log.info(
            "mainnnnnnn ${authController.baseState.accessToken.value.toString()}");
        return MainPage();
      }
    });
  }
}
