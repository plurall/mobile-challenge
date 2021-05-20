import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mobile_challenge/core/errors/exceptions.dart';
import 'package:mobile_challenge/features/github/data/models/user_model.dart';
import 'package:mobile_challenge/features/github/data/models/users_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';

const String CACHED_USERS = 'CACHED_USERS';

abstract class GithubLocalDataSource {
  Future<Unit> saveUser(UserModel userToCache);
  Future<Unit> removeUser(String username);
  Future<UserModel> getCachedUser(String username);
  Future<UsersModel> getBookmarkedUsers();
}

class GithubLocalDataSourceImpl implements GithubLocalDataSource {
  final SharedPreferences sharedPreferences;

  GithubLocalDataSourceImpl({@required this.sharedPreferences});

  UsersModel usersModel = UsersModel(users: []);

  @override
  Future<Unit> saveUser(UserModel userToCache) {
    try {
      getBookmarkedUsers();
    } on CacheException {}

    final userIndex = usersModel.users
        .indexWhere((element) => element.login == userToCache.login);

    if (userIndex != -1) throw UserAlreadyCachedException();

    usersModel.users.add(userToCache);
    sharedPreferences.setString(CACHED_USERS, json.encode(usersModel.toJson()));
    return Future.value(unit);
  }

  @override
  Future<Unit> removeUser(String username) {
    try {
      getBookmarkedUsers();
    } on CacheException {}
    
    final userIndex =
        usersModel.users.indexWhere((element) => element.login == username);

    if (userIndex == -1) throw CacheException();

    usersModel.users.removeAt(userIndex);
    sharedPreferences.setString(CACHED_USERS, json.encode(usersModel.toJson()));
    return Future.value(unit);
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

    usersModel = UsersModel.fromJson(json.decode(jsonString));
    return Future.value(usersModel);
  }
}
