import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://telemedicinaapi.indautosoft.dev';

  static const String securityLoginPath =
      '/Security/login/api'; // Autentica y genera un JWT
  static const String userExternalLoginPath =
      '/UserExternal/login/app'; // Autentica en la app
  static const String reasonGetAllPath =
      '/Reason/reason/getAll'; // Obtener todos los motivos de consultas
  static const String settingExceptionByTypePath =
      '/Setting/exceptions/getTypeSettingException';

  static String get securityApiUser => _requiredEnv('SECURITY_API_USER');
  static String get securityApiPassword =>
      _requiredEnv('SECURITY_API_PASSWORD');

  static String _requiredEnv(String key) {
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError('Missing required environment variable: $key');
    }
    return value;
  }
}
