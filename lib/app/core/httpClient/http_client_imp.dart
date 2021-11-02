import 'package:http/http.dart' as http;
import 'package:mobile_challenge/app/core/httpClient/http_client.dart';

class HttpClient implements IHttpClient {
  final client = http.Client();

  @override
  Future<HttpResponse> get(String url) async {
    final response = await client.get(
      Uri.parse(url),
    );
    return HttpResponse(
      data: response.body,
      statusCode: response.statusCode,
    );
  }
}
