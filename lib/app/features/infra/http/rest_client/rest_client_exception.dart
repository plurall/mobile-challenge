import 'rest_client_response.dart';

class RestClientException implements Exception {
  final String? message;
  final int? statusCode;
  final dynamic error;
  final RestClientResponse? response;

  RestClientException(
    this.message,
    this.statusCode,
    this.error,
    this.response,
  );

  @override
  String toString() {
    return 'RestClientException(message: $message, statusCode: $statusCode, error: $error, response: $response)';
  }
}
