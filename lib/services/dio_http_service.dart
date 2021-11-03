import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/core/constants.dart';
import 'package:mobile_challenge/interfaces/http_client_interface.dart';

import 'app_service.dart';

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
      final appService = Modular.get<AppService>();

      bool isLogged = appService.isLogged;

      if (isLogged) {
        String token = appService.token ?? '';
        options.headers['Authorization'] = 'Bearer $token';
      }

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
