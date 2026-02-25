import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:telemedicina_app/core/services/api_response_parser.dart';

class HttpResponseLogger {
  HttpResponseLogger._();

  static bool get _isEnabled {
    final rawValue = dotenv.env['ENABLE_API_LOGS'];
    if (rawValue == null || rawValue.trim().isEmpty) {
      return kDebugMode;
    }

    final normalized = rawValue.trim().toLowerCase();
    return normalized == 'true' ||
        normalized == '1' ||
        normalized == 'yes' ||
        normalized == 'on';
  }

  static void logResponse({
    required String source,
    required String endpoint,
    required http.Response response,
    Set<String> maskedFields = const <String>{},
  }) {
    if (!_isEnabled) {
      return;
    }

    final decodedBody = ApiResponseParser.decodeBody(response.body);

    if (decodedBody.isNotEmpty) {
      final sanitizedBody = _maskFields(decodedBody, maskedFields);
      debugPrint(
        '[$source] endpoint=$endpoint status=${response.statusCode} response=${jsonEncode(sanitizedBody)}',
      );
      return;
    }

    debugPrint(
      '[$source] endpoint=$endpoint status=${response.statusCode} response=${response.body}',
    );
  }

  static Map<String, dynamic> _maskFields(
    Map<String, dynamic> body,
    Set<String> maskedFields,
  ) {
    if (maskedFields.isEmpty) {
      return Map<String, dynamic>.from(body);
    }

    final sanitized = Map<String, dynamic>.from(body);
    for (final field in maskedFields) {
      if (sanitized.containsKey(field)) {
        sanitized[field] = '***';
      }
    }

    return sanitized;
  }
}
