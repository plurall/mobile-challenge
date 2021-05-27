import 'dart:async';
import 'package:mobile_challenge/clean/local_data_source.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

abstract class FavoritesLocalDataSourceProtocol {
  Future<List<User>> getFavorites();
  Future<bool> isFavorite(String nickname);
  Future<User> toggleFavorite(User user);
}

const FILE = "favorites.json";

class FavoritesLocalDataSource extends LocalDataSource
    implements FavoritesLocalDataSourceProtocol {
  @override
  Future<List<User>> getFavorites() async {
    try {
      Map<String, Object> response = await readDb(FILE);

      List<User> users = [];

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

      for (Object jsonUser in jsonUserList) {
        User currentUser = User.fromJson(jsonUser);
        if (currentUser.nickname == nickname) {
          return true;
        }
      }

      return false;
    } catch (err) {
      return false;
    }
  }

  @override
  Future<User> toggleFavorite(User user) async {
    List<Object> jsonUserList = [];

    try {
      Map<String, Object> response = await readDb(FILE);

      if (response.isNotEmpty) {
        jsonUserList = response['users'] as List<Object>;
      }
    } catch (err) {
      jsonUserList = [];
    }

    bool removed = false;
    User result = user;
    List<User> users = [];

    try {
      for (Object jsonUser in jsonUserList) {
        // Remove if exists
        User currentUser = User.fromJson(jsonUser);
        if (currentUser.nickname != user.nickname) {
          users.add(currentUser);
        } else {
          removed = true;
          result.favorite = false;
        }
      }
    } catch (err) {
      print("User Conversion Error");
    }

    if (!removed) {
      users.add(user);
      result.favorite = true;
    }

    await writeDb(FILE, {
      "users": [...users.map((e) => e.toJson())]
    });

    return result;
  }
}
