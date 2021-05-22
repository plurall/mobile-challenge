import 'package:dio/dio.dart';

import '../constants.dart';
import 'interceptors.dart';

class CustomDio {
  CustomDio();

  Dio getDio() {
    Dio dio = new Dio();
    dio.options.baseUrl = BASE_URL;
    dio.interceptors.add(CustomInterceptors());
    dio.options.connectTimeout = 5000;
    return dio;
  }
}
