import 'package:shared_preferences/shared_preferences.dart';

class ApiConfig {
  static const _key = 'apiBaseUrl';
  static String _defaultUrl = 'http://192.168.198.240/RestEase';

  static Future<String> getApiBaseUrl() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_key) ?? _defaultUrl;
  }

  static Future<void> setApiBaseUrl(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, url);
  }
}

// Make sure all API calls use ApiConfig.getApiBaseUrl() dynamically
