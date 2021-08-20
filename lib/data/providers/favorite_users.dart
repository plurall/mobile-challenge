import 'package:flutter/material.dart';
import 'package:mobile_challenge/data/model/user_summary.dart';
import 'package:mobile_challenge/utils/utils.dart';

class FavoriteUsersProvider with ChangeNotifier {
  List<UserSummary> _favoriteUsers = [];
  List<UserSummary> get items => _favoriteUsers;

  add(UserSummary user) {
    final isFavoriteUser = Utils.isFavoriteUser(_favoriteUsers, user);
    if (isFavoriteUser)
      _favoriteUsers.remove(user);
    else
      _favoriteUsers.add(user);
    notifyListeners();
  }
}
