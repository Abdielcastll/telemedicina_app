import 'package:shared_preferences/shared_preferences.dart';

class AuthSessionService {
  static const String tokenKey = 'api_auth_token';
  static const String tokenExpiryMinutesKey = 'api_auth_token_expiry_minutes';

  Future<void> saveToken({required String token, String? expiryMinutes}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
    if (expiryMinutes != null) {
      await prefs.setString(tokenExpiryMinutesKey, expiryMinutes);
    }
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<Map<String, String>> getAuthHeaders() async {
    final token = await getToken();
    final headers = <String, String>{'Content-Type': 'application/json'};

    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    return headers;
  }
}
