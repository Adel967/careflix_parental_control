import 'dart:ui';
import '../core/constants.dart';

class L10n {
  static final all = [
    const Locale(Constants.LANG_AR),
    const Locale(Constants.LANG_EN),
  ];

  static String getFlag(String code) {
    switch (code) {
      case Constants.LANG_AR:
        return 'eg';
      case Constants.LANG_EN:
      default:
        return 'us';
    }
  }

  static String getLanguageName(String code) {
    switch (code) {
      case Constants.LANG_AR:
        return 'العربية';
      case Constants.LANG_EN:
      default:
        return 'English';
    }
  }
}
