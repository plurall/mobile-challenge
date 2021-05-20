import 'dart:convert';

import 'package:mobile_challenge/core/errors/exceptions.dart';
import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

const String CACHED_USERS = 'CACHED_USERS';

abstract class GithubLocalDataSource {
  Future<void> saveUser(UserModel userToCache);
  Future<void> removeUser(String username);
  Future<UserModel> getCachedUser(String username);
  Future<UsersModel> getBookmarkedUsers();
}

class GithubLocalDataSourceImpl implements GithubLocalDataSource {
  final SharedPreferences sharedPreferences;

  GithubLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<void> saveUser(UserModel userToCache) {
    // TODO: implement bookmarkUser
    throw UnimplementedError();
  }

  @override
  Future<void> removeUser(String username) {
    // TODO: implement removeUser
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getCachedUser(String username) {
    final jsonString = sharedPreferences.getString(CACHED_USERS);

    final usersModel = UsersModel.fromJson(json.decode(jsonString));
    final userIndex =
        usersModel.users.indexWhere((element) => element.login == username);

    if (userIndex == -1) throw CacheException();

    return Future.value(usersModel.users[userIndex]);
  }

  @override
  Future<UsersModel> getBookmarkedUsers() {
    final jsonString = sharedPreferences.getString(CACHED_USERS);

    if (jsonString == null) throw CacheException();

    return Future.value(UsersModel.fromJson(json.decode(jsonString)));
  }
}
