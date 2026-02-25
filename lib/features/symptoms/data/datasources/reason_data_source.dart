import 'package:http/http.dart' as http;
import 'package:telemedicina_app/core/_export.dart';
import 'package:telemedicina_app/core/constants/api_constants.dart';
import 'package:telemedicina_app/core/services/api_response_parser.dart';
import 'package:telemedicina_app/core/services/auth_session_service.dart';
import 'package:telemedicina_app/core/utils/http_response_logger.dart';
import 'package:telemedicina_app/features/symptoms/_export.dart';

abstract class ReasonDataSource {
  Future<List<ReasonItem>> getReasons();

  Future<void> saveSymptoms({
    required List<String> selectedReasons,
    String? otherSymptoms,
  });
}

class HttpReasonDataSource implements ReasonDataSource {
  HttpReasonDataSource({required this.client, required this.sessionService});

  static final Uri _reasonsUri = Uri.parse(
    '${ApiConstants.baseUrl}${ApiConstants.reasonGetAllPath}',
  );

  final http.Client client;
  final AuthSessionService sessionService;

  @override
  Future<List<ReasonItem>> getReasons() async {
    final response = await client.get(
      _reasonsUri,
      headers: await sessionService.getAuthHeaders(),
    );
    HttpResponseLogger.logResponse(
      source: 'ReasonDataSource',
      endpoint: ApiConstants.reasonGetAllPath,
      response: response,
    );

    final body = ApiResponseParser.decodeBody(response.body);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AppException(
        ApiResponseParser.extractErrorMessage(
          body,
          fallback: 'No fue posible obtener los motivos de consulta.',
        ),
      );
    }

    final datos = body['datos'];
    if (datos is! Map<String, dynamic>) {
      throw AppException('Formato de respuesta invalido.');
    }

    final reasonList = datos['Reason'];
    if (reasonList is! List) {
      throw AppException('Lista de motivos invalida.');
    }

    return reasonList
        .whereType<Map<String, dynamic>>()
        .map(ReasonItemModel.fromJson)
        .where((reason) => reason.name.trim().isNotEmpty)
        .toList();
  }

  @override
  Future<void> saveSymptoms({
    required List<String> selectedReasons,
    String? otherSymptoms,
  }) async {
    if (selectedReasons.isEmpty) {
      throw AppException('Selecciona al menos un sintoma.');
    }

    await Future<void>.delayed(const Duration(milliseconds: 650));
  }
}
