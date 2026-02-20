import 'dart:convert';

class ApiResponseParser {
  ApiResponseParser._();

  static Map<String, dynamic> decodeBody(String body) {
    if (body.isEmpty) {
      return <String, dynamic>{};
    }

    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    return <String, dynamic>{};
  }

  static String extractErrorMessage(
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
