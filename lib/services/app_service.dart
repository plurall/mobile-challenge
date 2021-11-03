import 'dart:convert';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/models/user_model.dart';
import 'package:mobile_challenge/services/shared_preferences_service.dart';

class AppService {
  bool isLogged = false;
  List<UserModel> favoriteUsers = [];

  AppService() {
    loadFavoriteUsers();
  }

  void loadFavoriteUsers() async {
    var storage = Modular.get<SharedPreferencesService>();

    String data = await storage.get('fav_users') ?? '';
    if (data.isNotEmpty) {
      final List<dynamic> json = jsonDecode(data);
      favoriteUsers = json.map((e) => UserModel.fromJson(e)).toList();
    }
  }

  UserModel getUserFromFavorite(String username) {
    return favoriteUsers.singleWhere((u) => u.login == username);
  }

  bool hasUserFavorite(UserModel user) {
    bool result = false;
    favoriteUsers.forEach((u) {
      if (u.login == user.login) {
        result = true;
      }
    });
    return result;
  }

  void saveToStorage() async {
    var storage = Modular.get<SharedPreferencesService>();
    await storage.put(
        'fav_users', jsonEncode(favoriteUsers.map((u) => u.toJson()).toList()));
  }
}
