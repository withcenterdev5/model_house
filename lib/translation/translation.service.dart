import 'package:model_house/model_house.dart';

/// Translation Service
///
/// This service provides translation text.
class TranslationService {
  static TranslationService? _instance;
  static TranslationService get instance =>
      _instance ??= TranslationService._();
  TranslationService._();

  String? locale;
  String defaultLocale = 'en';
  String fallbackLocale = 'en';
  bool useKeyAsDefaultText = false;

  /// initialize the translation service
  ///
  /// [deviceLocale] If true, set the device locale as the default locale.
  ///
  /// [defaultLocale] The default locale. If the locale is not set, use this locale.
  ///
  /// [fallbackLocale] The fallback locale. If the text is not found in the locale, use this locale.
  ///
  /// [useKeyAsDefaultText] If true, use the key as the default text. If it's
  /// false, ".t" will be added to the key. For example, if the code is
  /// ```dart
  /// 'hello'.t
  /// ```
  /// and if the key 'hello' is not found, the key will return 'hello' as text
  /// if [useKeyAsDefaultText] is true. If it's false, it will return
  /// 'hello.t' as text.
  ///
  init({
    bool deviceLocale = true,
    String defaultLocale = 'en',
    String fallbackLocale = 'en',
    bool useKeyAsDefaultText = false,
  }) async {
    this.defaultLocale = defaultLocale;
    this.fallbackLocale = fallbackLocale;
    this.useKeyAsDefaultText = useKeyAsDefaultText;
    if (deviceLocale) {
      await TranslationService.instance.setDeviceLocale();
    }

    dog('current locale; $locale, default locale: $defaultLocale, fallback locale: $fallbackLocale');
  }

  Future setDeviceLocale() async {
    locale = await currentLocale;
  }

  setLocale(String locale) {
    this.locale = locale;
  }

  /// Get the current locale
  ///
  /// If the locale is not set, return 'en' as locale.
  String getLocale() {
    return locale ?? defaultLocale;
  }

  tr(
    String key, {
    Map<String, dynamic>? args,
    int? form,
  }) {
    /// Get the translation text map from the key.
    final textMap = translationTexts[key] ?? {};

    String useKey = (useKeyAsDefaultText ? key : '$key.t');

    /// Get the text data from the locale. If the locale is not set, return 'en' as locale.
    /// If the text data is not found, return the key.
    final textData = textMap[locale] ?? textMap[fallbackLocale] ?? useKey;

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
      text = textData[selected] ?? useKey;
    } else {
      text = useKey;
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
