import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telemedicina_app/core/_export.dart';
import 'package:telemedicina_app/core/constants/api_constants.dart';
import 'package:telemedicina_app/core/services/api_response_parser.dart';
import 'package:telemedicina_app/core/services/auth_session_service.dart';
import 'package:telemedicina_app/features/authentication/_export.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({required String username, required String password});
}

class HttpAuthRemoteDataSource implements AuthRemoteDataSource {
  HttpAuthRemoteDataSource({
    required this.client,
    required this.sessionService,
  });

  static final Uri _userLoginUri = Uri.parse(
    '${ApiConstants.baseUrl}${ApiConstants.userExternalLoginPath}',
  );
  static final Uri _patientCreateUri = Uri.parse(
    '${ApiConstants.baseUrl}${ApiConstants.patientCreatePath}',
  );

  final http.Client client;
  final AuthSessionService sessionService;

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final userResponse = await client.post(
      _userLoginUri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({'usuario': username, 'clave': password}),
    );
    HttpResponseLogger.logResponse(
      source: 'AuthRemoteDataSource',
      endpoint: ApiConstants.userExternalLoginPath,
      response: userResponse,
    );

    final userBody = ApiResponseParser.decodeBody(userResponse.body);
    if (userResponse.statusCode < 200 || userResponse.statusCode >= 300) {
      throw AppException(
        ApiResponseParser.extractErrorMessage(
          userBody,
          fallback: 'Credenciales invalidas.',
        ),
      );
    }

    final datos = userBody['datos'];
    if (datos is! Map<String, dynamic>) {
      throw AppException('Respuesta de usuario invalida.');
    }

    final patientResponse = await client.post(
      _patientCreateUri,
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': (datos['FullName'] ?? '').toString(),
        'userCode': (datos['UserCode'] ?? '').toString(),
        'email': (datos['Email'] ?? '').toString(),
        'phone': (datos['Phone'] ?? '').toString(),
        'gender': (datos['Gender'] ?? '').toString(),
        'birthdate': (datos['Birthdate'] ?? '').toString(),
      }),
    );
    HttpResponseLogger.logResponse(
      source: 'AuthRemoteDataSource',
      endpoint: ApiConstants.patientCreatePath,
      response: patientResponse,
      maskedFields: const {'token'},
    );

    final patientBody = ApiResponseParser.decodeBody(patientResponse.body);
    if (patientResponse.statusCode < 200 || patientResponse.statusCode >= 300) {
      throw AppException(
        ApiResponseParser.extractErrorMessage(
          patientBody,
          fallback: 'No fue posible registrar el paciente.',
        ),
      );
    }

    final token = (patientBody['token'] ?? '').toString();
    if (token.isEmpty) {
      throw AppException('No se recibio token de autenticacion.');
    }

    await sessionService.saveToken(
      token: token,
      expiryMinutes: patientBody['expira']?.toString(),
    );

    return UserModel.fromLoginJson(datos);
  }
}
