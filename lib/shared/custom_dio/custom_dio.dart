import 'package:dio/dio.dart';
import 'package:mobile_challenge/shared/custom_dio/interceptors.dart';

import '../constants.dart';

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
