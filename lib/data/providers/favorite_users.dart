import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user.dart';
import 'package:mobile_challenge/utils/utils.dart';

class FavoriteUsersProvider with ChangeNotifier {
  List<User> _favoriteUsers = [];
  List<User> get items => _favoriteUsers;

  toogleFavorite(User user) {
    final isFavoriteUser = Utils.isFavoriteUser(_favoriteUsers, user);
    if (isFavoriteUser)
      _favoriteUsers.remove(user);
    else
      _favoriteUsers.add(user);
    notifyListeners();
  }
}
