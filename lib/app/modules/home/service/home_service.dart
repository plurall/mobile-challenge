import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/shared/exception/message_exception.dart';
import 'package:mobile_challenge/app/shared/model/user_details_model.dart';
import 'package:mobile_challenge/app/shared/model/user_model.dart';
import 'package:mobile_challenge/app/shared/util/dio_options.dart';

class HomeService {

  final _dio = Dio(dioOption);

  Future<List<Users>> getUsers() async {
    try {
      Response response = await _dio.get('users');
      return Users.fromJsonList(response.data);
    } on DioError catch (e) {
      if(e.error is SocketException) {
        throw MessageException('Erro de conexão, tente novamente mais tarde');
      }

      throw MessageException('Erro ao carregar dados');
    }
  }
  Future<UserSingle> getUserSingle(String path) async {
    try {
      Response response = await _dio.get('users/$path');
      print(response.data);
      return UserSingle.fromJson(response.data);
    } on DioError catch (e) {
      if(e.error is SocketException) {
        throw MessageException('Erro de conexão, tente novamente mais tarde');
      }

      throw MessageException('Erro ao carregar dados');
    }
  }
}