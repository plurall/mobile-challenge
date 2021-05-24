import 'dart:async';
import 'package:mobile_challenge/clean/local_data_source.dart';
import 'package:mobile_challenge/shared/entities/User.dart';

abstract class FavoritesLocalDataSourceProtocol {
  Future<List<User>> getFavorites();
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
}
