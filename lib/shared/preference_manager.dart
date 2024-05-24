import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager {
  static const String _tokenKey = "token";

  static Future<void> saveToken(String token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString(_tokenKey);
  }

  static Future<void> clearToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove(_tokenKey);
  }
}
