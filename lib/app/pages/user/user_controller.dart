import 'package:mobile_challenge/app/models/favorites_model.dart';
import 'package:mobile_challenge/app/models/user_model.dart';
import 'package:mobile_challenge/app/models/users_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobile_challenge/app/services/favorites_database_service.dart';
import 'package:mobile_challenge/app/viewmodels/apigithub_viewmodel.dart';
import 'package:mobile_challenge/app/viewmodels/favorites_viewmodel.dart';

class UserController {
  final ApiGithubViewModel githubViewModel;
  final FavoritesViewModel favoritesViewModel;

  UserController(this.githubViewModel, this.favoritesViewModel);

  ValueNotifier<UserModel> get findOne => githubViewModel.userModel;

  getFindOne(String login) {
    githubViewModel.findOne(login);
  }

  void addFavoriteItem(
      String login, String email, String location, String bio, int id) async {
    // bool isFavorite = FavoriteDatabaseService.instance.findOne(login) != null;

    // if (isFavorite) {
    //   await favoritesViewModel.delete(id);
    // } else {
    //   await favoritesViewModel.create(login, email, location, bio, id);
    // }
    await favoritesViewModel.create(login, email, location, bio, id);
  }
}
