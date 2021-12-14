import 'package:mobile_challenge/app/models/user_model.dart';
import 'package:mobile_challenge/app/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_challenge/app/viewmodels/apigithub_viewmodel.dart';

class UsersController {
  final ApiGithubViewModel githubViewModel;

  UsersController(this.githubViewModel);

  ValueNotifier<List<UsersModel>> get findAll => githubViewModel.usersModel;

  getFindAll(String login) {
    githubViewModel.findAll(login);
  }
}
