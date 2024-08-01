import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello',
          'welcome': 'Welcome',
        },
        'vi_VN': {
          'hello': 'Xin chào',
          'welcome': 'Chào mừng',
        },
        'fr_FR': {
          'hello': 'Bonjour',
          'welcome': 'Bienvenue',
        },
      };
}
