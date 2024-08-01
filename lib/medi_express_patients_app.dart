import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:medi_express_patients/core/config/enviroment.dart';
import 'package:medi_express_patients/core/utils/translations/app_translations.dart';
import 'package:medi_express_patients/features/auth/presentation/pages/login/login_page.dart';
import 'package:medi_express_patients/routes/app_pages.dart';
import 'package:medi_express_patients/routes/app_routes.dart';

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
      initialRoute: AppRoutes.login,
      getPages: AppPages.routes,

      // builder: (context, child) {
      //   return GlobalOverlayWidget(
      //     child: child!,
      //   );
      // },
      // home: const GlobalOverlayWidget(
      //   child: AuthWrapper(),
      // ),
      home: LoginPage(),
    );
  }
}
