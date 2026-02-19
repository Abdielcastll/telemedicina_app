import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telemedicina_app/core/constants/api_constants.dart';
import 'package:telemedicina_app/core/services/auth_session_service.dart';

import '../models/user_model.dart';

class AuthException implements Exception {
  AuthException(this.message);

  final String message;
}

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String username, required String password});
}

class HttpAuthRemoteDataSource implements AuthRemoteDataSource {
  HttpAuthRemoteDataSource({
    required this.client,
    required this.sessionService,
  });

  static final Uri _securityLoginUri = Uri.parse(
    '${ApiConstants.baseUrl}${ApiConstants.securityLoginPath}',
  );
  static final Uri _userLoginUri = Uri.parse(
    '${ApiConstants.baseUrl}${ApiConstants.userExternalLoginPath}',
  );

  final http.Client client;
  final AuthSessionService sessionService;

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final securityResponse = await client.post(
      _securityLoginUri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({
        'usuario': ApiConstants.securityApiUser,
        'clave': ApiConstants.securityApiPassword,
      }),
    );

    final securityBody = _decodeBody(securityResponse.body);
    if (securityResponse.statusCode < 200 ||
        securityResponse.statusCode >= 300) {
      throw AuthException(
        _extractErrorMessage(
          securityBody,
          fallback: 'No fue posible autenticar el servicio.',
        ),
      );
    }

    final token = (securityBody['token'] ?? '').toString();
    final expira = securityBody['expira']?.toString();
    if (token.isEmpty) {
      throw AuthException('No se recibio token de autenticacion.');
    }

    await sessionService.saveToken(token: token, expiryMinutes: expira);

    final userResponse = await client.post(
      _userLoginUri,
      headers: await sessionService.getAuthHeaders(),
      body: jsonEncode({'usuario': username, 'clave': password}),
    );

    final userBody = _decodeBody(userResponse.body);
    if (userResponse.statusCode < 200 || userResponse.statusCode >= 300) {
      throw AuthException(
        _extractErrorMessage(userBody, fallback: 'Credenciales invalidas.'),
      );
    }

    final datos = userBody['datos'];
    if (datos is! Map<String, dynamic>) {
      throw AuthException('Respuesta de usuario invalida.');
    }

    return UserModel.fromLoginJson(datos);
  }

  Map<String, dynamic> _decodeBody(String body) {
    if (body.isEmpty) {
      return <String, dynamic>{};
    }

    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    return <String, dynamic>{};
  }

  String _extractErrorMessage(
    Map<String, dynamic> body, {
    required String fallback,
  }) {
    final message = body['mensaje']?.toString();
    if (message != null &&
        message.trim().isNotEmpty &&
        message.trim() != 'null') {
      return message;
    }
    return fallback;
  }
}
