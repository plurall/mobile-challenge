import 'dart:async';
import 'package:mobile_challenge/clean/local_data_source.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

abstract class FavoritesLocalDataSourceProtocol {
  Future<List<User>> getFavorites();
  Future<bool> isFavorite(String nickname);
  Future<bool> toggleFavorite(User user);
}

const FILE = "favorites.json";

class FavoritesLocalDataSource extends LocalDataSource
    implements FavoritesLocalDataSourceProtocol {
  @override
  Future<List<User>> getFavorites() async {
    try {
      Map<String, Object> response = await readDb(FILE);

      List<User> users;

      List<Object> jsonUserList = response['users'] as List<Object>;

      jsonUserList.forEach((element) {
        users.add(User.fromJson(element));
      });

      return users;
    } catch (err) {
      return [];
    }
  }

  @override
  Future<bool> isFavorite(String nickname) async {
    try {
      Map<String, Object> response = await readDb(FILE);

      List<Object> jsonUserList = response['users'] as List<Object>;

      jsonUserList.forEach((element) {
        User currentUser = User.fromJson(element);
        if (currentUser.nickname == nickname) {
          return true;
        }
      });

      return false;
    } catch (err) {
      return false;
    }
  }

  @override
  Future<bool> toggleFavorite(User user) async {
    List<Object> jsonUserList;

    try {
      Map<String, Object> response = await readDb(FILE);

      jsonUserList = response['users'] as List<Object>;
    } catch (err) {
      jsonUserList = [];
    }
    bool removed = false;
    bool result = false;
    List<User> users;

    jsonUserList.forEach((element) {
      // Remove if exists
      User currentUser = User.fromJson(element);
      if (currentUser.nickname != user.nickname) {
        users.add(currentUser);
        removed = true;
      }
    });

    if (!removed) {
      users.add(user);
      result = true;
    }

    await writeDb(FILE, {"users": users});

    return result;
  }
}
