import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/datasources/database_interface.dart';
import 'package:mobile_challenge/data/models/user.dart';

class FavoriteUsersProvider with ChangeNotifier {
  final DatabaseInterface database;

  List<User> _favoriteUsers = [];
  List<User> get items => [..._favoriteUsers];

  FavoriteUsersProvider(this.database);

  toogleFavorite(User user) {
    final isFavorite = this.isFavorite(user);
    if (isFavorite) {
      this.removeUser(user);
    } else {
      this.addUser(user);
    }
    notifyListeners();
  }

  addUser(User user) {
    database.insert('favorites', user.toMap());
    _favoriteUsers.add(user);
  }

  removeUser(User user) {
    database.delete('favorites', user.id);
    _favoriteUsers.removeWhere((current) => current.id == user.id);
  }

  bool isFavorite(User user) =>
      this._favoriteUsers.where((current) => current.id == user.id).isNotEmpty;

  Future<void> loadData() async {
    final dataList = await database.getData('favorites');
    _favoriteUsers = dataList
        .map((item) => User(
              id: item['id'],
              name: item['name'],
              login: item['login'],
              bio: item['bio'],
              avatar: item['avatar'],
              email: item['email'],
              location: item['location'],
            ))
        .toList();
    notifyListeners();
  }
}
