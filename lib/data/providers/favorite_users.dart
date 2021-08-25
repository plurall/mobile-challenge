import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/database/database.dart';
import 'package:mobile_challenge/data/model/user.dart';
import 'package:mobile_challenge/utils/utils.dart';

class FavoriteUsersProvider with ChangeNotifier {
  List<User> _favoriteUsers = [];
  List<User> get items => [..._favoriteUsers];

  toogleFavorite(User user) {
    final isFavoriteUser = Utils.isFavoriteUser(_favoriteUsers, user);
    if (isFavoriteUser) {
      DBUtil.delete('favorites', user.id);
      _favoriteUsers.remove(user);
    } else {
      DBUtil.insert('favorites', user.toMap());
      _favoriteUsers.add(user);
    }
    notifyListeners();
  }

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
