import 'package:model_house/model_house.dart';

class TranslationService {
  static TranslationService? _instance;
  static TranslationService get instance =>
      _instance ??= TranslationService._();
  TranslationService._();

  String? locale;

  Future setDeviceLocale() async {
    locale = await currentLocale;
    print('locale; $locale');
  }

  setLocale(String locale) {
    this.locale = locale;
  }

  /// Get the current locale
  ///
  /// If the locale is not set, return 'en' as locale.
  String getLocale() {
    return locale ?? 'en';
  }

  tr(
    String key, {
    Map<String, dynamic>? args,
    int? form,
  }) {
    /// Get the translation text map from the key.
    final textMap = translationTexts[key] ?? {};

    /// Get the text data from the locale. If the locale is not set, return 'en' as locale.
    /// If the text data is not found, return the key.
    final textData = textMap[locale] ?? textMap['en'] ?? key;

    String text;

    if (textData is String) {
      text = textData;
    } else if (textData is Map) {
      /// If the text data is a map, get the singular/plural text from the form.
      String selected;
      if (form == null || form == 0) {
        selected = 'zero';
      } else if (form == 1) {
        selected = 'one';
      } else {
        selected = 'many';
      }
      text = textData[selected] ?? key;
    } else {
      text = key;
    }

    if (args == null) {
      return text;
    }

    args.forEach((key, value) {
      text = text.replaceAll('{$key}', value.toString());
    });

    return text;
  }

  /// Set translation text
  ///
  /// It will replace the existing text if the key is already set.
  set({
    required String key,
    required String locale,
    required dynamic value,
  }) {
    if (translationTexts[key] == null) {
      translationTexts[key] = {};
    }
    translationTexts[key]![locale] = value;
  }
}
