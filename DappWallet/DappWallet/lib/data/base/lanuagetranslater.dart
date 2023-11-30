import '../../utils/export.dart';

class TranslationService extends Translations {
  static final locale = Locale('en', 'US');

  static final fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
        "en": enUS,
        "bn": bn,
        "pu": pu,
        "hi": hi,
      };
}
