import 'package:flutter/foundation.dart';
import 'package:mobile_challenge/app/models/user_model.dart';
import 'package:mobile_challenge/app/models/users_model.dart';
import 'package:mobile_challenge/app/repositories/apigithub_repository_interface.dart';

class ApiGithubViewModel {
  final IApiGithub repository;

  final userModel = ValueNotifier<UserModel>(null);
  final usersModel = ValueNotifier<List<UsersModel>>(null);

  ApiGithubViewModel(this.repository);

  findOne(String login) async {
    try {
      userModel.value = await repository.findOne(login);
    } catch (e) {
      print(e);
    }
  }

  findAll(String login) async {
    try {
      usersModel.value = await repository.findAll(login);
    } catch (e) {
      print(e);
    }
  }
}
