import 'package:dio/dio.dart';


class BaseModel<T> {
  DioError exception;
  T data;
}
