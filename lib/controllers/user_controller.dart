import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobile_challenge/core/constants.dart';
import 'package:mobile_challenge/models/user_model.dart';
import 'package:mobile_challenge/repositories/user_repository.dart';
import 'package:mobile_challenge/services/app_service.dart';

class UserController extends ChangeNotifier {
  Status status = Status.idle;
  UserModel userModel;
  bool isFavorite = false;
  Future<void> fetchUser(String username) async {
    try {
      status = Status.fetching;
      notifyListeners();
      var user = await Modular.get<UserRepository>().fetchUser(username);

      userModel = user;
      status = Status.fetched;
      notifyListeners();
      checkUserIsFavorite();
    } catch (e) {
      print(e);
      status = Status.failure;
      notifyListeners();
    }
  }

  Future<void> fetchOfflineUser(String username) async {
    try {
      status = Status.fetching;
      notifyListeners();
      var user = Modular.get<AppService>().getUserFromFavorite(username);

      if (user == null) {
        status = Status.failure;
      } else {
        status = Status.fetched;
        userModel = user;
      }

      notifyListeners();
    } catch (e) {
      print(e);
      status = Status.failure;
      notifyListeners();
    }
  }

  void checkUserIsFavorite() {
    isFavorite = Modular.get<AppService>().hasUserFavorite(userModel);
    notifyListeners();
  }

  void setFavorite() {
    if (userModel == null) return;
    Modular.get<AppService>().favoriteUsers.add(userModel);
    isFavorite = true;
    notifyListeners();
    Modular.get<AppService>().saveToStorage();
  }

  void removeFromFavorite() {
    if (userModel == null) return;
    Modular.get<AppService>()
        .favoriteUsers
        .removeWhere((u) => u.login == userModel.login);
    isFavorite = false;
    notifyListeners();
    Modular.get<AppService>().saveToStorage();
  }
}
