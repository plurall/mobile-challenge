import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mobile_challenge/app/modules/home/service/home_service.dart';
import 'package:mobile_challenge/app/shared/model/user_details_model.dart';
import 'package:mobile_challenge/app/shared/model/user_model.dart';

class HomeController {
  final HomeService homeService;

  HomeController({
    this.homeService
  });

  final usersController = StreamController<List<Users>>();
  Sink<List<Users>> get userIn => usersController.sink;
  Stream<List<Users>> get userOut => usersController.stream;

  final userSingleController = StreamController<UserSingle>();
  Sink<UserSingle> get userSingleIn => userSingleController.sink;
  Stream<UserSingle> get userSingleOut => userSingleController.stream;

  getUsers() async {
    List<Users> dados = await homeService.getUsers();
    userIn.add(dados);
  }
  getUsersSeach() async {
    List<Users> dados = await homeService.getUsers();
    return dados;
  }
  getUserSingel(String path) async {
    UserSingle dados = await homeService.getUserSingle(path);
    userSingleIn.add(dados);
  }


  dispose(){
    usersController.close();
  }
}