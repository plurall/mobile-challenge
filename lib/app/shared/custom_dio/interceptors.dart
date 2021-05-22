import 'package:dio/dio.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    print("REQUEST ${options.method} => ${options.path}");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    print("REQUEST ${response.statusCode} => ${response.requestOptions.path}");
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    print("REQUEST ${err.response!.statusCode} => ${err.requestOptions.path}");
  }
}
