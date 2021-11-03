import 'package:dio/dio.dart';
import 'package:mobile_challenge/core/constants.dart';
import 'package:mobile_challenge/interfaces/http_client_interface.dart';

class DioService implements IHttpClient {
  Dio _dio;

  DioService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      contentType: Headers.jsonContentType,
    ));
    _setupAccessToken();
  }

  void _setupAccessToken() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      options.headers['Authorization'] = 'Bearer $apiToken';
      handler.next(options);
    }));
  }

  @override
  Future get(String url) {
    return _dio.get(url);
  }

  @override
  Future post(String url, {data}) {
    return _dio.post(url, data: data);
  }

  @override
  Future put(String url, {data}) {
    return _dio.put(url, data: data);
  }

  @override
  Future delete(String url) {
    return _dio.delete(url);
  }
}
