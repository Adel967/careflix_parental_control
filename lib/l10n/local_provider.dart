import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../core/constants.dart';
import '../core/shared_preferences/shared_preferences_instance.dart';
import '../core/shared_preferences/shared_preferences_key.dart';
import '../generated/l10n.dart';
import 'l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale _locale = const Locale("en");

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) {
      return;
    }
    _locale = locale;
  }

  void clearLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }

  Future<void> changeLanguageWithoutRestart(Locale type) async {
    final prefs = SharedPreferencesInstance.pref;
    if (_locale == type) {
      return;
    }
    if (type == const Locale(Constants.LANG_AR)) {
      _locale = const Locale(Constants.LANG_AR);
    } else {
      _locale = const Locale(Constants.LANG_EN);
    }
    await prefs.setString(
        SharedPreferencesKeys.LanguageCode, _locale.languageCode);
    setLocale(type);
    S.load(type);
    notifyListeners();
  }

  Future fetchLocale() async {
    final prefs = SharedPreferencesInstance.pref;

    final deviceSystemLanguage = Platform.localeName.split("_").first;

    if (prefs.getString(SharedPreferencesKeys.LanguageCode) == null) {
      changeLanguageWithoutRestart(Locale(deviceSystemLanguage));
      return Null;
    }
    _locale =
        Locale(prefs.getString(SharedPreferencesKeys.LanguageCode) ?? 'en');
    notifyListeners();
    return Null;
  }

  bool get isLTR => _locale.languageCode != 'ar';

  bool get isRTL => !isLTR;

  TextDirection get textDirection =>
      isLTR ? TextDirection.ltr : TextDirection.rtl;
}
