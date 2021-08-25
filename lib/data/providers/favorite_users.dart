import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/database/database.dart';
import 'package:mobile_challenge/data/model/user.dart';

class FavoriteUsersProvider with ChangeNotifier {
  List<User> _favoriteUsers = [];
  List<User> get items => [..._favoriteUsers];

  toogleFavorite(User user) {
    final isFavoriteUser = this.isFavoriteUser(_favoriteUsers, user);
    if (isFavoriteUser) {
      DBUtil.delete('favorites', user.id);
      _favoriteUsers.remove(user);
    } else {
      DBUtil.insert('favorites', user.toMap());
      _favoriteUsers.add(user);
    }
    notifyListeners();
  }

  bool isFavoriteUser(List<User> favoriteUsers, User user) =>
      favoriteUsers.where((current) => current.id == user.id).isNotEmpty;

  Future<void> loadData() async {
    final dataList = await DBUtil.getData('favorites');
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
