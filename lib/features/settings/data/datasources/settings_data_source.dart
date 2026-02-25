import 'package:http/http.dart' as http;
import 'package:telemedicina_app/core/_export.dart';
import 'package:telemedicina_app/core/constants/api_constants.dart';
import 'package:telemedicina_app/core/services/api_response_parser.dart';
import 'package:telemedicina_app/core/services/auth_session_service.dart';
import 'package:telemedicina_app/core/utils/http_response_logger.dart';
import 'package:telemedicina_app/features/settings/data/models/setting_exception_model.dart';
import 'package:telemedicina_app/features/settings/domain/entities/setting_exception.dart';

abstract class SettingsDataSource {
  Future<List<SettingException>> getTypeSettingExceptionByUserId(int userId);
}

class HttpSettingsDataSource implements SettingsDataSource {
  HttpSettingsDataSource({required this.client, required this.sessionService});

  final http.Client client;
  final AuthSessionService sessionService;

  @override
  Future<List<SettingException>> getTypeSettingExceptionByUserId(
    int userId,
  ) async {
    final uri = Uri.parse(
      '${ApiConstants.baseUrl}${ApiConstants.settingExceptionByTypePath}/$userId',
    );

    final response = await client.get(
      uri,
      headers: await sessionService.getAuthHeaders(),
    );
    HttpResponseLogger.logResponse(
      source: 'SettingsDataSource',
      endpoint: '${ApiConstants.settingExceptionByTypePath}/$userId',
      response: response,
    );

    final body = ApiResponseParser.decodeBody(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AppException(
        ApiResponseParser.extractErrorMessage(
          body,
          fallback: 'No fue posible obtener la configuracion.',
        ),
      );
    }

    final datos = body['datos'];
    if (datos is! Map<String, dynamic>) {
      throw AppException('Formato de respuesta de configuracion invalido.');
    }

    final settingsExceptions = datos['SettingsExceptions'];
    if (settingsExceptions is! List) {
      throw AppException('Lista de configuracion invalida.');
    }

    return settingsExceptions
        .whereType<Map<String, dynamic>>()
        .map(SettingExceptionModel.fromJson)
        .where((setting) => setting.name.trim().isNotEmpty)
        .toList();
  }
}
