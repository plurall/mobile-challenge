import 'package:flutter/widgets.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile_challenge/app/data/models/search_model.dart';
import 'package:mobile_challenge/app/data/models/user_model.dart';
import 'package:mobile_challenge/app/data/provider/provider.dart';

class Repository {
  Repository({@required this.provider}) : assert(provider != null);
  final Provider provider;

  static final _usersStorage = GetStorage('users');

  static Future initStorage() async {
    await _usersStorage.initStorage;
  }

  List<UserModel> getAllFavorite() {
    final res = _usersStorage.getValues();
    List<UserModel> list = [];
    for (var element in res) {
      list.add(UserModel.fromJson(element));
    }
    if (list.isNotEmpty) {
      return list;
    }
    return null;
  }

  UserModel getFavorite({@required String username}) {
    final res = _usersStorage.read(username);
    if (res != null) {
      return UserModel.fromJson(res);
    }
    return null;
  }

  void addFavorite({@required UserModel user}) =>
      _usersStorage.write(user.login, user.toJson());

  void removeFavorite({@required String username}) =>
      _usersStorage.remove(username);

  Future<List<SearchModel>> searchUsers({@required String name}) =>
      provider.searchUsers(name: name);

  Future<UserModel> getUser({@required String name}) =>
      provider.getUser(name: name);
}
