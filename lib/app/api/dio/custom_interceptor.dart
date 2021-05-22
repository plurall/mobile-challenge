import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/helpers/constants.dart';
import 'package:mobile_challenge/config/environment.dart';
import 'package:mobile_challenge/config/main_common.dart';

class CustomInterceptor extends InterceptorsWrapper {
  static const optionMethod = 'GET';
  static const logDieErrorTitle = 'DioError';
  static const logStatusTitle = 'Status';
  static const logResponseTitle = 'Response';
  static const logRequestTitle = 'Request';
  static const logBodyTitle = 'Body';
  static const logHeadersTitle = 'Headers';
  static const logFormDataTitle = 'Form data';
  static const jsonXToken = 'x-token';

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    _onDioRequestHeader(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    _onDioResponse(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioError err,
    ErrorInterceptorHandler handler,
  ) {
    _onDioError(err);
    super.onError(err, handler);
  }

  void _onDioRequestHeader(RequestOptions options) {
    final uri = options?.uri;
    final method = options?.method;
    logger.d('$logRequestTitle ║ $method\n$uri');

    if (options.method != optionMethod) {
      final data = options.data;
      if (data != null) {
        if (data is Map) {
          _printMapAsTable(data, header: logBodyTitle);
        } else if (data is FormData) {
          final formDataMap = {}
            ..addEntries(data.fields)
            ..addEntries(data.files);
          _printMapAsTable(
            formDataMap,
            header: '$logFormDataTitle | ${data.boundary}',
          );
        } else {
          logger.d(data.toString());
        }
      }
    }
  }

  void _onDioResponse(Response response) {
    if (buildEnv.environment == Environment.development) {
      logger.d('$logBodyTitle\n${response.data}');
    }
  }

  void _onDioError(DioError err) {
    if (err.type == DioErrorType.response) {
      final uri = err.response.realUri;
      logger.e(
          '$logDieErrorTitle ║ $logStatusTitle: ${err.response.statusCode} ${err.response.statusMessage}\n$uri');
      if (err.response != null && err.response.data != null) {
        logger.e('${err.type}\n${err.response.data}');
      }
    } else {
      logger.e('$logDieErrorTitle ║ ${err.type}\n${err.message}');
    }
  }

  void _printMapAsTable(Map map, {String header}) {
    if (map == null || map.isEmpty) return;
    String text = '';
    map.forEach((key, value) => text += '{$key: $value}\n');
    logger.d('$header\n$text');
  }
}
