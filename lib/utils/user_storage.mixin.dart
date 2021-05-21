import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_challenge/models/user_storage.model.dart';
import 'package:mobile_challenge/utils/locator.dart';

mixin UserStorageMixin {
  Future<List<UserStorageModel>> readFavoritesUsersList() async {
    final storage = locator<FlutterSecureStorage>();
    final favorites = await storage.read(key: 'favoriteUsers');

    if (favorites != null) {
      final usersStorage = (json.decode(favorites) as List)
          .map((i) => UserStorageModel.fromJson(i))
          .toList();
      return usersStorage;
    }

    return null;
  }

  Future<void> saveToStorage(UserStorageModel user) async {
    final storage = locator<FlutterSecureStorage>();
    final favoriteUsers = await readFavoritesUsersList();
    var userToStore = <UserStorageModel>[];
    if (favoriteUsers != null && favoriteUsers.isNotEmpty)
      userToStore = favoriteUsers;

    userToStore.add(user);

    await storage.write(
      key: 'favoriteUsers',
      value: json.encode(userToStore),
    );
  }

  Future<void> removeToStorage(String login) async {
    final storage = locator<FlutterSecureStorage>();
    final usersSaved = await readFavoritesUsersList();
    final removeUser = usersSaved.firstWhere(
      (item) => item.login == login,
      orElse: () => null,
    );

    if (removeUser != null) {
      usersSaved.remove(removeUser);
    }

    await storage.write(
      key: 'favoriteUsers',
      value: json.encode(usersSaved),
    );
  }
}
