import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'home': 'Home',
        },
        'vi_VN': {
          'home': 'Trang chủ',
        },
        'fr_FR': {
          'hello': 'Bonjour',
        },
      };
}
