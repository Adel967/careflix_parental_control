import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesInstance {
  static late SharedPreferences pref;

  Future<void> init() async {
    pref = await SharedPreferences.getInstance();
  }
}
