import 'package:get_storage/get_storage.dart';

class AuthSessionService {
  static const String tokenKey = 'api_auth_token';
  static const String tokenExpiryMinutesKey = 'api_auth_token_expiry_minutes';

  final GetStorage _storage = GetStorage();

  Future<void> saveToken({required String token, String? expiryMinutes}) async {
    await _storage.write(tokenKey, token);
    if (expiryMinutes != null) {
      await _storage.write(tokenExpiryMinutesKey, expiryMinutes);
    }
  }

  Future<String?> getToken() async {
    final token = _storage.read<String>(tokenKey);
    return token;
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
