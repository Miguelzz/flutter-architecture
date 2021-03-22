import 'package:get/get_navigation/src/root/internacionalization.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en': {
          'title': 'Hello World %s',
        },
        'pt': {
          'title': 'Salut monde %s',
        },
        'es': {
          'title': 'Hola Mundo',
        },
      };
}
