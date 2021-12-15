import 'package:flutter/widgets.dart';
import 'package:mobile_challenge/app/interfaces/client_http_interface.dart';
import 'package:mobile_challenge/app/interfaces/favorites_database_interface.dart';
import 'package:mobile_challenge/app/models/user_model.dart';
import 'package:mobile_challenge/app/models/users_model.dart';
import 'package:mobile_challenge/app/repositories/apigithub_repository_interface.dart';

class FavoritesRepository implements IFavoritesDatabase {
  final IClientHttp client;

  FavoritesRepository(this.client);

  @override
  Future delete(int id) async {
    return id;
  }

  Future<UserModel> create(UserModel model) async {
    return model;
  }
}
