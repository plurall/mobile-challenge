import 'package:dio/native_imp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'custom_interceptor.dart';

class CustomDio extends DioForNative {
  CustomDio();

  Future<CustomDio> init() async {
    final dio = CustomDio();
    final url = env['API_URL'];

    dio
      ..options.baseUrl = url
      ..options.connectTimeout = 60000
      ..options.receiveTimeout = 60000
      ..options.sendTimeout = 60000
      ..interceptors.add(CustomInterceptor());

    return dio;
  }
}
