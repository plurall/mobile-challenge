abstract class IHttpClient {
  Future<HttpResponse> get(String url);
}

class HttpResponse {
  final dynamic data;
  final int statusCode;

  HttpResponse({
    this.data,
    required this.statusCode,
  });
}
