import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mobile_challenge/app/core/helpers/environments.dart';
import 'package:mobile_challenge/app/features/infra/http/rest_client/rest_client.dart';
import 'package:mobile_challenge/app/features/infra/http/rest_client/rest_client_exception.dart';
import 'package:mobile_challenge/app/features/infra/http/rest_client/rest_client_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../core/helpers/environments.dart';

@Singleton(as: RestClient)
class DioRestClient implements RestClient {
  late Dio _dio;

  BaseOptions _defaultBaseOptions = BaseOptions(
    baseUrl: Environments.param('base_url') ?? '',
    connectTimeout:
        int.parse(Environments.param('dio_connect_timeout') ?? '60000'),
    receiveTimeout:
        int.parse(Environments.param('dio_receive_timeout') ?? '60000'),
  );

  DioRestClient() {
    _dio = Dio(_defaultBaseOptions);
    _dio.interceptors.addAll([
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      )
    ]);
  }

  @override
  Future<RestClientResponse<T>> delete<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        e.response?.statusMessage,
        e.response?.statusCode,
        e.error,
        _dioErrorResponseConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        e.response?.statusMessage,
        e.response?.statusCode,
        e.error,
        _dioErrorResponseConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> patch<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        e.response?.statusMessage,
        e.response?.statusCode,
        e.error,
        _dioErrorResponseConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> post<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        e.response?.statusMessage,
        e.response?.statusCode,
        e.error,
        _dioErrorResponseConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> put<T>(
    String path, {
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        e.response?.statusMessage,
        e.response?.statusCode,
        e.error,
        _dioErrorResponseConverter(e.response),
      );
    }
  }

  @override
  Future<RestClientResponse<T>> request<T>(
    String path, {
    required String method,
    data,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.request(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers, method: method),
      );
      return _dioResponseConverter<T>(response);
    } on DioError catch (e) {
      throw RestClientException(
        e.response?.statusMessage,
        e.response?.statusCode,
        e.error,
        _dioErrorResponseConverter(e.response),
      );
    }
  }

  RestClientResponse<T> _dioResponseConverter<T>(Response response) {
    return RestClientResponse<T>(
      data: response.data,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
    );
  }

  RestClientResponse? _dioErrorResponseConverter(Response? response) {
    return RestClientResponse(
      data: response?.data,
      statusCode: response?.statusCode,
      statusMessage: response?.statusMessage,
    );
  }
}
